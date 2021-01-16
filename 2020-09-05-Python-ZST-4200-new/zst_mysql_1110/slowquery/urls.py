

# from rest_framework.routers import DefaultRouter
from .views import *
from django.urls import path, include

# router = DefaultRouter()
# router.register(r'slow_query', SlowQueryViewSet, basename='slow_query')
# router.register(r'detail_slow_query', DetailSlowQueryViewSet, basename='detail_slow_query')
urlpatterns = [
    path('slowquery_history/', slowquery_history),
    path('slowquery_aggr/', slowquery_aggr),
    path('get_aggs_by_date/', get_aggs_by_date),
    # *router.urls
]
