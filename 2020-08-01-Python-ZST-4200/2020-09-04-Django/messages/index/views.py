# from django.shortcuts import render
from django.shortcuts import *
from django.http import *
from .models import Users
from .form import RegisterForm
from django.contrib import messages
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


def auto_path_converter(request, year):

    return HttpResponse(year)

def register(request):

    print(request.method)
    if request.method == 'POST':

        regForm = RegisterForm(request.POST)

        if regForm.is_valid():      # 如果校验通过，就会走下面的逻辑
            print(regForm.cleaned_data)   # {'username': '3333', 'password': '3333', 'email': '122@qq.com'}
            # return redirect('hw1')
            return HttpResponse('success')

        messages.error(request, "error")
        print(regForm.errors)
        # <ul class="errorlist"><li>password<ul class="errorlist"><li>密码由6-16位的数字和字母组成</li></ul></li></ul>
        # <ul class="errorlist"><li>username<ul class="errorlist"><li>This field is required.</li></ul></li></ul>
        # <ul class="errorlist"><li>username<ul class="errorlist"><li>用户名非法</li></ul></li></ul>
        # <ul class="errorlist"><li>password<ul class="errorlist"><li>您输入的密码太简单</li></ul></li></ul>
        # <ul class="errorlist"><li>password<ul class="errorlist"><li>密码太简单了</li></ul></li></ul>

        return HttpResponse('error')

    elif request.method == 'GET':
        return render(request, 'register.html')

    raise Http404


def login(request):
    username = 'bin'
    # 设置 session
    request.session['username'] = username
    return redirect(resolve_url('me'))


def me(request):
    if 'username' in request.session:
        # 获取 session
        username = request.session['username']
    else:
        username = None

    data = {
        "username": username
    }
    return render(request, "me.html", data)


def logout(request):
    try:
        # 删除 session
        del request.session['username']
    except KeyError:
        pass
    print(111)
    # print(request.session['username'])
    # return redirect(resolve_url('me'))
    return HttpResponse('logout')


def set_cookie(request):
    response = render(request, "cookie.html")
    response.set_cookie("username", "zst")
    return response


def get_cookie(request):
    username = request.COOKIES.get('username')
    response = render(request, "cookie.html", {
      "username": username
    })

    return response


def delete_cookie(request):
    response = render(request, "cookie.html")
    response.delete_cookie("username")
    return response
