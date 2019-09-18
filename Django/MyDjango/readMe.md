
django-admin startproject MyDjango
cd myproject
django-admin startapp index


python3 manage.py makemigrations
python3 manage.py migrate


python3 manage.py runserver 192.168.0.71:8007


python3 manage.py shell
from index.models import *


