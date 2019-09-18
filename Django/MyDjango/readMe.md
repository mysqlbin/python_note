
django-admin startproject MyDjango
cd myproject
django-admin startapp index


python3 manage.py makemigrations
python3 manage.py migrate


python3 manage.py runserver 192.168.0.71:8007


python3 manage.py shell
from index.models import *


p_res = Product.objects.get(id = 2)
print(p_res)
# return: Product object (2)

p_res = Product.objects.filter(id = 2)
print(p_res)
# return: <QuerySet [<Product: Product object (2)>]>


