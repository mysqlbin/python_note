"""messages URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from .views import hello_world, hello_world_v2, param_debug, user_detail, user_list, auto_path_converter, register, login, me, logout, set_cookie, get_cookie, delete_cookie
from django.urls import path, register_converter, re_path


class FourDigitYearConverter:
    regex = '[0-9]{4}'

    def to_python(self, value):
        return int(value)

    def to_url(self, value):
        return '%04d' % value

register_converter(FourDigitYearConverter, 'yyyy')


urlpatterns = [
    path('admin/', admin.site.urls),
    path('hw1', hello_world),
    path('hw2', hello_world_v2),
    # http://127.0.0.1:8010/index/paramdebug/23/Bin
    path('paramdebug/<int:id>/<str:name>', param_debug),
    path('userdetail/<int:id>', user_detail),
    path('userlist/<str:name>', user_list),
    # path('pathconverter/<yyyy:year>', auto_path_converter),
    re_path('pathconverter/(?P<year>[0-9]{4})/', auto_path_converter),
    path('register/', register, name="register"),
    path('login/', login, name="login"),
    path('me/', me, name="me"),
    path('logout/', logout, name="logout"),

    path('set_cookie/', set_cookie, name="set_cookie"),
    path('get_cookie/', get_cookie, name="get_cookie"),
    path('delete_cookie/', delete_cookie, name="delete_cookie"),
]
