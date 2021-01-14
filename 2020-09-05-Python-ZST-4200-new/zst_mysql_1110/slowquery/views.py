from django.shortcuts import render

# Create your views here.

from .models import SlowQuery, SlowQueryHistory
from django.db.models import F, Max, Sum, Value as V
from django.http import HttpResponse



def slowquery_review(request):

    # 代码的优化空间
    start_time = request.GET.get('StartTime')
    end_time = request.GET.get('EndTime')

    if start_time is None or not isinstance(start_time, str) or len(start_time.strip()) == 0:
        start_time = None
    if end_time is None or not isinstance(end_time, str) or len(end_time.strip()) == 0:
        start_time = None

    db_name = request.GET.get('db_name', None)
    limit = request.GET.get('limit', 10)
    offset = request.GET.get('offset', 0)

    limit = limit + offset

    # insname = Db_instance.objects.get(id=int(request.POST.get('instance_id')))

    if db_name:
        # 获取慢查数据, 跨表一对多查询
        slowsql_obj = SlowQuery.objects.filter(
            slowqueryhistory__hostname_max=('{}:{}'.format(insname.host, insname.port)),
            slowqueryhistory__db_max=db_name,
            slowqueryhistory__ts_min__range=(start_time, end_time)
        ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
            CreateTime=Max('slowqueryhistory__ts_max'),
            DBName=Max('slowqueryhistory__db_max'),  # 数据库
            QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
            MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
            MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
            ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
            ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
        )
    else:
        # 获取慢查数据, 跨表一对多查询
        slowsql_obj = SlowQuery.objects.filter(
            slowqueryhistory__hostname_max=('{}:{}'.format(insname.host, insname.port)),
            slowqueryhistory__ts_min__range=(start_time, end_time),
        ).annotate(SQLText=F('fingerprint'), SQLId=F('checksum')).values('SQLText', 'SQLId').annotate(
            CreateTime=Max('slowqueryhistory__ts_max'),
            DBName=Max('slowqueryhistory__db_max'),  # 数据库
            QueryTimeAvg=Sum('slowqueryhistory__query_time_sum') / Sum('slowqueryhistory__ts_cnt'),  # 平均执行时长
            MySQLTotalExecutionCounts=Sum('slowqueryhistory__ts_cnt'),  # 执行总次数
            MySQLTotalExecutionTimes=Sum('slowqueryhistory__query_time_sum'),  # 执行总时长
            ParseTotalRowCounts=Sum('slowqueryhistory__rows_examined_sum'),  # 扫描总行数
            ReturnTotalRowCounts=Sum('slowqueryhistory__rows_sent_sum'),  # 返回总行数
        )

    # SELECT COUNT(*) FROM (SELECT `mysql_slow_query_review`.`fingerprint` AS `SQLText`, `mysql_slow_query_review`.`checksum` AS `SQLId`, MAX(`mysql_slow_query_review_history`.`ts_max`) AS `CreateTime`, MAX(`mysql_slow_query_review_history`.`db_max`) AS `DBName`, (SUM(`mysql_slow_query_review_history`.`Query_time_sum`) / SUM(`mysql_slow_query_review_history`.`ts_cnt`)) AS `QueryTimeAvg`, SUM(`mysql_slow_query_review_history`.`ts_cnt`) AS `MySQLTotalExecutionCounts`, SUM(`mysql_slow_query_review_history`.`Query_time_sum`) AS `MySQLTotalExecutionTimes`, SUM(`mysql_slow_query_review_history`.`Rows_examined_sum`) AS `ParseTotalRowCounts`, SUM(`mysql_slow_query_review_history`.`Rows_sent_sum`) AS `ReturnTotalRowCounts` FROM `mysql_slow_query_review` INNER JOIN `mysql_slow_query_review_history` ON (`mysql_slow_query_review`.`checksum` = `mysql_slow_query_review_history`.`checksum`) WHERE (`mysql_slow_query_review_history`.`hostname_max` = '192.168.0.54:3306' AND `mysql_slow_query_review_history`.`ts_min` BETWEEN '2019-05-08 00:00:00' AND '2019-12-19 00:00:00') GROUP BY `mysql_slow_query_review`.`checksum` ORDER BY NULL) subquery; args=('192.168.0.54:3306', '2019-05-08 00:00:00', '2019-12-19 00:00:00')
    # SELECT `mysql_slow_query_review`.`fingerprint` AS `SQLText`, `mysql_slow_query_review`.`checksum` AS `SQLId`, MAX(`mysql_slow_query_review_history`.`ts_max`) AS `CreateTime`, MAX(`mysql_slow_query_review_history`.`db_max`) AS `DBName`, (SUM(`mysql_slow_query_review_history`.`Query_time_sum`) / SUM(`mysql_slow_query_review_history`.`ts_cnt`)) AS `QueryTimeAvg`, SUM(`mysql_slow_query_review_history`.`ts_cnt`) AS `MySQLTotalExecutionCounts`, SUM(`mysql_slow_query_review_history`.`Query_time_sum`) AS `MySQLTotalExecutionTimes`, SUM(`mysql_slow_query_review_history`.`Rows_examined_sum`) AS `ParseTotalRowCounts`, SUM(`mysql_slow_query_review_history`.`Rows_sent_sum`) AS `ReturnTotalRowCounts` FROM `mysql_slow_query_review` INNER JOIN `mysql_slow_query_review_history` ON (`mysql_slow_query_review`.`checksum` = `mysql_slow_query_review_history`.`checksum`) WHERE (`mysql_slow_query_review_history`.`hostname_max` = '192.168.0.54:3306' AND `mysql_slow_query_review_history`.`ts_min` BETWEEN '2019-05-08 00:00:00' AND '2019-12-19 00:00:00') GROUP BY `mysql_slow_query_review`.`checksum` ORDER BY `MySQLTotalExecutionCounts` DESC LIMIT 2; args=('192.168.0.54:3306', '2019-05-08 00:00:00', '2019-12-19 00:00:00')


    slow_sql_count = slowsql_obj.count()
    slow_sql_list = slowsql_obj.order_by('-MySQLTotalExecutionCounts')[offset:limit]  # 执行总次数倒序排列

    # QuerySet 序列化
    sql_slow_log = [SlowLog for SlowLog in slow_sql_list]
    result = {"total": slow_sql_count, "rows": sql_slow_log}


    # 返回查询结果
    return HttpResponse(json.dumps(result, cls=RewriteJsonEncoder),
                        content_type='application/json')