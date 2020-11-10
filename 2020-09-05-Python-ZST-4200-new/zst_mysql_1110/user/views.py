from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view

from django.http.response import HttpResponse
import ldap
from django.contrib.auth import logout, login, authenticate, get_user_model
from .serializers import LoginSerializer
from zst_mysql_1110.response import MyJsonResponse

@api_view(['GET'])
def django_ldap_login(request):
    json_data = {
        'username': 'apple1111',
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
    user = authenticate(request, username=data['username'], password=data['password'])

    if user is None:
        return MyJsonResponse(code=4001, message="error username or password...")

    login(request, user)

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




