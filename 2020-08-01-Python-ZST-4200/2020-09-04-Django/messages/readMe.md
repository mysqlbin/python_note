

django-admin startproject message
cd todo_server
python manage.py startapp index

	
python manage.py runserver 192.168.1.50:8080

# 生成要执行的数据库文件
python manage.py makemigrations
# 通过编写的模型自动生成表结构
python manage.py migrate

python manage.py shell

Create Update

	>>> from index.models import Message
	>>> m = Message()
	>>> m.username = '3'
	>>> m.content = '3'
	>>> m.even_filed=1
	>>> m.save()

	INSERT INTO `index_message` (`username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES ('3', '3', '2020-09-04 08:11:30.501037', 0, NULL, NULL, NULL, NULL)


	Message.objects.create(content="hello world")
	2020-09-04T16:13:27.719160+08:00	32525 Query	INSERT INTO `index_message` (`username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES ('', 'hello world', '2020-09-04 08:13:27.516953', 0, NULL, NULL, NULL, NULL)

	root@mysqldb 16:10:  [(none)]> select * from test2_db.index_message;
	+----+----------+-------------+----------------------------+---------+-------+------+-----------+------+
	| id | username | content     | create_time                | deleted | email | ip   | null_bool | uuid |
	+----+----------+-------------+----------------------------+---------+-------+------+-----------+------+
	|  1 | 3        | 3           | 2020-09-04 08:11:30.501037 |       0 | NULL  | NULL |      NULL | NULL |
	|  2 |          | hello world | 2020-09-04 08:13:27.516953 |       0 | NULL  | NULL |      NULL | NULL |
	+----+----------+-------------+----------------------------+---------+-------+------+-----------+------+
	2 rows in set (0.00 sec)


	>>> Message.objects.create(content="hello world")
	<Message: Message object (3)>
	>>> Message.objects.create(content="hello world2")
	<Message: Message object (4)>

Delete

	from index.models import Message
	
	Message.objects.filter(id=1).delete()

	2020-09-04T16:30:42.782293+08:00	32525 Query	SET autocommit=0
	2020-09-04T16:30:42.783566+08:00	32525 Query	DELETE FROM `index_message` WHERE `index_message`.`id` = 1
	2020-09-04T16:30:42.785445+08:00	32525 Query	COMMIT
	
Read
	
	root@mysqldb 16:13:  [(none)]> select * from test2_db.index_message;
	+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+
	| id | username | content      | create_time                | deleted | email | ip   | null_bool | uuid |
	+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+
	|  3 |          | hello world  | 2020-09-04 09:04:01.051465 |       0 | NULL  | NULL |      NULL | NULL |
	|  4 |          | hello world2 | 2020-09-04 09:05:40.332292 |       0 | NULL  | NULL |      NULL | NULL |
	+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+
	2 rows in set (0.00 sec)


	from index.models import Message
	
	Message.objects.all()
	Message.objects.get(pk=1)
	Message.objects.get(id=1)
	m = Message.objects.get(content='a',even_field=3)
	DoesNotExist: Message matching query does not exist.
	Message.objects.filter(content=‘a’)
	Message.objects.filter(create_time__lte=‘2020-04-18’)
	exclude


	>>> Message.objects.all()
	<QuerySet [<Message: Message object (3)>, <Message: Message object (4)>]>
		
	>>> Message.objects.get(pk=3)
	<Message: Message object (3)>	
		
	>>> Message.objects.get(id=4)
	<Message: Message object (4)>
	
	
	>>> Message.objects.filter(content='hello world')
	<QuerySet [<Message: Message object (3)>]>	
	
	
	>>> Message.objects.filter(create_time__lte='2020-09-04 09:05:40')
	D:\Py\lib\site-packages\django\db\models\fields\__init__.py:1368: RuntimeWarning: DateTimeField Message.create_time received a naive datetime (2020-09-04 09:05:40) while time zone support is active.
	  RuntimeWarning)
	<QuerySet [<Message: Message object (3)>]>
	
