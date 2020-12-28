from django.shortcuts import render
from rest_framework import viewsets
from django.http.response import HttpResponse
from rest_framework.response import Response

from slowsql.esmodel import SlowQuery
from elasticsearch_dsl import Q,A
# Create your views here.
from rest_framework.pagination import PageNumberPagination


class CustomPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    page_query_param = 'page_num'
    max_page_size = 500


class SlowSqlViewSet(viewsets.ViewSet):
    # print(1)

    def list(self, request, *args, **kwargs):
        # 入参： 开始时间、结束时间、库名、第几页、每页多少个
        start = request.query_params.get('start')
        end = request.query_params.get('end')
        schema = request.query_params.get('schema', None)
        s = SlowQuery.search()
        if schema is not None and len(schema) > 0:
            s = s.filter('term', schema__keyword=schema)
        if start is not None and end is not None:
            options = {
                'gte': start,
                'lte': end
            }
            s = s.filter('range', **{'@timestamp': options})
        s = s.sort('-@timestamp')

        paginator = CustomPagination()

    # def list(self, request):
        # print(1)
        # return HttpResponse(1)
        # s = SlowQuery.search()

        # 查询所有的数据
        # result = s.scan()

        # 等值查询
        # result = s.filter('term', schema__keyword='Ena').scan()

        # 排序
        # result = s.sort('-@timestamp')

        # 指定范围
        # from_date = '2020-11-10T19:00:00'
        # to_date = '2020-11-10T20:00:00'
        # options = {
        #     'gte': from_date,
        #     'lte': to_date
        # }
        # result = s.filter('range', **{'@timestamp': options}).execute()

        #
        # result = s.filter('wildcard', schema__keyword='*L*').scan()

        # result = s.filter('prefix', schema__keyword='L').scan()

        # result = s.filter('match', query_sql='abc cda').scan()

        # result = s.filter('match', query_sql='T_computer').filter('term', schema__keyword='Talia').scan()

        # q = Q("match", query_sql='gqfeyhtnr') | Q("term", schema__keyword="Talia")

        # result = s.filter(q).scan()

        # result = s.sort('-@timestamp', 'rows_examined')

        """
        # 一层聚合数据: 简单的一个根据日期聚合的
        timeAggs = A('date_histogram', field='@timestamp', fixed_interval="10m")

        # 'date' 为分组的名称
        s.aggs.bucket('date', timeAggs)

        aggs = s.execute().aggregations

        for date_item in aggs['date'].buckets:
            print(date_item)

        """

        # for i in result:
        #     # print(i)
        #     print(i.to_dict())
        # return Response('success')
