
django-admin startproject MyDjango
cd myproject
django-admin startapp index


python3 manage.py makemigrations
python3 manage.py migrate


python3 manage.py runserver 192.168.0.71:8007
python3 manage.py runserver 192.168.0.246:8000
python3 manage.py runserver 127.0.0.1:8000


python3 manage.py shell
from index.models import *



Django 数据表更改
    Django 1.7.x 及以后的版本集成了 South 的功能，在修改models.py了后运行：
        python manage.py makemigrations
        python manage.py migrate
    这两行命令就会对我们的models.py 进行检测，自动发现需要更改的，应用到数据库中去。


	