1

django-admin startproject zst_mysql_1110
cd zst_mysql_1110

pipenv --python 3.6

pipenv shell
pipenv install django 

pipenv install mysqlclient

python manage.py runserver 127.0.0.1:8001


pipenv install python_ldap-3.3.1-cp36-cp36m-win_amd64.whl


django-admin startapp user


create  database zst_mysql_1110 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

python manage.py makemigrations

python manage.py migrate


pipenv install djangorestframework


使用login，authenticate，logout
	下面是一个典型的验证登录的过程
		若用户名、密码正确的话，返回一个User；若不正确的话，返回None
		接着必须调用login方法，才真正设置session，使用户处于登录状态
		
		
问题1	
	AssertionError at /user/django_ldap_login/
	.accepted_renderer not set on Response

		from rest_framework.decorators import api_view
		@api_view(['GET'])
		
		https://www.django-rest-framework.org/api-guide/responses/
		
		.accepted_renderer
			The renderer instance that will be used to render the response.
			-- 将用于呈现响应的呈现器实例。
			
			Set automatically by the APIView or @api_view immediately before the response is returned from the view.
			-- 从视图返回响应之前，由APIView或@api_view自动设置。

		--后面再看Postman
		
		
django-admin startapp meta_manage
	-- 记得在 settings.py INSTALLED_APPS 中添加 APP名称 
python manage.py makemigrations 

python manage.py migrate

python manage.py shell

from meta_manage.models import Host, MySQLSchema
h = Host.objects.create(name='hostname-01', memory='4', cpu='32')
m = MySQLSchema.objects.create(phy_host=h, port=int(3306), host_ip='192.168.0.201', schema='test_db', role='master')

h = Host.objects.create(name='hostname-02', memory='4', cpu='32')
m = MySQLSchema.objects.create(phy_host=h, port=int(3306), host_ip='192.168.0.202', schema='test_db', role='slave')


http://127.0.0.1:8001/meta_manage/v1/host/?host_id=1


疑问1：
	model .values() 是什么意思 
	
	
	