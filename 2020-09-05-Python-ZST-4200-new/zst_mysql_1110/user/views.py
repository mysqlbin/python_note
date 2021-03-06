from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view

from django.http.response import HttpResponse
# import ldap
from django.contrib.auth import logout, login, authenticate, get_user_model
from .serializers import LoginSerializer, UserDetailSerializer
from zst_mysql_1110.response import MyJsonResponse
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, IsAdminUser


@api_view(['POST'])
def django_ldap_login(request):
    print(1)

    print(request.data)
    print(type(request.data))
    serializer = LoginSerializer(data=request.data)
    # LoginSerializer登录序列化器在这里的作用，做post表单数据的验证，减少代码量

    """
    When a serializer is passed a `data` keyword argument you must call `.is_valid()` before attempting to access the serialized `.data` representation.
You should either call `.is_valid()` first, or access `.initial_data` instead.
    """

    # 对值进入验证判断
    if not serializer.is_valid():
        return MyJsonResponse(code=4001, message="invalid data")

    data = serializer.data

    # 做用户名和密码的认证，认证成功返回一个用户名，认证失败则返回 None
    user = authenticate(request, username=data['username'], password=data['password'])

    if user is None:
        return MyJsonResponse(code=4001, message="error username or password...")

    # 用户进行登录
    login(request, user)

    # print(get_user_model())
    # <class 'django.contrib.auth.models.User'>
    return MyJsonResponse(message="login success", data=data['username'])

    '''
    username = 'apple'
    password = '123456abc'
    user = authenticate(request, username=username, password=password)
    # return HttpResponse(user)
    if user is None:
        return HttpResponse('error username or password')

    login(request, user)

    return HttpResponse('login success')
    '''


# def ldap_login_debug(request):
#     # try:
#     #     con = ldap.initialize('ldap://127.0.0.1:10389')
#     #     username = "uid=apple,o=zst_k8s,dc=example,dc=com"
#     #     password = "123456abc"
#     #     con.simple_bind_s(username, password)
#     #     return HttpResponse("success")
#     # except ldap.LDAPError as e:
#     #     return HttpResponse("failed")
#     #
#     #
#
#     try:
#         con = ldap.initialize('ldap://127.0.0.1:10389')
#         username = "apple"
#         password = "123456abc"
#
#         # 验证管理员账号admin的密码
#         con.simple_bind_s('uid=admin,ou=system', 'secret')
#
#         results = con.search_s('o=zst_k8s,dc=example,dc=com', ldap.SCOPE_SUBTREE, "uid=%s" % username)
#         if results is not None and len(results) == 1:
#             user = results[0]
#             user_dn = user[0]
#             # 验证账号和密码
#             con.simple_bind_s(user_dn, password)
#         else:
#             return HttpResponse('user not exists')
#         return HttpResponse('login success')
#
#     except ldap.LDAPError as e:
#
#         return HttpResponse('login failed', str(e))
#


class UserDetailView(APIView):

    # IsAuthenticated：判断有没有登录过
    # permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        # 获取当前登录的用户，返回用户名
        user = request.user
        print(user)
        serializer = UserDetailSerializer(user)
        return MyJsonResponse(data=serializer.data)

    # 修改当前登录用户的资料
    def put(self, request, *args, **kwargs):
        user = request.user
        serializer = UserDetailSerializer(instance=user, data=request.data, partial=True)
        serializer.is_valid(True)
        serializer.save()
        return MyJsonResponse(data=UserDetailSerializer(user).data)

@api_view(['GET'])
def django_is_login(request):

    # 返回登录的用户名，如果没有登录，返回 AnonymousUser(如果没有登录的话，那么输出AnonymousUser)
    print(request.user)

    # request.user.is_authenticated 验证是否通过登录认证，认证返回 True，没有认证返回 False
    # return HttpResponse(request.user.is_authenticated)

    if request.user.is_authenticated:
        return MyJsonResponse(message='login success')

    return MyJsonResponse(message='login failed')

@api_view(['GET'])
def django_login(request):

    username = 'apple'
    password = '123456abc'
    user = authenticate(request, username=username, password=password)
    if user is None:
        return MyJsonResponse(message='error username or password', code=401)
    login(request, user)
    return MyJsonResponse(message='login success')


@api_view(['GET'])
def current_user(request):

    if request.user.is_authenticated:
        return MyJsonResponse(message='login success', data='apple')

    return MyJsonResponse(message='login failed', code=4001)


@api_view(['GET'])
def logout_user(request):

    logout(request)

    return MyJsonResponse(message='退出成功')
