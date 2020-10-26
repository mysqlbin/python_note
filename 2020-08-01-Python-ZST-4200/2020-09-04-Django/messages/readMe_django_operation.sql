
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

5. 模型的继承 --OneToOne
	5.1 创建数据
	5.2 查询
	5.3 应用场景
	
6. Model class Meta 和 abstract

7. Model def __str__(self)
	

小结
	
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

	

	Message.objects.create(content="hello world")
	INSERT INTO `index_message` (`username`, `content`, `create_time`, `deleted`, `email`, `ip`, `null_bool`, `uuid`) VALUES ('', 'hello world', '2020-09-04 08:13:27.516953', 0, NULL, NULL, NULL, NULL)

	mysql> select * from test2_db.index_message;
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

		DELETE FROM `index_message` WHERE `index_message`.`id` = 1

	
2.3 Read
	
	贸易商起来
	mysql>select * from test2_db.index_message;
	+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
	| id | username | content      | create_time                | deleted | email | ip   | null_bool | uuid | reporter_id |
	+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
	|  1 |          | hello world  | 2020-09-12 09:05:09.249220 |       0 | NULL  | NULL |      NULL | NULL |        NULL |
	|  2 |          | hello world3 | 2020-09-12 09:05:21.624291 |       0 | NULL  | NULL |      NULL | NULL |        NULL |
	+----+----------+--------------+----------------------------+---------+-------+------+-----------+------+-------------+
	2 rows in set (0.00 sec)
	
	-----------------------------------------------------------------------
	
	from index.models import Message
	  
	Message.objects.all()   # 查询所有的数据
	Message.objects.get(pk=1)
	Message.objects.get(id=1)
	m = Message.objects.get(content='a',even_field=3)
	DoesNotExist: Message matching query does not exist.
	Message.objects.filter(content='a')
	Message.objects.filter(create_time__lte='2020-04-18')
	exclude

	-----------------------------------------------------------------------
	
	>>> Message.objects.all()
	
	<QuerySet [<Message:  2020-09-12 09:05:09.249220+00:00 None>, <Message:  2020-09-12 09:05:21.624291+00:00 None>]>	

		SELECT `index_message`.`id`,
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
		LIMIT 21
	
	-----------------------------------------------------------------------	
	
	>>> Message.objects.get(pk=1)
	<Message:  2020-09-12 09:05:09.249220+00:00 None>
	
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
			`index_message`.`id` = 1
		LIMIT 21		
		
	-----------------------------------------------------------------------	
		
	>>> Message.objects.get(id=2)
	<Message:  2020-09-12 09:05:09.249220+00:00 None>	
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
			`index_message`.`id` = 2
		LIMIT 21	
	
	-----------------------------------------------------------------------
	
	>>> Message.objects.filter(content='hello world')
	 -- <QuerySet [<Message: Message object (3)>]>	
	 <QuerySet [<Message:  2020-09-12 09:05:09.249220+00:00 None>]>
	
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
			`index_message`.`content` = 'hello world'
		LIMIT 21
	
	-----------------------------------------------------------------------
	
	>>> Message.objects.filter(create_time__lte='2020-09-12 09:05:21')
	D:\anzhuang\python\lib\site-packages\django\db\models\fields\__init__.py:1368: RuntimeWarning: DateTimeField Message.create_time received a naive datetime (2020-09-12 09:05:21) while time zone support is active.
	  RuntimeWarning)
	<QuerySet [<Message:  2020-09-12 09:05:09.249220+00:00 None>]>
	
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
			`index_message`.`create_time` <= '2020-09-12 09:05:21'
		LIMIT 2	
		
	-----------------------------------------------------------------------
	
	
3. ManyToOne	
	
	关联关系为一对多
	
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
		
		反向查询：查询对象的主体是模型 Reporter，要通过模型 Reporter 查询模型 Message 的数据。 
		
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
		正向查询：查询对象的主体是模型 Message，要查询模型 Message 的数据。
		
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
				
		


