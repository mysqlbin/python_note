

from rest_framework.routers import DefaultRouter
from .views import *
from django.urls import path, include

router = DefaultRouter()
# router.register(r'slow_query', SlowQueryViewSet, basename='slow_query')
router.register(r'detail_slow_query', DetailSlowQueryViewSet, basename='detail_slow_query')
urlpatterns = [
    path('v1/get_slow_query_history_lists/', get_slow_query_history_lists),
    *router.urls
]
