

MVC模式（Model–view–controller）是软件工程中的一种软件架构模式，把软件系统分为三个基本部分： 
	模型（Model）、视图（View）和控制器（Controller）。 
	控制器（Controller）： 负责转发请求，对请求进行处理。 
	视图（View）        ： 界面设计人员进行图形界面设计。 
	模型（Model）       ： 程序员编写程序应有的功能（实现算法等等）、数据库专家进行数据管理和数据库设 计(可以实现具体的功能)。
	

Model-模型 
	• 包含了数据相关的逻辑 
	• 和数据的交互（select, insert, update, delete） 
	• 和Controller通信 
	• 如果想更换数据库的话，只要更换驱动，而不用 修改模型的代码

View-视图 
	• 用户看见的就是视图 
	• 通常由HTML和CSS组成 
	• 与Controller通信 
	• Controller可以传递动态值给视图 
	• 模板引擎-JSP-Jinjia2
	
	include 复用视图
	extends  继承视图
	
Controller-控制器 
	• 接收Input
	• 处理各种请求-GET,POST,PUT,DELETE
	• 从Model获取数据 
	• 传递数据给View


一句话总结MVC框架的工作机制：
	用户在浏览器发送一个URL请求到控制器，控制器处理请求(GET、POST请求等)，从Model获取数据，然后传递数据给视图
	视图把数据渲染出来
	控制器：真正写业务逻辑代码的地方
	模型：  数据库的设计 





	
	
模板的过滤器 https://docs.djangoproject.com/en/3.0/ref/templates/builtins/
default: <p>value: {{ value | default:"nothing" }}</p>
	当value为以下取值的时候：未定义、''、 False None，模板就会显示'nothing'
	但是如果定义了string_if_invalid选项，事情稍微会变得不一样 
default_if_none: 有且只有当value是None，才会显示default值-思考：当变量没有定义的时候呢？ 
date: 格式化日期，非常常用 
divisibleby: 整除 
escape: 转义 
first： 取数组的第一个 
format： {{ value|floatformat:3 }} 保留3位小数 
join: 
Length, length_is

	
HttpResponseRedirect                          # 重定向
HttpResponsePermanentRedirect                 # 永久重定向
HttpResponseNotModified                       # 304
HttpResponseBadRequest                        # 400
HttpResponseNotFound                          # 404
HttpResponseForbidden                         # 403
HttpResponseNotAllowed                        # 405
HttpResponseGone                              # 410
HttpResponseServerError                       # 500



https://www.cnblogs.com/weridmaid/archive/2016/08/03/5733623.html  django模板里循环变量<table>里想要两个一行如何控制
