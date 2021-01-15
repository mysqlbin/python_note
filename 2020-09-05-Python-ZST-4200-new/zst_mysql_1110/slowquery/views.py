from django.shortcuts import render

# Create your views here.

from .models import SlowQuery, SlowQueryHistory
from django.db.models import F, Max, Sum, Value as V
from django.http import HttpResponse
import json
from common.utils.rewrite_json_encoder import RewriteJsonEncoder
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage, InvalidPage
from django.db.models.functions import Concat


# 慢日志聚合列表
def slowquery_aggr(request):

    # 代码优化的空间

    # start_time = request.GET.get('startTime', '2020-09-01 00:00:00')
    # end_time = request.GET.get('endTime', '2020-09-08 00:00:00')

    start_time = request.GET.get('start')
    end_time = request.GET.get('end')

    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = None
    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        end_time = None

    instance = request.GET.get('instance', None)

    if instance is None or not isinstance(instance, str) or len(instance.strip()) == 0:
        instance = None

    # 每页大小
    page_size = request.GET.get('page_size', 10)
    # 第几页
    page_num = request.GET.get('page_num', 1)



    if instance:
        # 获取慢查数据, 跨表一对多查询
        slowsql_obj = SlowQuery.objects.filter(
            slowqueryhistory__hostname_max=instance,
            slowqueryhistory__ts_min__range=(start_time, end_time)
        ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
            CreateTime=Max('slowqueryhistory__ts_max'),
            DBName=Max('slowqueryhistory__db_max'),  # 数据库
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
            # slowqueryhistory__hostname_max=('{}:{}'.format(insname.host, insname.port)),
            slowqueryhistory__ts_min__range=(start_time, end_time),
        ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
            CreateTime=Max('slowqueryhistory__ts_max'),
            DBName=Max('slowqueryhistory__db_max'),  # 数据库
            MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
            MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
            QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
            ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
            ParseRowAvg=Sum('slowqueryhistory__rows_examined_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均扫描行数
            ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
            ReturnRowAvg=Sum('slowqueryhistory__rows_sent_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均返回行数
        )

    # SELECT COUNT(*) FROM (SELECT `mysql_slow_query_review`.`fingerprint` AS `SQLText`, `mysql_slow_query_review`.`checksum` AS `SQLId`, MAX(`mysql_slow_query_review_history`.`ts_max`) AS `CreateTime`, MAX(`mysql_slow_query_review_history`.`db_max`) AS `DBName`, (SUM(`mysql_slow_query_review_history`.`Query_time_sum`) / SUM(`mysql_slow_query_review_history`.`ts_cnt`)) AS `QueryTimeAvg`, SUM(`mysql_slow_query_review_history`.`ts_cnt`) AS `MySQLTotalExecutionCounts`, SUM(`mysql_slow_query_review_history`.`Query_time_sum`) AS `MySQLTotalExecutionTimes`, SUM(`mysql_slow_query_review_history`.`Rows_examined_sum`) AS `ParseTotalRowCounts`, SUM(`mysql_slow_query_review_history`.`Rows_sent_sum`) AS `ReturnTotalRowCounts` FROM `mysql_slow_query_review` INNER JOIN `mysql_slow_query_review_history` ON (`mysql_slow_query_review`.`checksum` = `mysql_slow_query_review_history`.`checksum`) WHERE (`mysql_slow_query_review_history`.`hostname_max` = '192.168.0.54:3306' AND `mysql_slow_query_review_history`.`ts_min` BETWEEN '2019-05-08 00:00:00' AND '2019-12-19 00:00:00') GROUP BY `mysql_slow_query_review`.`checksum` ORDER BY NULL) subquery; args=('192.168.0.54:3306', '2019-05-08 00:00:00', '2019-12-19 00:00:00')
    # SELECT `mysql_slow_query_review`.`fingerprint` AS `SQLText`, `mysql_slow_query_review`.`checksum` AS `SQLId`, MAX(`mysql_slow_query_review_history`.`ts_max`) AS `CreateTime`, MAX(`mysql_slow_query_review_history`.`db_max`) AS `DBName`, (SUM(`mysql_slow_query_review_history`.`Query_time_sum`) / SUM(`mysql_slow_query_review_history`.`ts_cnt`)) AS `QueryTimeAvg`, SUM(`mysql_slow_query_review_history`.`ts_cnt`) AS `MySQLTotalExecutionCounts`, SUM(`mysql_slow_query_review_history`.`Query_time_sum`) AS `MySQLTotalExecutionTimes`, SUM(`mysql_slow_query_review_history`.`Rows_examined_sum`) AS `ParseTotalRowCounts`, SUM(`mysql_slow_query_review_history`.`Rows_sent_sum`) AS `ReturnTotalRowCounts` FROM `mysql_slow_query_review` INNER JOIN `mysql_slow_query_review_history` ON (`mysql_slow_query_review`.`checksum` = `mysql_slow_query_review_history`.`checksum`) WHERE (`mysql_slow_query_review_history`.`hostname_max` = '192.168.0.54:3306' AND `mysql_slow_query_review_history`.`ts_min` BETWEEN '2019-05-08 00:00:00' AND '2019-12-19 00:00:00') GROUP BY `mysql_slow_query_review`.`checksum` ORDER BY `MySQLTotalExecutionCounts` DESC LIMIT 2; args=('192.168.0.54:3306', '2019-05-08 00:00:00', '2019-12-19 00:00:00')

    slow_sql_list = slowsql_obj.order_by('-MySQLTotalExecutionCounts')# 执行总次数倒序排列

    # 将数据按照规定每页显示 10 条, 进行分割
    paginator = Paginator(slow_sql_list, page_size)
    try:
        result = paginator.page(page_num)
    except EmptyPage:
        # 如果请求的页数不在合法的页数范围内，返回结果的最后一页。
        result = paginator.page(paginator.num_pages)

    # QuerySet 序列化，返回查询结果
    result = [SlowLog for SlowLog in result]
    result = {"total": paginator.count, "rows": result}
    respJson = json.dumps(result, cls=RewriteJsonEncoder)

    return HttpResponse(respJson, content_type='application/json')


# 慢日志明细
def slowquery_history(request):

    # start_time = request.GET.get('starts', '2020-09-01 00:00:00')
    # end_time = request.GET.get('ends', '2020-09-08 00:00:00')

    start_time = request.GET.get('start')
    end_time = request.GET.get('end')

    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = None
    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        end_time = None

    schema = request.GET.get('schema', None)

    print(schema)
    if schema is None or not isinstance(schema, str) or len(schema.strip()) == 0:
        schema = None

    # 每页大小
    page_size = request.GET.get('page_size', 10)
    # 第几页
    page_num = request.GET.get('page_num', 1)

    # checksum
    sql_id = request.GET.get('SQLId')
    print(sql_id)
    instance = request.GET.get('instance', None)

    if instance is None or not isinstance(instance, str) or len(instance.strip()) == 0:
        instance = None


    if sql_id:
        print(33333)
        # 获取慢查明细数据
        slow_sql_record_obj = SlowQueryHistory.objects.filter(
            # hostname_max=instance,
            checksum=sql_id,
            ts_min__range=(start_time, end_time)
        ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                   DBName=F('db_max'),  # 数据库名
                   HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')),  # 用户名
                   SQLText=F('sample'),  # SQL语句
                   TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                   QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句95%耗时
                   QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                   LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                   ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                   ReturnRowCounts=F('rows_sent_sum')  # 本次统计该sql语句返回总行数
                   )
    else:
        if instance:
            # 获取慢查明细数据
            slow_sql_record_obj = SlowQueryHistory.objects.filter(
                hostname_max=instance,
                ts_min__range=(start_time, end_time)
            ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       ExecutionEndTime=F('ts_max'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       DBName=F('db_max'),  # 数据库名
                       HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')), # 用户名
                       SQLText=F('sample'),  # SQL语句
                       TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                       QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句出现的次数
                       QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                       LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                       ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                       ReturnRowCounts=F('rows_sent_sum')  # 本次统计该sql语句返回总行数
                       )
        else:
            # 获取慢查明细数据
            slow_sql_record_obj = SlowQueryHistory.objects.filter(
                ts_min__range=(start_time, end_time)
            ).annotate(ExecutionStartTime=F('ts_min'),  # 本次统计(每5分钟一次)该类型sql语句出现的最小时间
                       ExecutionEndTime=F('ts_max'),  # 本次统计(每5分钟一次)该类型sql语句出现的最大时间
                       DBName=F('db_max'),  # 数据库名
                       HostAddress=Concat(V('\''), 'user_max', V('\''), V('@'), V('\''), 'client_max', V('\'')), # 用户名
                       SQLText=F('sample'),  # SQL语句
                       TotalExecutionCounts=F('ts_cnt'),  # 本次统计该sql语句出现的次数
                       QueryTimePct95=F('query_time_pct_95'),  # 本次统计该sql语句95%耗时
                       QueryTimes=F('query_time_sum'),  # 本次统计该sql语句花费的总时间(秒)
                       LockTimes=F('lock_time_sum'),  # 本次统计该sql语句锁定总时长(秒)
                       ParseRowCounts=F('rows_examined_sum'),  # 本次统计该sql语句解析总行数
                       ReturnRowCounts=F('rows_sent_sum')  # 本次统计该sql语句返回总行数
                       )


    slow_sql_list = slow_sql_record_obj.values('ExecutionStartTime',
                                       'DBName',
                                        'HostAddress',
                                        'SQLText',
                                        'TotalExecutionCounts',
                                        'QueryTimePct95',
                                        'QueryTimes',
                                        'LockTimes',
                                        'ParseRowCounts',
                                        'ReturnRowCounts').order_by('-ExecutionStartTime')  # 执行总次数倒序排列

    # 将数据按照规定每页显示 10 条, 进行分割
    paginator = Paginator(slow_sql_list, page_size)
    try:
        result = paginator.page(page_num)
    except EmptyPage:
        # 如果请求的页数不在合法的页数范围内，返回结果的最后一页。
        result = paginator.page(paginator.num_pages)

    # QuerySet 序列化，返回查询结果
    result = [SlowLog for SlowLog in result]
    result = {"total": paginator.count, "rows": result}
    respJson = json.dumps(result, cls=RewriteJsonEncoder)

    return HttpResponse(respJson, content_type='application/json')