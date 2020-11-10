from django.shortcuts import render

# Create your views here.

from zst_mysql_1110.response import MyJsonResponse
from rest_framework.views import APIView
from .models import Host
from .serializers import HostSerializer


class HostView(APIView):
    def get(self, request, host_id=None, *args, **kwargs):
        if host_id is None:
            hosts = Host.objects.all()
            serializers = HostSerializer(hosts.values(), many=True)
            
        else:
            h = Host.objects.get(id=host_id)
<<<<<<< HEAD
            # serializers = HostSerializer(h.values())
            #  "message": "'Host' object has no attribute 'values'",
            serializers = HostSerializer(h)
=======
            serializers = HostSerializer(h.values())
>>>>>>> 4822112044a88888697e4f3a3d41dacf45cfa249
        return MyJsonResponse(data=serializers.data)