from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view

from django.http.response import HttpResponse
import ldap
from django.contrib.auth import logout, login, authenticate, get_user_model
from .serializers import LoginSerializer, UserDetailSerializer
from zst_mysql_1110.response import MyJsonResponse
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, IsAdminUser

from django.contrib.auth import get_user_model


@api_view(['POST'])
def django_ldap_login(request):
    json_data = {
        'username': 'apple',
        'password': '123456abc'
    }
    serializer = LoginSerializer(data=json_data)

    """
    When a serializer is passed a `data` keyword argument you must call `.is_valid()` before attempting to access the serialized `.data` representation.
You should either call `.is_valid()` first, or access `.initial_data` instead.
    """

    # 对值进入验证判断
    if not serializer.is_valid():
        return MyJsonResponse(code=4001, message="invalid data")

    data = serializer.data

    # 返回一个用户名
    user = authenticate(request, username=data['username'], password=data['password'])

    if user is None:
        return MyJsonResponse(code=4001, message="error username or password...")

    login(request, user)

    # print(get_user_model())
    # <class 'django.contrib.auth.models.User'>
    return MyJsonResponse(message="login success")

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


def ldap_login(request):
    # try:
    #     con = ldap.initialize('ldap://127.0.0.1:10389')
    #     username = "uid=apple,o=zst_k8s,dc=example,dc=com"
    #     password = "123456abc"
    #     con.simple_bind_s(username, password)
    #     return HttpResponse("success")
    # except ldap.LDAPError as e:
    #     return HttpResponse("failed")
    #
    #

    try:
        con = ldap.initialize('ldap://127.0.0.1:10389')
        username = "apple"
        password = "123456abc"

        # 验证管理员账号admin的密码
        con.simple_bind_s('uid=admin,ou=system', 'secret')

        results = con.search_s('o=zst_k8s,dc=example,dc=com', ldap.SCOPE_SUBTREE, "uid=%s" % username)
        if results is not None and len(results) == 1:
            user = results[0]
            user_dn = user[0]
            con.simple_bind_s(user_dn, password)
        else:
            return HttpResponse('user not exists')
        return HttpResponse('login success')

    except ldap.LDAPError as e:

        return HttpResponse('login failed', str(e))



class UserDetailView(APIView):
    permission_classes = [IsAuthenticated]
    # IsAuthenticated：判断有没有登录过

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
