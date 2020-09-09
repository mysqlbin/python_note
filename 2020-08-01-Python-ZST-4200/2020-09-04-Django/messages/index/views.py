# from django.shortcuts import render
from django.shortcuts import *
from django.http import *
from .models import Users

# Create your views here.

from django.http import HttpResponse

def hello_world(request):

    return HttpResponse("hello world")

def hello_world_v2(request):

    return HttpResponse("hello world v2")

def param_debug(request, name, id):

    return HttpResponse("name: {}, id: {}". format(name, id))

def user_detail(request, id):

    if id is None or not isinstance(id, int):
        return HttpResponseBadRequest()

    # try:
    #     l = Users.objects.get(id=id)
    #
    # except Users.DoesNotExist:
    #     raise Http404

    l = get_object_or_404(Users, id=id)

    # get_object_or_404的介绍： 我们原来调用django 的get方法(model.object.get())，如果查询的对象不存在的话，会抛出一个DoesNotExist的异常，
    # l = get_object_or_404(Users, first_name='la')
    # get() returned more than one Users -- it returned 2!

    context = {
        'Users': l
    }

    return render(request, 'detail.html', context)


def user_list(request, name):

    if name is None or not isinstance(name, str):
        return HttpResponseBadRequest()

    # try:
    #     l = Users.objects.filter(first_name='la')
    #
    # except Users.DoesNotExist:
    #     raise Http404

    l = get_list_or_404(Users, first_name='la')

    def echo2():
        return 'echo 2'

    context = {
        'Users': l,
        'bar': ['a', 'b'],
        'echo': {
            'method': 'echo',
            'method2': echo2,
        },
        'html': '<script>alert("hello world")</script>',
        'html2': '<script>alert("hello world v2")</script>',
    }

    return render(request, 'list.html', context)