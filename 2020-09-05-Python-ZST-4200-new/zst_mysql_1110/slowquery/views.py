from django.shortcuts import render

# Create your views here.

from .models import SlowQuery, SlowQueryHistory
from django.db.models import F, Max, Sum, Value as V
from django.http import HttpResponse,JsonResponse
import json
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage, InvalidPage
from django.db.models.functions import Concat
from django.utils.timezone import utc
from django.utils.timezone import localtime
import datetime
import time

def format_utc_time(current_time):
    format_time = current_time.split('+')[0]
    format_time = format_time.replace("T", " ")
    return format_time


def format_utc_time_by_day(current_time):
    format_time = current_time.split('T')[0]
    return format_time

# 慢日志top10
def get_top10_sql(request):

    result = {'status': 2000, 'msg': 'ok', 'data': {}}

    current_date = time.strftime("%Y-%m-%d")
    default_start_time = datetime.datetime.strptime(current_date, '%Y-%m-%d') + datetime.timedelta(days=-91)
    default_end_time = time.strftime("%Y-%m-%d 23:59:59")

    start_time = request.GET.get('start')
    end_time = request.GET.get('end')
    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = default_start_time
    else:
        start_time = format_utc_time_by_day(start_time)
        start_time = '{}{}'.format(start_time, ' 00:00:00')

    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        end_time = default_end_time
    else:
        end_time = format_utc_time_by_day(end_time)
        end_time = '{}{}'.format(end_time, ' 23:59:59')

    slowquery_ojb = SlowQuery.objects.filter(
            slowqueryhistory__ts_min__range=(start_time, end_time)
        ).values('slowqueryhistory__hostname_max', 'slowqueryhistory__checksum').annotate(
                MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),
                FingerPrint=F('fingerprint'),
                HostnameMax=F('slowqueryhistory__hostname_max'),
                SQLId=F('slowqueryhistory__checksum')
        ).order_by("-MySQLTotalExecutionCounts")[:10]

    result['data'] = [SlowLog for SlowLog in slowquery_ojb]
    result['date'] = {
        "start": start_time,
        "end": end_time,
    }
    return JsonResponse(result)



# 每个实例慢日志数量的饼状图
def get_aggs_by_instance(request):

    result = {'status': 2000, 'msg': 'ok', 'data': {}}

    current_date = time.strftime("%Y-%m-%d")
    default_start_time = datetime.datetime.strptime(current_date, '%Y-%m-%d') + datetime.timedelta(days=-91)
    default_end_time = time.strftime("%Y-%m-%d 23:59:59")

    start_time = request.GET.get('start')
    end_time = request.GET.get('end')
    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = default_start_time
    else:
        start_time = format_utc_time_by_day(start_time)
        start_time = '{}{}'.format(start_time, ' 00:00:00')

    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        end_time = default_end_time
    else:
        end_time = format_utc_time_by_day(end_time)
        end_time = '{}{}'.format(end_time, ' 23:59:59')

    slowquery_ojb = SlowQueryHistory.objects.filter(ts_min__range=(start_time, end_time)
                                    ).values("hostname_max").annotate(instance_slow_count=Sum('ts_cnt'))


    result['data'] = [SlowLog for SlowLog in slowquery_ojb]
    return JsonResponse(result)


# 用来画每天的慢日志数据曲线图，最多显示最近3个月的数据
def get_aggs_by_date(request):

    result = {'status': 2000, 'msg': 'ok', 'data': {}}
    current_date = time.strftime("%Y-%m-%d")
    start_time = datetime.datetime.strptime(current_date, '%Y-%m-%d') + datetime.timedelta(days=-91)

    end_time = time.strftime("%Y-%m-%d 23:59:59")
    slowquery_ojb = SlowQueryHistory.objects.filter(ts_min__range=(start_time, end_time)
                                                    ).extra(
        select={"byday": "DATE_FORMAT(ts_min, '%%Y-%%m-%%d')"}).values("byday").annotate(
        date_count=Sum('ts_cnt')).order_by('byday')  # 执行总次数倒序排列

    result['data'] = [SlowLog for SlowLog in slowquery_ojb]
    return JsonResponse(result)



