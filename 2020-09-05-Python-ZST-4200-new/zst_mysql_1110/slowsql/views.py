from django.shortcuts import render
from rest_framework import viewsets
from django.http.response import HttpResponse
from rest_framework.response import Response

from slowsql.esmodel import SlowQuery
from elasticsearch_dsl import Q,A
# Create your views here.
from rest_framework.pagination import PageNumberPagination
from rest_framework.decorators import action


class CustomPagination(PageNumberPagination):
    # 每页显示记录数，前端没有传入page_num，则默认显示此参数
    page_size = 10
    page_size_query_param = 'page_size'
    page_query_param = 'page_num'
    max_page_size = 500


def build_aggs(agg):
    for k in agg.keys():
        if k != "aggs":
            options = agg.get(k)
            return A(k, **options)


def get_aggs(agg, d):
    if 'aggs' not in d.keys():
        return

    aggs = d.get('aggs')
    if len(aggs.keys()) > 1:
        for metric_name in aggs.keys():
            agg = agg.metric(metric_name, build_aggs(aggs.get(metric_name)))
    elif len(aggs.keys()) == 1:
        k = list(aggs.keys())[0]
        agg = agg.bucket(k, build_aggs(aggs.get(k)))
        get_aggs(agg, aggs.get(k))


def get_results(agg_query, result):
    if 'aggs' not in agg_query.keys():
        return {}

    aggs = agg_query.get('aggs')
    if len(aggs.keys()) == 1:
        key_name = list(aggs.keys())[0]
        bucket_results = []
        for bucket in result[key_name]['buckets']:
            doc_count = 0
            key_val = ''
            if 'key_as_string' in bucket:
                key_val = bucket.key_as_string
            elif 'key' in bucket:
                key_val = bucket.key
            else:
                raise Exception('no key found in bucket')
            if 'doc_count' in bucket:
                doc_count = bucket.doc_count
            ret = get_results(aggs[key_name], bucket)
            if isinstance(ret, list):
                for r in ret:
                    r[key_name + "_count"] = doc_count
                    r[key_name] = key_val
                bucket_results.extend(ret)
            elif isinstance(ret, dict):
                ret[key_name] = key_val
                ret[key_name + "_count"] = doc_count
                bucket_results.append(ret)
        return bucket_results
    else:
        ret = {}
        for key_name in aggs.keys():
            if 'value' in result[key_name]:
                val = result[key_name]['value']
                ret[key_name] = val
            elif list(aggs[key_name].keys())[0] == 'top_hits':
                print(result[key_name])
                hits = result[key_name]['hits']['hits']
                if len(hits) > 0:
                    for source_field in hits[0]['_source']:
                        ret[source_field] = hits[0]['_source'][source_field]

        return ret

