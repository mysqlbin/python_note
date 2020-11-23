from django.contrib import admin
from django.urls import path, include
from .views import *

from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'host_view', HostViewSet, basename='host')
router.register(r'mysql_schema', SchemaViewSet, basename='mysql_schema')

"""
router：
    router.register(r'host_view', HostViewSet, basename='host')
URL:
    http://127.0.0.1:8001/meta_manage/host_view/

    http://127.0.0.1:8001/meta_manage/host_view/ 中的 host_view 对应 r'host_view'
    basename='host' 对应 http://127.0.0.1:8001/meta_manage/host_view/ 中 host_view的前缀 host

URL pattern 对应  path('v1/host_list_mixin/', HostList.as_view()) 中的 'v1/host_list_mixin/'
"""

urlpatterns = [
    path('v1/host/', HostView.as_view()),
    path('v1/host/<int:host_id>/', HostView.as_view()),
    path('v1/host_list/', HostListView.as_view()),
    path('v1/host_list_api/', HostListAPIView.as_view()),
    path('v1/host_list_mixin/', HostList.as_view()),
    # path('v1/schema_list/', SchemaViewSet.as_view()),
    *router.urls
]