from django.shortcuts import render
from  .models import Hosts
from zst_mysql_1110.response import MyJsonResponse
from rest_framework.decorators import api_view
import json
from django.http import HttpResponse, JsonResponse


# Create your views here.

@api_view(['GET'])
def model_values(request):

    data = Hosts.objects.all()
    host_list = list(data.values())
    # 也可以用序列化器来做：序列化成json格式的数据
    print(host_list)
    # data = Hosts.objects.all()
    return JsonResponse(host_list, safe=False)

    """
    
    from check.models import Hosts
    
    data = Host.objects.all()
    return JsonResponse(data=hosts)
    Object of type 'Host' is not JSON serializable
    不要直接把从模型查到的数据直接返回，因为queryset类型不支持json序列化

    
    data = Hosts.objects.all()
    print(data)
    <QuerySet [<Hosts: Host: 1-1-1-1>]>
    
    data = Hosts.objects.all().values()
    print(data)
    <QuerySet [{'id': 1, 'gmt_update': None, 'gmt_create': None, 'name': '1', 'memory': '1', 'cpu': '1'}]>
    
    import json
    data = Hosts.objects.all()
    json.dumps(data)
    # TypeError: Object of type 'QuerySet' is not JSON serializable
    
    """