ManyToOne	
	
	先创建一个Reporter，记得要调用save方法，保存到数据库中
	然后创建Message，将刚才创建的reporter传进去
		###########################  用create() 方法，为什么还需要save() 方法 ###########################
		from index.models import Message, Reporter
		r = Reporter.objects.create(first_name='Bob', last_name='Alex',email='bob@qq.com')
		r.save()
		# INSERT INTO `index_reporter` (`first_name`, `last_name`, `email`) VALUES ('Bob', 'Alex', 'bob@qq.com')
		# UPDATE `index_reporter` SET `first_name` = 'Bob', `last_name` = 'Alex', `email` = 'bob@qq.com' WHERE `index_reporter`.`id` = 1
		
		m = Message.objects.create(content='aaa', reporter=r)
		m.save()
		
		# INSERT INTO `index_message` (`reporter_id`, `username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES (1, '', 'aaa', '2020-09-04 09:19:59.149080', 0, NULL, NULL, NULL, NULL)
		# UPDATE `index_message` SET `reporter_id` = 1, `username` = '', `content` = 'aaa', `create_time` = '2020-09-04 09:19:59.149080', `deleted` = 0, `email` = NULL, `ip` = NULL, `null_bool` = NULL, `uuid` = NULL WHERE `index_message`.`id` = 5



		root@mysqldb 17:20:  [(none)]> select * from test2_db.index_reporter;
		+----+------------+-----------+------------+
		| id | first_name | last_name | email      |
		+----+------------+-----------+------------+
		|  1 | Bob        | Alex      | bob@qq.com |
		+----+------------+-----------+------------+
		1 row in set (0.00 sec)

		root@mysqldb 17:20:  [(none)]> select * from test2_db.index_message;
		+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
		| id | username | content      | create_time                | deleted | email | ip   | null_bool | uuid | reporter_id |
		+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
		|  3 |          | hello world  | 2020-09-04 09:04:01.051465 |       0 | NULL  | NULL |      NULL | NULL |        NULL |
		|  4 |          | hello world2 | 2020-09-04 09:05:40.332292 |       0 | NULL  | NULL |      NULL | NULL |        NULL |
		|  5 |          | aaa          | 2020-09-04 09:19:59.149080 |       0 | NULL  | NULL |      NULL | NULL |           1 |
		+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
		3 rows in set (0.00 sec)
	
	查询：通过reporter属性可以引用到关联的reporter对象

		
		print(m.reporter.id)
		print(m.reporter.last_name)

		>>> print(m.reporter.id)
		1
		>>> print(m.reporter.last_name)
		Alex
	
	
	查看一个Reporter拥有的全部message

		>>> r.message_set.all()
		<QuerySet [<Message: Message object (5)>]>
		
		SELECT
			`index_message`.`id`,
			`index_message`.`reporter_id`,
			`index_message`.`username`,
			`index_message`.`content`,
			`index_message`.`create_time`,
			`index_message`.`deleted`,
			`index_message`.`email`,
			`index_message`.`ip`,
			`index_message`.`null_bool`,
			`index_message`.`uuid`
		FROM
			`index_message`
		WHERE
			`index_message`.`reporter_id` = 1
		LIMIT 21
		
		from index.models import Message, Reporter
		r = Reporter.objects.create(first_name='abc', last_name='abc',email='bob@qq.com')
		r.save()	
		m = Message.objects.create(content='abc', reporter=r)
		m.save()
		
		root@mysqldb 17:21:  [(none)]> select * from test2_db.index_reporter;
		+----+------------+-----------+------------+
		| id | first_name | last_name | email      |
		+----+------------+-----------+------------+
		|  1 | Bob        | Alex      | bob@qq.com |
		|  2 | abc        | abc       | bob@qq.com |
		+----+------------+-----------+------------+
		2 rows in set (0.01 sec)

		root@mysqldb 17:38:  [(none)]> select * from test2_db.index_message;
		+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
		| id | username | content      | create_time                | deleted | email | ip   | null_bool | uuid | reporter_id |
		+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
		|  3 |          | hello world  | 2020-09-04 09:04:01.051465 |       0 | NULL  | NULL |      NULL | NULL |        NULL |
		|  4 |          | hello world2 | 2020-09-04 09:05:40.332292 |       0 | NULL  | NULL |      NULL | NULL |        NULL |
		|  5 |          | aaa          | 2020-09-04 09:19:59.149080 |       0 | NULL  | NULL |      NULL | NULL |           1 |
		|  6 |          | abc          | 2020-09-04 09:37:47.855167 |       0 | NULL  | NULL |      NULL | NULL |           2 |
		+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
		4 rows in set (0.00 sec)

	
		>>> r.message_set.all()
		<QuerySet [<Message: Message object (6)>]>
			
		SELECT
		`index_message`.`id`,
		`index_message`.`reporter_id`,
		`index_message`.`username`,
		`index_message`.`content`,
		`index_message`.`create_time`,
		`index_message`.`deleted`,
		`index_message`.`email`,
		`index_message`.`ip`,
		`index_message`.`null_bool`,
		`index_message`.`uuid`
		FROM
			`index_message`
		WHERE
			`index_message`.`reporter_id` = 2
		LIMIT 21	
	
	删除
		from index.models import Message, Reporter		
		r = Reporter.objects.get(pk=1)
			SELECT
				`index_reporter`.`id`,
				`index_reporter`.`first_name`,
				`index_reporter`.`last_name`,
				`index_reporter`.`email`
			FROM
				`index_reporter`
			WHERE
				`index_reporter`.`id` = 1
			LIMIT 21

		>>> r.delete()
		(2, {'index.Message': 1, 'index.Reporter': 1})
			
				
			2020-09-04T17:47:41.551008+08:00	32549 Query	SET autocommit=0
			2020-09-04T17:47:41.552341+08:00	32549 Query	DELETE FROM `index_message` WHERE `index_message`.`reporter_id` IN (1)
			2020-09-04T17:47:41.554594+08:00	32549 Query	DELETE FROM `index_reporter` WHERE `index_reporter`.`id` IN (1)
			2020-09-04T17:47:41.555761+08:00	32549 Query	COMMIT
				
				
				