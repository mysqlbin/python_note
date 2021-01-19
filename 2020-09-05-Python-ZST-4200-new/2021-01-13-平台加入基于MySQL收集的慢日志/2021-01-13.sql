
blank=True
	默认值为blank=Flase，表示默认不允许为空，

	blank=True admin级别可以为空
 
null=True
	默认值为null=Flase，表示默认不允许为空

	null=True 数据库级别可以为空



django-admin startapp slowquery

python manage.py makemigrations
python manage.py migrate


(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ python manage.py makemigrations
Migrations for 'slowquery':
  slowquery/migrations/0001_initial.py
    - Create model SlowQuery
    - Create model SlowQueryHistory
	
(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, check, contenttypes, meta_manage, sessions, slowquery
Running migrations:
  Applying slowquery.0001_initial... OK


INSERT INTO `django_content_type` (`app_label`, `model`) VALUES ('slowquery', 'slowquery'), ('slowquery', 'slowqueryhistory')

INSERT INTO `auth_permission` (`name`, `content_type_id`, `codename`) VALUES ('Can add 慢日志统计', 13, 'add_slowquery'), 
('Can change 慢日志统计', 13, 'change_slowquery'), ('Can delete 慢日志统计', 13, 'delete_slowquery'), 
('Can view 慢日志统计', 13, 'view_slowquery'), ('Can add 慢日志明细', 14, 'add_slowqueryhistory'), 
('Can change 慢日志明细', 14, 'change_slowqueryhistory'), ('Can delete 慢日志明细', 14, 'delete_slowqueryhistory'), 
('Can view 慢日志明细', 14, 'view_slowqueryhistory')


https://blog.csdn.net/weixin_44685869/article/details/102690814

https://blog.csdn.net/qq_44955537/article/details/103279928

https://www.656463.com/wenda/zDjangoRESTkjzxlhyddgx_529

http://ask.sov5.cn/q/MWtEJzdkVD

https://www.jianshu.com/p/332406309476 Django 实现分页功能



Django时区

	TIME_ZONE = 'Asia/Shanghai'
	USE_TZ = False
	ValueError: MySQL backend does not support timezone-aware datetimes when USE_TZ is False.


	TIME_ZONE = 'Asia/Shanghai'
	# USE_TZ = True
	
	传入的时间： 
		2020-12-19T17:41:34+08:00
		2021-01-18T17:41:34+08:00
		
	File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/backends/mysql/operations.py", line 253, in adapt_datetimefield_value
	ValueError: MySQL backend does not support timezone-aware datetimes when USE_TZ is False.

	
	https://blog.csdn.net/qq_27361945/article/details/80580795   
		为什么Django设置时区为TIME_ZONE = 'Asia/Shanghai' USE_TZ = True后，存入mysql中的时间只能是UTC时间
		
	https://juejin.cn/post/6844903456340181006  Django时区详解

	https://blog.csdn.net/leontom/article/details/102918329
		
	
	https://www.cnblogs.com/catgatp/p/13178847.html   django时间的时区问题

	
	https://www.jb51.net/article/166044.htm  详解Django 时间与时区设置问题

	
	https://www.codenong.com/cs105352294/   django_celery_beat 报错 USE_TZ
	
	https://blog.csdn.net/weixin_34109408/article/details/94089751   python UTC 时间转换为本地时间
	
	 
	当USE_TZ=True的时候（即开启Django的时区功能）
  




django时间落后8小时的解决办法之一：  
	后端应该在数据库统一存储UTC时间并返回UTC时间给前端
	前端在发送时间和接收时间的时候要把时间分别从当前时区转换成UTC发送给后端，以及接收后端的UTC时间转换成当地时区。
  
  
https://blog.csdn.net/huhuhuja/article/details/109524949   vue 学习经验总结（this.$router.push url传参后清空地址栏中的参数）


https://www.cnblogs.com/corgisyj/p/11352862.html   vue 之this.$router.push、replace、go的区别

