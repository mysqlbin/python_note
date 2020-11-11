from django.shortcuts import render

# Create your views here.

from zst_mysql_1110.response import MyJsonResponse
from rest_framework.views import APIView
from .models import Host
from .serializers import HostSerializer
from rest_framework.generics import GenericAPIView, CreateAPIView, ListAPIView
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from rest_framework import mixins, generics


# 基于APIView来写 get、put、post请示
class HostView(APIView):
    def get(self, request, host_id=None, *args, **kwargs):
        if host_id is None:
            hosts = Host.objects.all()
            serializers = HostSerializer(hosts.values(), many=True)
            
        else:
            h = Host.objects.get(id=host_id)
            # serializers = HostSerializer(h.values())
            #  "message": "'Host' object has no attribute 'values'",
            serializers = HostSerializer(h)
        return MyJsonResponse(data=serializers.data)

    def put(self, request, host_id, *args, **kwargs):
        host = Host.objects.get(pk=host_id)
        # print(1)
        serializer = HostSerializer(host, data=request.data, partial=True)
        serializer.is_valid(True)

        """
        for attr, value in serializer.validated_data.items():
            # validated_data.items().pop('name')
            setattr(host, attr, value)
        host.save()
        """
        serializer.save()

        return MyJsonResponse(message="success")

    def post(self, request, *args, **kwargs):
        serializer = HostSerializer(data=request.data)
        serializer.is_valid()

        """
        <class 'collections.OrderedDict'>
        OrderedDict([('name', 'hostname-03'), ('memory', '64'), ('cpu', '16')])
        """
        """
        data = serializer.validated_data
        print(type(data))
        print(data)
        host = Host(**data)  # Host(name="xxx", memory=64, cpu=16)
        host.save()
        """
        serializer.save()
        return MyJsonResponse(message="success")



class HostListView(ListAPIView):
    serializer_class = HostSerializer
    queryset = Host.objects.all()
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['name', 'cpu', 'memory']


class HostListAPIView(ListAPIView):
    serializer_class = HostSerializer
    queryset = Host.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['^name', '=memory']

# GenericAPIView必须写在最后
class HostList(mixins.ListModelMixin, mixins.CreateModelMixin, generics.GenericAPIView):

    queryset = Host.objects.all()
    serializer_class = HostSerializer

    def get(self, request, *args, **kwargs):
        # 我们不用在get post两个方法中都去ORM调用以及序列化调用
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)