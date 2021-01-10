from elasticsearch_dsl import Document, Date, Integer, Keyword, Text, GeoPoint, Boolean, Long, Float  # 这些都是类型
import json

# class SlowQuery(Document):
#     finger = Text(fields={'raw': Keyword()})
#     host = Text(fields={'raw': Keyword()})
#     lock_time = Float()
#     query_sql = Text(fields={'raw': Keyword()})
#     query_time = Float()
#     rows_examined = Long()
#     rows_sent = Long()
#     user = Text(fields={'raw': Keyword()})
#     schema = Text(fields={'raw': Keyword()})

class SlowQuery(Document):
    finger = Text(fields={'raw': Keyword()})
    host = Text(fields={'raw': Keyword()})
    slowlog_lock_time_sec = Float()
    slowlog_query = Text(fields={'raw': Keyword()})
    slowlog_query_time_sec = Float()
    slowlog_rows_examined = Long()
    slowlog_rows_sent = Long()
    user = Text(fields={'raw': Keyword()})
    schema = Text(fields={'raw': Keyword()})


    class Index:
    # 声明使用哪个索引
    #     name = 'mysql-slowsql-test-2021-01-05'
    #     name = 'mysql-slowsql-test-*'
    #     name = 'mysql-slowsql-test-2020-11-10'
        name = 'mysql-slowlog-*'
