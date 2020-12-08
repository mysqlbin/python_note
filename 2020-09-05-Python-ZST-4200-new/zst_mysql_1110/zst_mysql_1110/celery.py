import os

from celery import Celery
# from django.conf import settings

# set the default Django settings module for the 'celery' program.
# 设置django环境
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'zst_mysql_1110.settings')

app = Celery('zst_mysql_1110')

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
# 使用CELERY_ 作为前缀，在settings中写配置
# app.config_from_object('django.conf:settings')

app.config_from_object('django.conf:settings', namespace='CELERY')



# Load task modules from all registered Django app configs.
# 发现任务文件每个app下的task.py
# app.autodiscover_tasks(settings.INSTALLED_APPS)
app.autodiscover_tasks()

@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')