# 慢日志聚合列表
def slowquery_aggr(request):

    result = {'status': 2000, 'msg': 'ok', 'data': {}}

    # 代码优化的空间

    start_time = request.GET.get('start')
    end_time = request.GET.get('end')

    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = None
    else:
        start_time = format_utc_time(start_time)

    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        end_time = None
    else:
        end_time = format_utc_time(end_time)
        
    instance = request.GET.get('instance')
    if instance is None or not isinstance(instance, str) or len(instance.strip()) == 0:
        instance = None

    sql_id = request.GET.get('sqlid')

    # 每页大小
    page_size = request.GET.get('page_size', 10)
    # 第几页
    page_num = request.GET.get('page_num', 1)

    if sql_id:
        if instance:
            slowsql_obj = SlowQuery.objects.filter(
                slowqueryhistory__hostname_max=instance,
                slowqueryhistory__checksum=sql_id,
                slowqueryhistory__ts_min__range=(start_time, end_time)
            ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
                CreateTime=Max('slowqueryhistory__ts_max'),
                HostnameMax=Max('slowqueryhistory__hostname_max'),  # 数据库
                MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
                MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
                QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
                ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
                ParseRowAvg=Sum('slowqueryhistory__rows_examined_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均扫描行数
                ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
                ReturnRowAvg=Sum('slowqueryhistory__rows_sent_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均返回行数
            )
        else:
            slowsql_obj = SlowQuery.objects.filter(
                slowqueryhistory__checksum=sql_id,
                slowqueryhistory__ts_min__range=(start_time, end_time),
            ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
                CreateTime=Max('slowqueryhistory__ts_max'),
                HostnameMax=Max('slowqueryhistory__hostname_max'),  # 数据库
                MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
                MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
                QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
                ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
                ParseRowAvg=Sum('slowqueryhistory__rows_examined_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均扫描行数
                ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
                ReturnRowAvg=Sum('slowqueryhistory__rows_sent_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均返回行数
            )

    elif instance:
        # 获取慢查数据, 跨表一对多查询
        slowsql_obj = SlowQuery.objects.filter(
            slowqueryhistory__hostname_max=instance,
            slowqueryhistory__ts_min__range=(start_time, end_time),
        ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
            CreateTime=Max('slowqueryhistory__ts_max'),
            HostnameMax=Max('slowqueryhistory__hostname_max'),  # 数据库
            MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
            MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
            QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
            ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
            ParseRowAvg=Sum('slowqueryhistory__rows_examined_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均扫描行数
            ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
            ReturnRowAvg=Sum('slowqueryhistory__rows_sent_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均返回行数
        )
    else:
        # 获取慢查数据, 跨表一对多查询
        slowsql_obj = SlowQuery.objects.filter(
            slowqueryhistory__ts_min__range=(start_time, end_time),
        ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
            CreateTime=Max('slowqueryhistory__ts_max'),
            HostnameMax=Max('slowqueryhistory__hostname_max'),  # 数据库
            MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
            MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
            QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
            ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
            ParseRowAvg=Sum('slowqueryhistory__rows_examined_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均扫描行数
            ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
            ReturnRowAvg=Sum('slowqueryhistory__rows_sent_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均返回行数
        )

    slowquery_ojb = slowsql_obj.order_by('-MySQLTotalExecutionCounts')# 执行总次数倒序排列

    # 将数据按照规定每页显示 10 条, 进行分割
    paginator = Paginator(slowquery_ojb, page_size)
    try:
        data = paginator.page(page_num)
    except EmptyPage:
        # 如果请求的页数不在合法的页数范围内，返回结果的最后一页。
        data = paginator.page(paginator.num_pages)
    result['total'] = paginator.count
    result['data'] = [SlowLog for SlowLog in data]
    return JsonResponse(result)


# 慢日志明细
def slowquery_history(request):

    result = {'status': 2000, 'msg': 'ok', 'data': {}}

    start_time = request.GET.get('start')
    end_time = request.GET.get('end')
    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = None
    else:
        start_time = format_utc_time(start_time)

    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        end_time = None
    else:
        end_time = format_utc_time(end_time)

    sql_id = request.GET.get('sqlid')
    instance = request.GET.get('instance', None)
    if instance is None or not isinstance(instance, str) or len(instance.strip()) == 0:
        instance = None

    # 每页大小
    page_size = request.GET.get('page_size', 10)
    # 第几页
    page_num = request.GET.get('page_num', 1)


    if sql_id:
        if instance:
            # 获取慢查明细数据
            slow_sql_record_obj = SlowQueryHistory.objects.filter(
                hostname_max=instance,
                checksum=sql_id,
                ts_min__range=(start_time, end_time)
            ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       HostnameMax=F('hostname_max'),  # 实例名称
                       HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')),  # 用户名
                       SQLText=F('sample'),  # SQL语句
                       TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                       QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句95%耗时
                       QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                       LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                       ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                       ReturnRowCounts=F('rows_sent_sum'),  # 本次统计该sql语句返回总行数
                       SQLId=F('checksum')
                       )
        else:
            # 获取慢查明细数据
            slow_sql_record_obj = SlowQueryHistory.objects.filter(
                checksum=sql_id,
                ts_min__range=(start_time, end_time)
            ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       HostnameMax=F('hostname_max'),  # 实例名称
                       HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')),  # 用户名
                       SQLText=F('sample'),  # SQL语句
                       TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                       QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句95%耗时
                       QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                       LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                       ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                       ReturnRowCounts=F('rows_sent_sum'),  # 本次统计该sql语句返回总行数
                       SQLId=F('checksum')
                       )

    else:
        if instance:
            # 获取慢查明细数据
            slow_sql_record_obj = SlowQueryHistory.objects.filter(
                hostname_max=instance,
                ts_min__range=(start_time, end_time)
            ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       ExecutionEndTime=F('ts_max'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       HostnameMax=F('hostname_max'),  # 实例名称
                       HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')), # 用户名
                       SQLText=F('sample'),  # SQL语句
                       TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                       QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句出现的次数
                       QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                       LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                       ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                       ReturnRowCounts=F('rows_sent_sum'),  # 本次统计该sql语句返回总行数
                       SQLId=F('checksum')
                       )
        else:
            # 获取慢查明细数据
            slow_sql_record_obj = SlowQueryHistory.objects.filter(
                ts_min__range=(start_time, end_time)
            ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       ExecutionEndTime=F('ts_max'),  # 本次统计(每5分钟一次)该类型sql语句出现的最大时间
                       HostnameMax=F('hostname_max'),  # 数据库名
                       HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')), # 用户名
                       SQLText=F('sample'),  # SQL语句
                       TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                       QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句95%耗时
                       QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                       LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                       ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                       ReturnRowCounts=F('rows_sent_sum'),  # 本次统计该sql语句返回总行数
                       SQLId=F('checksum')
                       )

    slow_sql_list = slow_sql_record_obj.values('ExecutionStartTime',
                                        'HostnameMax',
                                        'HostAddress',
                                        'SQLText',
                                        'TotalExecutionCounts',
                                        'QueryTimePct95',
                                        'QueryTimes',
                                        'LockTimes',
                                        'ParseRowCounts',
                                        'ReturnRowCounts',
                                        'SQLId').order_by('-ExecutionStartTime')  # 执行总次数倒序排列

    # 将数据按照规定每页显示 10 条, 进行分割
    paginator = Paginator(slow_sql_list, page_size)
    try:
        data = paginator.page(page_num)
    except EmptyPage:
        # 如果请求的页数不在合法的页数范围内，返回结果的最后一页。
        data = paginator.page(paginator.num_pages)

    result['total'] = paginator.count
    result['data'] = [SlowLog for SlowLog in data]
    return JsonResponse(result)

