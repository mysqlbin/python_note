
1. 自定义序列化器
2. 基于类的视图
3. DRF框架-APIView视图类
4. GenericAPIView
5. DRF viewsets(视图集合) 
6. DRF ModelViewSet
7. filter过滤
8. 小结
9. 接口列表相关
10. 相关参考

1. 自定义序列化器
	REST framework提供了Serializer类和ModelSerializer类两种方式供你自定义序列化器
	前者需手动指定需要序列化和反序列化的字段
	后者根据模型(model)生成需要序列化和反序列化的字段，可以使代码更简洁。
	
	Serializer类
		class HostSerializer(serializers.Serializer):
			# 字段的声明类似于模型的声明，只返回这３个字段的数据
			name = serializers.CharField(max_length=30)
			memory = serializers.CharField(max_length=30)
			cpu = serializers.CharField(max_length=30)		
	
	ModelSerializer类
		继承的类发生了变化
		编写一个meta嵌套类，声明一些属性
		用ModelSerializer类可以重构我们的序列化器类，使整体代码更简洁。
		
		# 继承 ModelSerializer 类
		class UserDetailSerializer(serializers.ModelSerializer):
			class Meta:
				model = get_user_model()
				fields = ['username', 'email', 'first_name', 'last_name']

		class MySQLSchemaSerializer(serializers.ModelSerializer):
			class Meta:
				model = MySQLSchema
				fields = '__all__'
				

2. 基于类的视图

	Django-class based view 表示基于类的视图
	
	
	视图函数的工作机制
		通过路由设置，一个http请求最终交给视图函数进行处理	
	
	视图函数存在的问题
		无法很好的进行复用
		一个视图函数可以处理所有类型的HTTP请求，通过if判断，代码不够简洁
	
	
	from django.views import View
	class ArticleListView(View):
		"""处理GET请求"""
		def get(self, request):
			articles = ArticlePost.objects.all()
			context = {'articles': articles}
			return render(request, 'article/list.html', context)
			
		"""处理POST请求"""
		def post(self, request):
			pass
			
		def delete put http methods的方法名
			
	* 声明路由的方式有所不同
	path('article_list/', ArticleListView.as_view())
		
		
3. DRF框架-APIView视图类
	
	APIView是DRF提供一个视图类，用法和django的View相似，实际上APIView就是继承了Django的View类，并且在View类的基础上，提供了权限、认证相关的功能
	
	与Django一样，DRF也支持使用基于函数的视图(Functional Based View, FBV)和基于类的视图(Class Based View, CBV)来编写视图(views)。
	
	
	
	源码
		from rest_framework.views import APIView
			rest_framework\views.py
			# 实际上APIView就是继承了Django的View类
			class APIView(View):

				# The following policies may be set at either globally, or per-view.
				renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES
				parser_classes = api_settings.DEFAULT_PARSER_CLASSES
				authentication_classes = api_settings.DEFAULT_AUTHENTICATION_CLASSES
				throttle_classes = api_settings.DEFAULT_THROTTLE_CLASSES
				permission_classes = api_settings.DEFAULT_PERMISSION_CLASSES
				content_negotiation_class = api_settings.DEFAULT_CONTENT_NEGOTIATION_CLASS
				metadata_class = api_settings.DEFAULT_METADATA_CLASS
				versioning_class = api_settings.DEFAULT_VERSIONING_CLASS	
		
		from rest_framework.permissions import IsAuthenticated, IsAdminUser
			rest_framework\permissions.py
			class IsAuthenticated(BasePermission):
				"""
				Allows access only to authenticated users.
				"""

				def has_permission(self, request, view):
					return bool(request.user and request.user.is_authenticated)

	使用案例
		
		from rest_framework.views import APIView
		from rest_framework.permissions import IsAuthenticated, IsAdminUser
		
		class UserDetailView(APIView):

			# IsAuthenticated ：判断有没有登录过
			permission_classes = [IsAuthenticated]

			def get(self, request, *args, **kwargs):
				# 获取当前登录的用户，返回用户名
				user = request.user
				print(user)
				serializer = UserDetailSerializer(user)
				return MyJsonResponse(data=serializer.data)

			# 修改当前登录用户的资料
			def put(self, request, *args, **kwargs):
				user = request.user
				serializer = UserDetailSerializer(instance=user, data=request.data, partial=True)
				serializer.is_valid(True)
				serializer.save()
				return MyJsonResponse(data=UserDetailSerializer(user).data)

4. GenericAPIView
	
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
		from rest_framework.generics import

