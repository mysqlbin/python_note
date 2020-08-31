from django.shortcuts import render
from django.http.response import JsonResponse
# Create your views here.

def index(request):
    todo_list = []
    for i in range(10):
        todo_list.append({
            "id": 1,
            "content": 'abc'
        })


    # data_info = {
    #     "status": 0,
    #     "data": '',
    #     "message": "您还未登录"
    # }
    response = JsonResponse(todo_list, safe=False)

    # 解决跨域问题
    # response['Access-Control-Allow-Headers'] = '*'
    # response['Access-Control-Allow-Origin'] = '*'

    return response
