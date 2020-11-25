from django.contrib import admin
from django.urls import path, include
from .views import *
urlpatterns = [
    #path('get_current_user/', get_current_user),
    path('ldap_login/', ldap_login),
    path('django_ldap_login/', django_ldap_login),
    path('user_detail', UserDetailView.as_view()),
    path('django_is_login', django_is_login),
    path('django_login', django_login),
    path('current_user/', current_user),
    path('logout_user/', logout_user),


]