class SlowSqlViewSet(viewsets.ViewSet):

    @action(detail=False, methods=['get'])
    # 每个schema慢日志数量的饼状图
    def get_aggs_by_schema(self, request, *args, **kwargs):
        s = self.get_query_by_params(request)
        # 根据schema做聚合
        aggs = {
            "aggs":
                {
                "schema": {
                    "terms": {
                        "field": "schema.keyword"
                    }
                }
            }
        }
        get_aggs(s.aggs, aggs)

        result = s.execute().aggregations

        rs = get_results(aggs, result)
        return Response(rs)

    @action(detail=False, methods=['get'])
    # 用来画每天的慢日志数据曲线图
    def get_aggs_by_date(self, request, *args, **kwargs):
        s = self.get_query_by_params(request, sorts="@timestamp")
        aggs = {
            "aggs": {
                "date": {
                    "date_histogram": {
                        "field": "@timestamp",
                        "calendar_interval": 'day'
                    }
                }
            }
        }
        get_aggs(s.aggs, aggs)

        result = s.execute().aggregations

        rs = get_results(aggs, result)
        return Response(rs)

    # print(1)
    @action(detail=False, methods=['get'])
    # 慢日志top10
    def get_top10_sql(self, request, *args, **kwargs):
        s = self.get_query_by_params(request)
        composite = A('terms', script="doc['schema.keyword'].value+'#'+doc['hash.keyword'].value", size=10)
        s.aggs.bucket('sql', composite).bucket('finger', A('top_hits', _source=["finger"], size=1))
        aggs = s.execute().aggregations
        results = []
        for bucket in aggs.sql.buckets:
            k = bucket.key
            keys = k.split('#')
            data = {
                "schema": keys[0],
                "hash": keys[1],
                "count": bucket.doc_count,
                "finger": bucket.finger.hits.hits[0]['_source']['finger']
            }
            results.append(data)

        return Response(results)

    # 通用获取参数
    def get_query_by_params(self, request, sorts=None):
        start = request.query_params.get('start')
        end = request.query_params.get('end')
        s = SlowQuery.search()
        if start is None or not isinstance(start, str) or len(start.strip()) == 0:
            start = None
        if end is None or not isinstance(end, str) or len(end.strip()) == 0:
            end = None

        if start is not None and end is not None:
            options = {
                # greater or equal than  -> gte 大于等于
                # greater than  -> gt 大于
                # little or equal thant -> lte 小于或等于
                'gte': start,
                'lte': end
            }
            print(options)
            s = s.filter('range', **{'@timestamp': options})


        sorts = request.query_params.get('sorts', sorts)
        if isinstance(sorts, str) and len(sorts) > 0:
            sorts = [item.strip() for item in sorts.split(",") if len(item.strip()) > 0]
            s = s.sort(*sorts)
        else:
            s = s.sort('-@timestamp')
        return s

    def list(self, request, *args, **kwargs):

        # 入参： 开始时间、结束时间、库名、第几页、每页多少个
        start = request.query_params.get('start')
        end = request.query_params.get('end')
        schema = request.query_params.get('schema', None)
        hash = request.query_params.get('hash', None)

        is_aggr_by_hash = request.query_params.get('is_aggr_by_hash', False)
        if isinstance(is_aggr_by_hash, str) and is_aggr_by_hash.lower() == 'true':
            is_aggr_by_hash = True
        else:
            is_aggr_by_hash = False

        interval = request.query_params.get('interval', '1d')


        s = SlowQuery.search()
        if schema is not None and len(schema) > 0:
            s = s.filter('term', schema__keyword=schema)

        if hash is not None and len(hash) > 0:
            s = s.filter('term', hash=hash)

        if start is not None and end is not None:
            options = {
                'gte': start,
                'lte': end
            }
            s = s.filter('range', **{'@timestamp': options})
        s = s.sort('-@timestamp')

        paginator = CustomPagination()

        if is_aggr_by_hash:
            aggs = {
                "aggs": {
                    "date": {
                        "date_histogram": {
                            "field": "@timestamp",
                            "calendar_interval": interval
                        },
                        "aggs": {
                            "schema": {
                                "terms": {
                                    "field": "schema.keyword"
                                },
                                "aggs": {
                                    "hash": {
                                        "terms": {
                                            "field": "hash.keyword"
                                        },
                                        "aggs": {
                                            "rowsSentAvg": {
                                                "avg": {
                                                    "field": "slowlog_rows_sent"
                                                }
                                            },
                                            "rowsExamineAvg": {
                                                "avg": {
                                                    "field": "slowlog_rows_examined"
                                                }
                                            },
                                            "queryTimeAvg": {
                                                "avg": {
                                                    "field": "slowlog_query_time_sec"
                                                }
                                            },
                                            "queryTimeSum": {
                                                "sum": {
                                                    "field": "slowlog_query_time_sec"
                                                }
                                            },
                                            "sql": {
                                                "top_hits": {
                                                    "_source": [
                                                        "finger",
                                                        "@timestamp"
                                                    ],
                                                    "sort": [
                                                        {
                                                            "@timestamp": {
                                                                "order": "desc"
                                                            }
                                                        }
                                                    ],
                                                    "size": 1
                                                }
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            # 这一步要看看
            get_aggs(s.aggs, aggs)

            result = s.execute().aggregations

            # 这一步也要看看
            rs = get_results(aggs, result)

        if is_aggr_by_hash:
            data = paginator.paginate_queryset(rs, request)
        else:
            data = paginator.paginate_queryset(s, request)
            data = [q.to_dict() for q in data]

        # data = paginator.paginate_queryset(s, request)
        # data = [q.to_dict() for q in data]

        return paginator.get_paginated_response(data)

        # return Response('success')

    @action(detail=False, methods=['get'])
    def es_test(self, request):
        # print(1)
        # return HttpResponse(1)
        s = SlowQuery.search()

        # 查询所有的数据
        # result = s.scan()

        # 等值查询
        # result = s.filter('term', schema__keyword='Ena').scan()

        # 排序
        # result = s.sort('-@timestamp')

        # 指定范围
        # from_date = '2020-12-20T00:00:00'
        # to_date = '2020-12-21T00:00:00'
        # options = {
        #     'gte': from_date,
        #     'lte': to_date
        # }
        # result = s.filter('range', **{'@timestamp': options}).execute()

        #
        # result = s.filter('wildcard', schema__keyword='*An*').scan()

        # result = s.filter('prefix', schema__keyword='L').scan()

        # result = s.filter('match', query_sql='abc cda').scan()
        # result = s.filter('match', query_sql='abc urtaevhwcz').scan()

        # result = s.filter('match', query_sql='T_computer').filter('term', schema__keyword='Cna').scan()

        q = Q("match", query_sql='T_computer') | Q("term", schema__keyword="Cna")

        result = s.filter(q).scan()

        # result = s.sort('-@timestamp', 'rows_examined')


        # 一层聚合数据: 简单的一个根据日期聚合的

        # 查询语句
        timeAggs = A('date_histogram', field='@timestamp', fixed_interval="1d")

        # 'date' 为分组的名称
        s.aggs.bucket('date', timeAggs)

        # 获取数据
        aggs = s.execute().aggregations

        # 这里要 debugger 一下，然后才知道怎么取数据 
        print(aggs)

        for date_item in aggs['date'].buckets:
            print(date_item)



        # for i in result:
        #     # print(i)
        #     print(i.to_dict(include_meta=True))
        return Response('success')



        """

        # 多层聚合数据
        s = SlowQuery.search()

        s = s.sort('-@timestamp')

        timeAggs = A('date_histogram', field='@timestamp',
                     fixed_interval="1d")

        schemaAggs = A('terms', field='schema.keyword')

        hashFingerAggs = A('terms', field='hash.keyword')

        rowsExaminedAvg = A('avg', field='rows_examined')
        queryTimeAvg = A('avg', field='query_time_sec')

        s.aggs.bucket('date', timeAggs)\
            .bucket('schema', schemaAggs)\
            .bucket('hash', hashFingerAggs)
            # .metric('rowsExaminedAvg',rowsExaminedAvg)\
            # .metric('queryTimeAvg', queryTimeAvg)

        aggs = s.execute().aggregations

        print(aggs['date'])

        for date_buckets in aggs['date'].buckets:
            print("date_buckets: ", date_buckets)

            for schema_buckets in date_buckets['schema'].buckets:
                print("schema_buckets: ", schema_buckets)

                for hash_buckets in schema_buckets['hash'].buckets:
                    print("hash_buckets: ", hash_buckets)
        """


def send_with_matplotlib(request):

    s = SlowQuery.search()
    options = {
        # greater or equal than  -> gte 大于等于
        # greater than  -> gt 大于
        # little or equal thant -> lte 小于或等于
        'gte': '2020-12-22T00:00:00.000Z',
        'lte': '2021-01-21T00:00:00.000Z'
    }
    s = s.filter('range', **{'@timestamp': options})
    aggs = {
        "aggs": {
            "date": {
                "date_histogram": {
                    "field": "@timestamp",
                    "calendar_interval": "day"
                },
                "aggs": {
                    "avg_query_time": {
                        "avg": {
                            "field": "query_time"
                        }
                    },
                    "avg_lock_time": {
                        "avg": {
                            "field": "lock_time"
                        }
                    }
                }
            }
        }
    }
    get_aggs(s.aggs, aggs)
    result = s.execute().aggregations
    rs = get_results(aggs, result)
    dates = [r['date'][:10] for r in rs]
    counts = [r['date_count'] for r in rs]

    print(dates)
    print(counts)

    return Response("success")