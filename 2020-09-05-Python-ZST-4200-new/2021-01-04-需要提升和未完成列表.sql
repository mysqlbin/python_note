
从头走一遍上课老师讲的，包括先导课程
看看先导课程在项目中的应用：
	promise
	
promise 和 axios 的关系



春节前主要的学习内容
	阅读老师的代码，整理代码
    箭头函数的使用和Promise的使用
    es查询、es数据结构
    vue路由
		vue会用了，element ui也会用了
    python基础
    DRF相关
    项目中的代码
	django orm
		model建表、字段相关
	vue父子组件之间的传值
	celery 的结果用MySQL来存储
	
	
	
节后复习MySQL
 
一样样来

return HttpResponse 改为 JsonResponse

目前已经达到了可以做项目的状态

未完成的功能：
	1. 添加实例列表-- 后台已经自带有添加功能了，需要看看
	2. Vue页面添加接收返回的状态判断
	
	
	
https://blog.csdn.net/weixin_47454485/article/details/107482332  Django之DRF自定义action


@timestamp:"2021-01-11T01:50:57.000Z" 落后8个小时 




默认是单实例单库：
	存储到慢日志数据表：
		mysql_slow_query_review_history.hostname="192.168.0.252_test_db" # 由ip+schema组成，用于区分实例、筛选
		
	实例列表也要加个字段	
		mysql_schema.instance_name = 由ip+schema组成
	
	
		CREATE TABLE `mysql_schema` (
		  `gmt_update` datetime(6) DEFAULT NULL,
		  `gmt_create` datetime(6) DEFAULT NULL,
		  `id` bigint(20) NOT NULL AUTO_INCREMENT,
		  `host_ip` char(39) NOT NULL,
		  `port` int(11) NOT NULL,
		  `schema` varchar(64) NOT NULL,
		  `instance_name` varchar(120) NOT NULL,
		  `role` varchar(64) NOT NULL,
		  `status` varchar(64) NOT NULL,
		  `phy_host_id` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `mysql_schema_phy_host_id_48048fd4` (`phy_host_id`)
		) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;


	