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

from rest_framework import viewsets
from django.urls import reverse


# 基于APIView来写 get、put、post请示（继承APIView）
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


        """
            def post 和 def put都调用的是 save() 方法，类似于 Django Model的创建和更新都可以调用save()方法
            def put serializer 有传入 模型，所以调用的是 序列化器的 update()方法。
            
        """

# 继承ListAPIView
"""
class ListAPIView(mixins.ListModelMixin,
                  GenericAPIView):
ListAPIView有继承GenericAPIView             
"""
class HostListView(ListAPIView):
    serializer_class = HostSerializer
    queryset = Host.objects.all()

    # 复写 GenericAPIView 类的 get_queryset 方法
    # def get_queryset(self):
    #     # 从get参数当中获取name的值
    #     # self.request.GET['name']
    #     name = self.request.query_params.get("name", "hostname")
    #     # if not name:
    #     if name is None or len(name) == 0:
    #         return self.queryset.all()
    #
    #     # 查询的方法
    #     # filter(name=name)
    #     # __contains  like '%localhost%'
    #     return self.queryset.filter(name__contains=name)

        # SELECT * FROM `meta_manage_host` WHERE `meta_manage_host`.`name` LIKE BINARY '%hostname%';

    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['name', 'cpu', 'memory']

# 继承ListAPIView
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



class HostModelViewSet(viewsets.ModelViewSet):
    serializer_class = HostSerializer
    queryset = Host.objects.all()

"""
    class HostModelViewSet 的代码包含了 class HostViewSet 的代码 
"""

class HostViewSet(viewsets.ViewSet):
    def list(self, request):
        hosts = Host.objects.all().values()
        serializer = HostSerializer(hosts, many=True)
        return MyJsonResponse(data=serializer.data)

    def create(self, request):
        serializer = HostSerializer(data=request.data)
        serializer.is_valid(True)
        instance = serializer.save()
        # 用在生成具体ID的时候，才会用到 reverse
        print(reverse('host-list'))  # 对应 /meta_manage/host_view/
        url = reverse('host-detail', args=(instance.id,))
        return MyJsonResponse(data={'url': url})

    def retrieve(self, request, pk=None):
        h = Host.objects.get(pk=pk)
        serializer = HostSerializer(h)
        return MyJsonResponse(serializer.data)

    def update(self, request, pk=None):
        host = Host.objects.get(pk=pk)
        serializer = HostSerializer(host, data=request.data)
        serializer.is_valid(True)
        serializer.save()
        return MyJsonResponse("success")

    def partial_update(self, request, pk=None):
        host = Host.objects.get(pk=pk)
        serializer = HostSerializer(host, data=request.data, partial=True)
        serializer.is_valid(True)
        serializer.save()
        return MyJsonResponse("success")

    def destroy(self, request, pk=None):
        h = Host.objects.get(pk=pk)
        h.delete()
        return MyJsonResponse("success")