5. 模型的继承 --OneToOne
	
	class Place(models.Model):
		name = models.CharField(max_length=50)
		address = models.CharField(max_length=80)
		
	class Restaurant(Place):
		serves_hot_dogs = models.BooleanField(default=False)
		serves_pizza = models.BooleanField(default=False)

	
	Restaurant 是一个子类，继承了 Place 这个父类
	在应用中，在创建 Restaurant 的同时，还自动创建了一个 Place
	
	-- 对应的表结构如下
		CREATE TABLE `index_place` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(50) NOT NULL,
		  `address` varchar(80) NOT NULL,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


		CREATE TABLE `index_restaurant` (
		  `place_ptr_id` int(11) NOT NULL,
		  `serves_hot_dogs` tinyint(1) NOT NULL,
		  `serves_pizza` tinyint(1) NOT NULL,
		  PRIMARY KEY (`place_ptr_id`),
		  CONSTRAINT `index_restaurant_place_ptr_id_9254a287_fk_index_place_id` FOREIGN KEY (`place_ptr_id`) REFERENCES `index_place` (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	 
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
		
		-- 可以看到在创建 Restaurant 的同时，还自动创建了一个 Place
		

	r2 = Restaurant.objects.create(serves_hot_dogs=True,serves_pizza=False, name='pizza', address='address2')
	>>> r1.id
	3	
		
		INSERT INTO `index_place` (`name`, `address`) VALUES ('pizza', 'address2')
		INSERT INTO `index_restaurant` (`place_ptr_id`, `serves_hot_dogs`, `serves_pizza`) VALUES (3, 1, 0)
		
		-- 可以看到在创建 Restaurant 的同时，还自动创建了一个 Place

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
		>>> p2.restaurant    -- 通过父类查询子类的数据
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
		
		>>> print(r3.place)        -- 不能通过子类查询父类，理解了
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
			
5.3 应用场景

	一对一的关系
	什么时候会用模型的继承呢？
		当需要把一些字段拆分出去的时候，就可以使用模型的继承
		-- 理解了。

-----------------------------------------


6. Model class Meta 和 abstract

	class CommonInfo(models.Model):
		gmt_update = models.DateTimeField(auto_now=True, null=True, blank=True)
		gmt_create = models.DateTimeField(auto_now_add=True, null=True, blank=True)

		class Meta:
			abstract = True

	class Users(CommonInfo):
		first_name = models.CharField(max_length=30)
		last_name = models.CharField(max_length=30)
		email = models.EmailField()
		def __str__(self):
			return "%s %s %s" % (self.first_name, self.last_name, self.email)

		class Meta:
			ordering=['email']
	
	>>> from index.models import Users
	>>> Users.objects.all()
	<QuerySet [<Users: la la 1114056230@qq.com>, <Users: la la 1224056230@qq.com>, <Users: okc okc 1334056230@qq.com>, <Users: la la 1444056230@qq.com>]>
	
		SELECT
			`index_users`.`id`,
			`index_users`.`gmt_update`,
			`index_users`.`gmt_create`,
			`index_users`.`first_name`,
			`index_users`.`last_name`,
			`index_users`.`email`
		FROM
			`index_users`
		ORDER BY
			`index_users`.`email` ASC
		LIMIT 21;

		ljb_user@mysqldb 11:15:  [test2_db]> select * from index_users;
		+----+----------------------------+----------------------------+------------+-----------+-------------------+
		| id | gmt_update                 | gmt_create                 | first_name | last_name | email             |
		+----+----------------------------+----------------------------+------------+-----------+-------------------+
		|  1 | 2020-09-09 12:14:49.000000 | 2020-09-09 12:14:52.000000 | la         | la        | 1224056230@qq.com |
		|  2 | NULL                       | 2020-09-09 12:15:14.000000 | okc        | okc       | 1334056230@qq.com |
		|  3 | NULL                       | NULL                       | la         | la        | 1444056230@qq.com |
		|  4 | NULL                       | NULL                       | la         | la        | 1114056230@qq.com |
		+----+----------------------------+----------------------------+------------+-----------+-------------------+
		4 rows in set (0.00 sec)


	ordering=['email'] 表示 返回的结果集 根据 email 排序。
	


7. Model def __str__(self)

	class CommonInfo(models.Model):
		gmt_update = models.DateTimeField(auto_now=True, null=True, blank=True)
		gmt_create = models.DateTimeField(auto_now_add=True, null=True, blank=True)

		class Meta:
			abstract = True

	class Users(CommonInfo):
		first_name = models.CharField(max_length=30)
		last_name = models.CharField(max_length=30)
		email = models.EmailField()
		# 重写 __str__ 方法，自定义输出数据的格式
		def __str__(self):
			return "%s %s %s" % (self.first_name, self.last_name, self.email)

		class Meta:
			ordering=['email']
	
	>>> from index.models import Users
	>>> Users.objects.all()
	<QuerySet [<Users: la la 1114056230@qq.com>, <Users: la la 1224056230@qq.com>, <Users: okc okc 1334056230@qq.com>, <Users: la la 1444056230@qq.com>]>
	

		ljb_user@mysqldb 11:15:  [test2_db]> select * from index_users;
		+----+----------------------------+----------------------------+------------+-----------+-------------------+
		| id | gmt_update                 | gmt_create                 | first_name | last_name | email             |
		+----+----------------------------+----------------------------+------------+-----------+-------------------+
		|  1 | 2020-09-09 12:14:49.000000 | 2020-09-09 12:14:52.000000 | la         | la        | 1224056230@qq.com |
		|  2 | NULL                       | 2020-09-09 12:15:14.000000 | okc        | okc       | 1334056230@qq.com |
		|  3 | NULL                       | NULL                       | la         | la        | 1444056230@qq.com |
		|  4 | NULL                       | NULL                       | la         | la        | 1114056230@qq.com |
		+----+----------------------------+----------------------------+------------+-----------+-------------------+
		4 rows in set (0.00 sec)


	return "%s %s %s" % (self.first_name, self.last_name, self.email)：
		返回的结果集只有 first_name、last_name、email 这3个字段的值。
		后台对应的模型 显示这3个字段的值。

		

model 
	username = models.CharField(max_length=64, db_index=True, help_text="用户名", verbose_name='用户名')

	null=True, blank=True, help_text="创建时间", verbose_name='开课时间'
	null=True:               是否允许为NULL， 允许
	blank=True:              处理多对多的关联关系时，是否允许为空
	help_text="创建时间"：     
	verbose_name='开课时间'： 后台在显示 username 字段的时候，显示的 '开课时间' 。
	
	



思考：

	什么时候用 get()，什么时候用 filter()
		获取对象的时候用 get() 过滤条件，获取数据的时候用 filter()
		
	反向查询中的 类名_set：
		
		
	一对多的查询不需要用 join。
	多对多的查询需要用到 join。
	
	remove() 的用法？
	
	orm 中创建的表名，如何添加表的注释 ？
	
	
	
小结
	每次重复看视频，都有收获。
	模型的继承：
		abstract
		
	模型的对应关系
		ForeignKey：一对多
		OneToOneField： 一对一
		ManyToManyField：多对多
	
	
	什么时候会用模型的继承呢：
		当需要把一些字段拆分出去的时候，就可以使用模型的继承
	
	