5. DRF viewsets(视图集合) 
	
	使用视图集后，我们需要使用DRF提供的路由router来分发urls，因为一个视图集现在对应多个urls的组合，而不像之前的一个url对应一个视图函数或一个视图类。

	basename
		首先，在Django中我们可以给一个URL命名
		其次，viewset的URL是自动生成的
		basename就是自动生成的URL name的前缀
		-- 这里还不理解。
		
	from rest_framework.routers import DefaultRouter

	router = DefaultRouter()
	router.register(r'host_view', HostViewSet, basename='host')    -- basename='host' 改为 basename='host_view'  会怎么样？
	router.register(r'mysql_schema', SchemaViewSet, basename='mysql_schema')

	"""
	
		router：
			router.register(r'host_view', HostViewSet, basename='host')
			
			http://127.0.0.1:8001/meta_manage/host_view/ 
				/host_view/  对应 r'host_view'
				basename='host' 对应 http://127.0.0.1:8001/meta_manage/host_view/ 中 host_view的前缀 host

			HostViewSet 对应视图类

				class HostViewSet(viewsets.ModelViewSet):

		------------------------------------------------------------------------------------------------
		router：
			router.register(r'mysql_schema', SchemaViewSet, basename='mysql_schema')
			
			http://127.0.0.1:8001/api/meta_manage/mysql_schema/
				/mysql_schema/ 对应 r'mysql_schema'
				
			SchemaViewSet 对应视图类

				class SchemaViewSet(viewsets.ModelViewSet):
				
	"""

	urlpatterns = [
		*router.urls
	]
	


	register 的3个参数:

		prefix  route中url的前缀
		viewset 对应的viewset类  --理解
		basename 创建url的名字，默认是viewset的 queryset ，所以如果viewset类中没用queryset属性，必须设置basename

		https://www.cnblogs.com/yuzhenjie/p/10361880.html   Django-rest-framework（四）router

	
	路由类的源码 
	class BaseRouter:
		def __init__(self):
			self.registry = []

		def register(self, prefix, viewset, basename=None):
			if basename is None:
				basename = self.get_default_basename(viewset)
			self.registry.append((prefix, viewset, basename))


		
6. DRF ModelViewSet

	class SchemaViewSet(viewsets.ModelViewSet):

		queryset = MySQLSchema.objects.all()
		serializer_class = MySQLSchemaSerializer
		pagination_class = CustomPagination
		filter_backends = [DjangoFilterBackend]
		filterset_fields = ['status', 'schema', 'host_ip', 'port']
		
		--MySQLSchemaSerializer对应的序列化器
			class MySQLSchemaSerializer(serializers.ModelSerializer):
				class Meta:
					model = MySQLSchema
					fields = '__all__'
		
		
	class HostModelViewSet(viewsets.ModelViewSet):
		serializer_class = HostSerializer
		queryset = Host.objects.all()
	
	
7. filter过滤
	
7.1 等值查询filter_backends
	
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
		
	
7.2 关键词搜索search_filter	
	
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


8. 小结
	
	对DRF越来越清晰了，还需要继续理解、使用。
		--越看越模糊，也越来越清晰
	师傅领进门，修行靠个人。
	
9. 接口列表相关

get
	http://127.0.0.1:8001/api/meta_manage/v1/host/1

	http://127.0.0.1:8001/api/meta_manage/host_view/

	http://127.0.0.1:8001/api/meta_manage/host_view/

	http://127.0.0.1:8001/api/meta_manage/v1/host_list

	http://127.0.0.1:8001/api/meta_manage/v1/host_list_api/?search=hostname-02,4

	http://127.0.0.1:8001/api/meta_manage/v1/host_list_mixin/


10. 相关参考
	相关课件
		《3-3用户登录与注册1031.pdf》
		《3-3用户登录与注册1101.pdf》
		《3-3用户登录与注册1107.pdf》  -- 完成的。
	
	https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MjM5OTMyODA4Nw==&action=getalbum&album_id=1481676575086608384&scene=173&from_msgid=2247484783&from_itemidx=1&count=3#wechat_redirect #原创DRF教程连载
		
		https://mp.weixin.qq.com/s/56mipLa14fHjeLv_KZwiiA  Django REST Framework教程(8): 分页(Pagination)详解
		https://mp.weixin.qq.com/s/u9BpfRjhjDMh5ybL2plp0Q  Django REST Framework教程(7): 如何使用JWT认证(神文多图)
		https://mp.weixin.qq.com/s/gEI2ikzeWR4MJ7AVwPIQ7w  Django REST Framework教程(6): 认证详解及如何使用Token认证
		https://mp.weixin.qq.com/s/57aoG2aSdhWgCoXPmQd5zQ  Django REST Framework教程(2): 序列化器介绍及以博客为例开发基于函数视图的API
		https://mp.weixin.qq.com/s/NFkRg0HG2GQWjfTCotRWfA  Django REST Framework教程(3): 基于类的视图APIView, GenericAPIView和视图集
		https://mp.weixin.qq.com/s/7HI97hMZST4cBAgh0qGAJw  Django REST Framework教程(1): 为什么要学习DRF, 什么是序列化和RESTful的API
		
