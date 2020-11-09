
django-admin startproject zst_mysql_1109

cd zst_mysql_1109

pipenv --python 3.6


pipenv shell


pipenv install django 

pipenv install django  -- url = "https://pypi.douban.com/simple"


pipenv install mysqlclient





django-admin startproject zst_mysql_1110

cd zst_mysql_1110

pipenv --python 3.6

修改:
	url = "https://pypi.doubanio.com/simple"

pipenv shell


pipenv install django 



pipenv install mysqlclient


python manage.py runserver 127.0.0.1:8001

