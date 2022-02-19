
# from celery import task

from celery import shared_task
from .models import *
from index.models import Type

import time

# 带参数的分布式任务
@shared_task
def updateData(type_id, value):
    Type.objects.filter(id=type_id).update(type_name=value)

