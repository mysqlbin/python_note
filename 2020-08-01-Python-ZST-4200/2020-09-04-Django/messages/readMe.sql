
1. 基本命令

2. 单表DML和SELECT操作
	2.1 Create和Update
	2.2 Delete
	2.3 Read

3. ManyToOne
	3.1 创建数据
	3.2 查询
		3.2.1 查询1
		3.2.2 查询2
	3.3 删除

4. ManyToMany	
	4.1 添加数据
	4.2 查询数据
		4.2.1 查一篇文章的所有出版社 即 根据文章查出版社
		4.2.2 根据出版社查文章 即 查一个出版社的所有文章
	4.3 删除

5. 模型的继承
	5.1 创建数据
	5.2 查询

		
1. 基本命令

	django-admin startproject message
	cd todo_server
	python manage.py startapp index

		
	python manage.py runserver 192.168.1.50:8080

	# 生成要执行的数据库文件
	python manage.py makemigrations
	# 通过编写的模型自动生成表结构
	python manage.py migrate

	python manage.py shell

2. 单表DML和SELECT操作
2.1 Create和Update

	>>> from index.models import Message
	>>> m = Message()
	>>> m.username = '3'
	>>> m.content = '3'
	>>> m.even_filed=1
	>>> m.save()

	INSERT INTO `index_message` (`username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES ('3', '3', '2020-09-04 08:11:30.501037', 0, NULL, NULL, NULL, NULL)


	Message.objects.create(content="hello world")
	INSERT INTO `index_message` (`username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES ('', 'hello world', '2020-09-04 08:13:27.516953', 0, NULL, NULL, NULL, NULL)

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

2.2 Delete

	from index.models import Message
	
	Message.objects.filter(id=1).delete()

	2020-09-04T16:30:42.782293+08:00	32525 Query	SET autocommit=0
	2020-09-04T16:30:42.783566+08:00	32525 Query	DELETE FROM `index_message` WHERE `index_message`.`id` = 1
	2020-09-04T16:30:42.785445+08:00	32525 Query	COMMIT
	
2.3 Read
	
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
	Message.objects.filter(content='a')
	Message.objects.filter(create_time__lte='2020-04-18')
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
	
3. ManyToOne	
	
	Reporter表: 表示发送消息的用户
	
	先创建一个Reporter，记得要调用save方法，保存到数据库中
	然后创建Message，将刚才创建的reporter传进去
	
		###########################  用create() 方法，为什么还需要save() 方法, 没有必要调用 save()方法了。 ###########################
		
	3.1 创建数据
		from index.models import Message, Reporter
		r = Reporter.objects.create(first_name='abc', last_name='Alex',email='abc@qq.com')
	
			INSERT INTO `index_reporter` (`first_name`, `last_name`, `email`) VALUES ('abc', 'Alex', 'abc@qq.com')
		
		r.save()
		
			UPDATE `index_reporter` SET `first_name` = 'abc', `last_name` = 'Alex', `email` = 'abc@qq.com' WHERE `index_reporter`.`id` = 1
			
			
		m = Message.objects.create(content='abc', reporter=r)
		
			INSERT INTO `index_message` (`reporter_id`, `username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES (1, '', 'abc', '2020-09-08 06:40:21.012710', 0, NULL, NULL, NULL, NULL)

		
		m = Message.objects.create(content='bbb', reporter=r)
		
			INSERT INTO `index_message` (`reporter_id`, `username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES (1, '', 'bbb', '2020-09-08 06:40:53.141407', 0, NULL, NULL, NULL, NULL)

		m.save()
			UPDATE `index_message`
			SET `reporter_id` = 1,
			 `username` = '',
			 `content` = 'bbb',
			 `create_time` = '2020-09-08 06:40:53.141407',
			 `deleted` = 0,
			 `email` = NULL,
			 `ip` = NULL,
			 `null_bool` = NULL,
			 `uuid` = NULL
			WHERE
				`index_message`.`id` = 2
			
			# 一个对象(数据表)调用了再次 create() 方法，然后再执行 save()，会更新最后一行记录。
			
		root@localhost [(none)]>select * from test2_db.index_reporter;
		+----+------------+-----------+------------+
		| id | first_name | last_name | email      |
		+----+------------+-----------+------------+
		|  1 | abc        | Alex      | abc@qq.com |
		+----+------------+-----------+------------+
		1 row in set (0.00 sec)

		root@localhost [(none)]>select * from test2_db.index_message;
		+----+----------+---------+----------------------------+---------+-------+------+-----------+------+-------------+
		| id | username | content | create_time                | deleted | email | ip   | null_bool | uuid | reporter_id |
		+----+----------+---------+----------------------------+---------+-------+------+-----------+------+-------------+
		|  1 |          | abc     | 2020-09-05 09:13:18.672772 |       0 | NULL  | NULL |      NULL | NULL |           1 |
		|  2 |          | bbb     | 2020-09-05 09:13:29.440140 |       0 | NULL  | NULL |      NULL | NULL |           1 |
		+----+----------+---------+----------------------------+---------+-------+------+-----------+------+-------------+
		2 rows in set (0.00 sec)

	3.2 查询
	3.2.1 查询1
		通过reporter属性可以引用到关联的reporter对象

		
		print(m.reporter.id)
		print(m.reporter.last_name)

		>>> print(m.reporter.id)
		3
		>>> print(m.reporter.last_name)
		Alex
	
	
	3.2.2 查询2
		id=4 这个Reporter拥有的全部message
	
		方式1: 反向获取
		
			r = Reporter.objects.get(id=4)
			r.message_set.all()
			
				>>> r = Reporter.objects.get(id=4)
				>>> r.message_set.all()
				<QuerySet [<Message: Message object (3)>, <Message: Message object (4)>]>
					
					SELECT
						`index_reporter`.`id`,
						`index_reporter`.`first_name`,
						`index_reporter`.`last_name`,
						`index_reporter`.`email`
					FROM
						`index_reporter`
					WHERE
						`index_reporter`.`id` = 4
					LIMIT 21; 
			
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
					`index_message`.`reporter_id` = 4
				LIMIT 21;	
				
			
		方式2: 正向获取	
			
			# 直接带入 `reporter_id` = 4
			Message.objects.filter(reporter__id=4)
		
			>>> Message.objects.filter(reporter__id=4)
			<QuerySet [<Message: Message object (3)>, <Message: Message object (4)>]>

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
				`index_message`.`reporter_id` = 4
			LIMIT 21	
			
		
	3.3 删除
		
		from index.models import Message, Reporter		
		r = Reporter.objects.get(pk=3)
			SELECT
				`index_reporter`.`id`,
				`index_reporter`.`first_name`,
				`index_reporter`.`last_name`,
				`index_reporter`.`email`
			FROM
				`index_reporter`
			WHERE
				`index_reporter`.`id` = 3
			LIMIT 21

		>>> r.delete()  # 删除对象，关联关系也会被删除  -- 理解了。
		(3, {'index.Message': 2, 'index.Reporter': 1})
			
			DELETE FROM `index_message` WHERE `index_message`.`reporter_id` IN (3)
			DELETE FROM `index_reporter` WHERE `index_reporter`.`id` IN (3)
			
			
		

				
4. ManyToMany
		
	4.1 添加数据
from index.models import Article, Publication
p1 = Publication(title='p1')
p2 = Publication(title='p2')
p1.save()
p2.save()
a1 = Article(headline='a1')
a1.save()
a1.publications.add(p1)
a1.publications.add(p2)
a2 = Article(headline='a2')
a2.save()
a2.publications.add(p1)
a2.publications.add(p2)


		p1.save()
		p2.save()

			INSERT INTO `index_publication` (`title`) VALUES ('p1')
			INSERT INTO `index_publication` (`title`) VALUES ('p2')
					
		a1.save()
			INSERT INTO `index_article` (`headline`) VALUES ('a1')	

		a1.publications.add(p1)
			INSERT IGNORE INTO `index_article_publications` (`article_id`, `publication_id`) VALUES VALUES (1, 1)	
			
		a1.publications.add(p2)
			INSERT IGNORE INTO `index_article_publications` (`article_id`, `publication_id`) VALUES (1, 2)
			
		a2.save()
			INSERT INTO `index_article` (`headline`) VALUES ('a2')	

		a2.publications.add(p1)
			
			INSERT IGNORE INTO `index_article_publications` (`article_id`, `publication_id`) VALUES (2, 1)
			
		a2.publications.add(p2)

			INSERT IGNORE INTO `index_article_publications` (`article_id`, `publication_id`) VALUES (2, 2)
			
			mysql> select * from index_article;
			+----+----------+
			| id | headline |
			+----+----------+
			|  1 | a1       |
			|  2 | a2       |
			+----+----------+
			2 rows in set (0.00 sec)

			mysql> select * from index_publication;
			+----+-------+
			| id | title |
			+----+-------+
			|  1 | p1    |
			|  2 | p2    |
			+----+-------+
			2 rows in set (0.00 sec)

			mysql> select * from index_article_publications;
			+----+------------+----------------+
			| id | article_id | publication_id |
			+----+------------+----------------+
			|  1 |          1 |              1 |
			|  2 |          1 |              2 |
			|  3 |          2 |              1 |
			|  4 |          2 |              2 |
			+----+------------+----------------+
			4 rows in set (0.00 sec)
	
	4.2 查询数据
	
	4.2.1 查一篇文章的所有出版社 即 根据文章查出版社
	
		方式1: 
			
			a1 = Article.objects.get(id=2)  # 先把 `index_article`.`id` = 2 的对象查询出来
			a1.publications.all()           # index_publication inner join index_article_publications
			
			>>> a1 = Article.objects.get(id=2)
			>>> a1.publications.all()
			<QuerySet [<Publication: p1>, <Publication: p2>]>


				SELECT
					`index_article`.`id`,
					`index_article`.`headline`
				FROM
					`index_article`
				WHERE
					`index_article`.`id` = 2
				LIMIT 21;			
				-----------------------------------------
				SELECT
					`index_publication`.`id`,
					`index_publication`.`title`
				FROM
					`index_publication`
				INNER JOIN `index_article_publications` ON (
					`index_publication`.`id` = `index_article_publications`.`publication_id`
				)
				WHERE
					`index_article_publications`.`article_id` = 2
				LIMIT 21	
		
		方式2:
			
			Publication.objects.filter(article__id=2)
			
			>>> Publication.objects.filter(article__id=2)
			
			<QuerySet [<Publication: p1>, <Publication: p2>]>
				SELECT
					`index_publication`.`id`,
					`index_publication`.`title`
				FROM
					`index_publication`
				INNER JOIN `index_article_publications` ON (
					`index_publication`.`id` = `index_article_publications`.`publication_id`
				)
				WHERE
					`index_article_publications`.`article_id` = 2
				LIMIT 21

			
	4.2.2 根据出版社查文章 即 查一个出版社的所有文章
	
		正向查询的3种方式 
			
			方式1 
				>>> Article.objects.filter(publications__id=1)
				<QuerySet [<Article: a1>, <Article: a2>]>

					SELECT
						`index_article`.`id`,
						`index_article`.`headline`
					FROM
						`index_article`
					INNER JOIN `index_article_publications` ON (
						`index_article`.`id` = `index_article_publications`.`article_id`
					)
					WHERE
						`index_article_publications`.`publication_id` = 1
					LIMIT 21	
					
			方式2
				>>> Article.objects.filter(publications__pk=1)
				<QuerySet [<Article: a1>, <Article: a2>]>

					SELECT
						`index_article`.`id`,
						`index_article`.`headline`
					FROM
						`index_article`
					INNER JOIN `index_article_publications` ON (
						`index_article`.`id` = `index_article_publications`.`article_id`
					)
					WHERE
						`index_article_publications`.`publication_id` = 1
					LIMIT 21
					
			方式3
				>>> Article.objects.filter(publications=1)
				<QuerySet [<Article: a1>, <Article: a2>]>
						
					SELECT
						`index_article`.`id`,
						`index_article`.`headline`
					FROM
						`index_article`
					INNER JOIN `index_article_publications` ON (
						`index_article`.`id` = `index_article_publications`.`article_id`
					)
					WHERE
						`index_article_publications`.`publication_id` = 1
					LIMIT 21
			
			publications 从哪里来？
				publications = models.ManyToManyField(Publication)    # 定义多对多关联关系表


		反向查询
		
			>>> p1 = Publication.objects.get(id=2)
			>>> p1.article_set.all()
			<QuerySet [<Article: a1>, <Article: a2>]>
			
			-- 什么时候用 类名_set ?  反向查询的时候用 类名_set。
			
				SELECT
					`index_publication`.`id`,
					`index_publication`.`title`
				FROM
					`index_publication`
				WHERE
					`index_publication`.`id` = 2
				LIMIT 21;
				
				-----------------------------------------
				SELECT
					`index_article`.`id`,
					`index_article`.`headline`
				FROM
					`index_article`
				INNER JOIN `index_article_publications` ON (
					`index_article`.`id` = `index_article_publications`.`article_id`
				)
				WHERE
					`index_article_publications`.`publication_id` = 2
				LIMIT 21;
				

			/*	
			p1 = Publication.objects.get(id=2)
			p1.Article.all()
			
			>>> p1 = Publication.objects.get(id=2)
			>>> p1.Article.all()
			Traceback (most recent call last):
			  File "<console>", line 1, in <module>
			AttributeError: 'Publication' object has no attribute 'Article'
			*/
			

4.3 删除		
	
	正向删除	
		根据文章ID和发布者ID删除 关联关系(index_article_publications表) 的数据
		a = Article.objects.get(pk=1)
		a.publications.remove(1)

			SELECT
				`index_article`.`id`,
				`index_article`.`headline`
			FROM
				`index_article`
			WHERE
				`index_article`.`id` = 1
			LIMIT 21;
			-----------------------------------------
			DELETE
			FROM
				`index_article_publications`
			WHERE
				(
					`index_article_publications`.`article_id` = 1
					AND `index_article_publications`.`publication_id` IN (1)
				)

	反向删除		
		
		p = Publication.objects.get(id=1)
		p.article_set.remove(2)
		p.article_set.all()

			SELECT
				`index_publication`.`id`,
				`index_publication`.`title`
			FROM
				`index_publication`
			WHERE
				`index_publication`.`id` = 1
			LIMIT 21;
			
			-----------------------------------------
			DELETE
			FROM
				`index_article_publications`
			WHERE
				(
					`index_article_publications`.`publication_id` = 1
					AND `index_article_publications`.`article_id` IN (2)
				);
			
			-----------------------------------------
			SELECT
				`index_article`.`id`,
				`index_article`.`headline`
			FROM
				`index_article`
			INNER JOIN `index_article_publications` ON (
				`index_article`.`id` = `index_article_publications`.`article_id`
			)
			WHERE
				`index_article_publications`.`publication_id` = 1
			LIMIT 21;
			
		
		
		
	a.delete() # 删除对象，关联关系也会被删除
		
		>>> a = Article.objects.get(pk=1)
		>>> a.delete()
		(2, {'index.Article_publications': 1, 'index.Article': 1})
			
			SELECT
				`index_article`.`id`,
				`index_article`.`headline`
			FROM
				`index_article`
			WHERE
				`index_article`.`id` = 1
			LIMIT 21;
			
			-----------------------------------------	
			DELETE
			FROM
				`index_article_publications`
			WHERE
				`index_article_publications`.`article_id` IN (1);
				
			-----------------------------------------
			DELETE
			FROM
				`index_article`
			WHERE
				`index_article`.`id` IN (1);	
				
		


5. 模型的继承

5.1 创建数据

-- 创建一个place

	from index.models import Place, Restaurant
	p1 = Place.objects.create(name='coff',address='address1')
	 
		INSERT INTO `index_place` (`name`, `address`) VALUES ('coff', 'address1')
	 
 
-- 创建一个Restaurant

	r1 = Restaurant.objects.create(serves_hot_dogs=True, serves_pizza=False)
	>>> r1.id
	2
		INSERT INTO `index_place` (`name`, `address`) VALUES ('', '')
		INSERT INTO `index_restaurant` (`place_ptr_id`, `serves_hot_dogs`, `serves_pizza`) VALUES (2, 1, 0)
		
		# 可以看到在创建Restaurant的同时，还自动创建了一个Place
		

	r2 = Restaurant.objects.create(serves_hot_dogs=True,serves_pizza=False, name='pizza', address='address2')
	>>> r1.id
	3	
		
		INSERT INTO `index_place` (`name`, `address`) VALUES ('pizza', 'address2')
		INSERT INTO `index_restaurant` (`place_ptr_id`, `serves_hot_dogs`, `serves_pizza`) VALUES (3, 1, 0)
		
		# 可以看到在创建Restaurant的同时，还自动创建了一个Place

		mysql> select * from index_place where id=3;
		+----+-------+----------+
		| id | name  | address  |
		+----+-------+----------+
		|  3 | pizza | address2 |
		+----+-------+----------+
		1 row in set (0.00 sec)

		mysql> select * from index_restaurant where place_ptr_id=3;
		+--------------+-----------------+--------------+
		| place_ptr_id | serves_hot_dogs | serves_pizza |
		+--------------+-----------------+--------------+
		|            3 |               1 |            0 |
		+--------------+-----------------+--------------+
		1 row in set (0.01 sec)


5.2 查询

	p2 = Place.objects.get(name='pizza')
	p2.restaurant

		>>> p2 = Place.objects.get(name='pizza')
		>>> p2.restaurant    # 通过父类查询子类的数据
		<Restaurant: Restaurant object (3)>

			SELECT
				`index_place`.`id`,
				`index_place`.`name`,
				`index_place`.`address`
			FROM
				`index_place`
			WHERE
				`index_place`.`name` = 'pizza'
			LIMIT 21;

			-----------------------------------------

			SELECT
				`index_place`.`id`,
				`index_place`.`name`,
				`index_place`.`address`,
				`index_restaurant`.`place_ptr_id`,
				`index_restaurant`.`serves_hot_dogs`,
				`index_restaurant`.`serves_pizza`
			FROM
				`index_restaurant`
			INNER JOIN `index_place` ON (
				`index_restaurant`.`place_ptr_id` = `index_place`.`id`
			)
			WHERE
				`index_restaurant`.`place_ptr_id` = 3
			LIMIT 21;


-----------------------------------------
	
	r3 = Restaurant.objects.get(pk=3)
	print(r3.name)
	print(r3.place)
			
		>>> r3 = Restaurant.objects.get(pk=3)
		>>> print(r3.name)
		pizza
		>>>
		>>> print(r3.place)        # 不能通过子类查询父类
		Traceback (most recent call last):
		  File "<console>", line 1, in <module>
		AttributeError: 'Restaurant' object has no attribute 'place'


			SELECT
				`index_place`.`id`,
				`index_place`.`name`,
				`index_place`.`address`,
				`index_restaurant`.`place_ptr_id`,
				`index_restaurant`.`serves_hot_dogs`,
				`index_restaurant`.`serves_pizza`
			FROM
				`index_restaurant`
			INNER JOIN `index_place` ON (
				`index_restaurant`.`place_ptr_id` = `index_place`.`id`
			)
			WHERE
				`index_restaurant`.`place_ptr_id` = 3
			LIMIT 21;
			
	
-----------------------------------------


思考：
	什么时候用 get()，什么时候用 filter()
		获取对象的时候用 get() 过滤条件，获取数据的时候用 filter()
		
	反向查询中的 类名_set：
		
	一对多的查询不需要用 join。
	多对多的查询需要用到 join。
	
	remove() 的用法？
	
	orm 中创建的表名，如何添加表的注释 ？
	
	
	
	
	
小结：
	每次重复看视频，都有收获。
	
	
	
	
	