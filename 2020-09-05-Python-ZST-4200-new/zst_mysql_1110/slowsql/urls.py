

from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()
router.register(r'slow_sql', SlowSqlViewSet, basename='slow_sql')
urlpatterns = [
    *router.urls
]
