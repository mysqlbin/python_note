from django.contrib import admin
from django.urls import path, include
from .views import *
urlpatterns = [
    path('v1/host/', HostView.as_view()),
<<<<<<< HEAD
    path('v1/host/<int:host_id>/', HostView.as_view()),
=======
>>>>>>> 4822112044a88888697e4f3a3d41dacf45cfa249
]