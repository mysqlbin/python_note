

django-admin startproject messages

cd messages

django-admin startapp index


create database messages DEFAULT CHARSET utf8mb4;


修改 settings.py 文件

python3 manage.py makemigrations
python3 manage.py migrate



python3 manage.py runserver 192.168.56.121:8007





