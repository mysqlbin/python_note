from django.contrib import admin
from django.urls import path, include
from .views import *
urlpatterns = [
    path('v1/host/', HostView.as_view()),
    path('v1/host/<int:host_id>/', HostView.as_view()),
    path('v1/host_list/', HostListView.as_view()),
    path('v1/host_list_api/', HostListAPIView.as_view()),
    path('v1/host_list_mixin/', HostList.as_view()),
]