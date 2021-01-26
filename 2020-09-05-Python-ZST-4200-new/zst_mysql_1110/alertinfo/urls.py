

from .views import *
from django.urls import path, include

urlpatterns = [
    path('alter_sample/', alter_sample),
    path('alter_html_sample/', alter_html_sample),
    path('alter_html_with_image_sample/', alter_html_with_image_sample),
    path('matplotlib_sample/', matplotlib_sample),
    path('alter_slow_report/', alter_slow_report),
    path('monitor_by_interval/', monitor_by_interval),
    # *router.urls
]
