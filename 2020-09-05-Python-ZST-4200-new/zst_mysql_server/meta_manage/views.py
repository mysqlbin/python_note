from django.shortcuts import render
from .models import MySQLSchema
from django.http.response import JsonResponse

# Create your views here.

def insert_mysql_schema(request):

    # host = request.POST['host']
    # port = request.POST['port']
    # schema = request.POST['schema']
    # role = request.POST['role']

    host = 'aa'
    port = 3306
    schema = 'test_db'
    role = 'master'

    data = {
        'code': 2000
    }

    schema_obj = MySQLSchema(host_ip=host, port=int(port), schema=schema, role=role)

    try:
        schema_obj.save()
    except Exception as e:
        data['code'] = 4000
        data['message'] = str(e)

    if schema_obj.id:
        data['data'] = schema_obj.id

    return JsonResponse(data)