

from rest_framework.routers import DefaultRouter
from .views import *
from django.urls import path, include

router = DefaultRouter()
router.register(r'slow_sql', SlowSqlViewSet, basename='slow_sql')
urlpatterns = [
    path('send_with_matplotlib/', send_with_matplotlib),
    *router.urls
]
