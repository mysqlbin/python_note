

django-admin startproject zst_mysql_1110
cd zst_mysql_1110

pipenv --python 3.6
	
	E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_1110 (master -> origin)
	λ pipenv --python 3.6
	Virtualenv already exists!
	Removing existing virtualenv…
	Creating a virtualenv for this project…
	Pipfile: E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_1110\Pipfile
	Using d:/py/python.exe (3.6.7) to create virtualenv…
	[    ] Creating virtual environment...created virtual environment CPython3.6.7.final.0-64 in 6242ms
	  creator CPython3Windows(dest=C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_1110-CRw6Dq79, clear=False, global=False)
	  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=C:\Users\Administrator.SC-202007271117\AppData\Local\pypa\virtualenv)
		added seed packages: pip==20.2.4, setuptools==50.3.2, wheel==0.35.1
	  activators BashActivator,BatchActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator

	Successfully created virtual environment!
	Virtualenv location: C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_1110-CRw6Dq79

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


疑问：
	model .values() 是什么意思 
		Host.objects.all().values()
		返回的queryset是一个字典
		https://www.cnblogs.com/rgxx/p/10382664.html
		
		
	get_user_model() 得到的值是什么
		    # print(get_user_model())
			# <class 'django.contrib.auth.models.User'>
			-- 使用 get_user_model 函数来获取用户类
	ModelSerializer 这里还不明白
	
	URL反转
		from django.urls import reverse
		print(reverse('host-list'))
	

pipenv install django-filter


等值查询filter_backends
	
	filter_backends = [DjangoFilterBackend]
    filterset_fields = ['name', 'cpu', 'memory']
	
	通过DRF的filter_backends机制来实现 多个字段的等值搜索
	
	http://127.0.0.1:8001/meta_manage/v1/host_list/	
		SELECT `meta_manage_host`.`id`, `meta_manage_host`.`gmt_update`, `meta_manage_host`.`gmt_create`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` 
		FROM `meta_manage_host`

	http://127.0.0.1:8001/meta_manage/v1/host_list/?name=hostname-01
		SELECT `meta_manage_host`.`id`, `meta_manage_host`.`gmt_update`, `meta_manage_host`.`gmt_create`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` 
		FROM `meta_manage_host` WHERE `meta_manage_host`.`name` = 'hostname-01'

	http://127.0.0.1:8001/meta_manage/v1/host_list/?name=hostname-01&memory=4
		SELECT `meta_manage_host`.`id`, `meta_manage_host`.`gmt_update`, `meta_manage_host`.`gmt_create`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` 
		FROM `meta_manage_host` WHERE (`meta_manage_host`.`name` = 'hostname-01' AND `meta_manage_host`.`memory` = '4')
		
	
关键词搜索search_filter	
	
	http://127.0.0.1:8001/meta_manage/v1/host_list_api/?search=hostname-02
	
		filter_backends = [filters.SearchFilter]
		search_fields = ['^name', 'memory']
		
			SELECT `meta_manage_host`.`id`, `meta_manage_host`.`gmt_update`, `meta_manage_host`.`gmt_create`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` 
			FROM `meta_manage_host` WHERE (`meta_manage_host`.`name` LIKE 'hostname-02%' OR `meta_manage_host`.`memory` LIKE '%hostname-02%')

		filter_backends = [filters.SearchFilter]
		search_fields = ['^name', '=memory']
		
			http://127.0.0.1:8001/meta_manage/v1/host_list_api/?search=hostname-02
			
			SELECT `meta_manage_host`.`id`, `meta_manage_host`.`gmt_update`, `meta_manage_host`.`gmt_create`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` 
			FROM `meta_manage_host` WHERE (`meta_manage_host`.`name` LIKE 'hostname-02%' OR `meta_manage_host`.`memory` LIKE 'hostname-02')

		filter_backends = [filters.SearchFilter]
		search_fields = ['^name', '=memory']
			http://127.0.0.1:8001/meta_manage/v1/host_list_api/?search=hostname-02,4
			SELECT `meta_manage_host`.`id`, `meta_manage_host`.`gmt_update`, `meta_manage_host`.`gmt_create`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` 
			FROM `meta_manage_host` 
			WHERE ((`meta_manage_host`.`name` LIKE 'hostname-02%' OR `meta_manage_host`.`memory` LIKE 'hostname-02') 
			AND (`meta_manage_host`.`name` LIKE '4%' OR `meta_manage_host`.`memory` LIKE '4'))


简单的用户登录登出
	from django.contrib.auth import login, logout, authenticate
	login： 用户登录
	authenticate：验证用户名和密码是否正确
	logout： 登出

下面是一个典型的验证登录的过程
	若用户名、密码正确的话，返回一个User；若不正确的话，返回None
	接着必须调用login方法，才真正设置session，使用户处于登录状态
	def django_login(request):
		username = request.POST['username']
		password = request.POST['password']
		user = authenticate(request, username=username, password=password)
		if user is None:
			return HttpResponse('error username or password', status=401)
		login(request, user)
		return HttpResponse('login success')

		
		
用户注册的要点
	--这里的内容要再听下
	使用 get_user_model 函数来获取用户类
	尽量不要使用from django.contrib.auth.models import User 这种方式来导入Django 的用户类。 这是因为，我们可以扩展
	from django.contrib.auth import get_user_model
	def django_register(request):
		email = request.POST['email']
		username = request.POST['username']
		password = request.POST['password']
		User = get_user_model()
		field_meta = User._meta.get_field('username')
		user = User()
		setattr(user, 'username', username)
		setattr(user, 'email', email)
		user.set_password(password)
		user.save()
		return HttpResponse('register success')
			


1. 序列化器：类似于post表单数据的验证

2. DRF框架-APIView
	APIView是DRF提供一个视图类，用法和django的View相似，实际上APIView就是继承了Django的View类，在View类的基础上，提供了权限、认证相关的功能	
		class HostView(APIView)
		class UserDetailView(APIView)
		
	GenericAPIView
	
		GenericAPIView（当然也不仅仅只有这个类）就是这么一个视图类，可以帮助我们少写很多代码

		GenericAPIView层次

			1. GenericAPIView 基础类
			2. Mixin 				可以认为是接口，只实现一些简单的方法
				CreateModelMixin	对应insert
				ListModelMixin		查询全部
				RetrieveModelMixin	根据ID查询单个
				UpdateModelMixin	对应update
				DestroyModelMixin	对应delete
				-- 1和2是一起用的，写的代码量会少很多，参考class HostListView(ListAPIView)
			
			3. OtherViews 复合类，实现get，post等方法  --写最少的代码
				CreateAPIView
				ListAPIView      --其中 ListAPIView有继承GenericAPIView             
				RetrieveAPIView
				DestroyAPIView

			-- 参考 class HostListView(ListAPIView)、class HostListAPIView(ListAPIView)
				
		from rest_framework.views import APIView
		from rest_framework.generics import GenericAPIView, CreateAPIView, ListAPIView

						
3. DRF viewset(视图集合) 
	
4. DRF ModelViewSet
	


	
django-admin startapp check
	
	
看项目的代码，自己要理解、思考
不理解的地方就看视频

