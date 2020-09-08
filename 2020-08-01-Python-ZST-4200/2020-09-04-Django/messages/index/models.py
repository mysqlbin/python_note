from django.db import models

# Create your models here.

class Reporter(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    email = models.EmailField()

class Message(models.Model):
    id = models.BigAutoField(primary_key=True)  # 更改主键类型
    reporter = models.ForeignKey(Reporter, on_delete=models.CASCADE, null=True) # 定义关联外键，外键字段为 reporter_id
    username = models.CharField(max_length=64, db_index=True, help_text="用户名")
    content = models.TextField(max_length=65535, help_text="内容")
    create_time = models.DateTimeField(auto_now_add=True, null=True, blank=True,help_text="创建时间")
    deleted = models.BooleanField(default=False, help_text="是否被删除")
    email = models.EmailField(help_text="邮箱", null=True)
    ip = models.GenericIPAddressField(null=True, help_text="ip地址")
    null_bool = models.NullBooleanField()
    # img = models.ImageField(null=True)
    uuid = models.UUIDField(null=True)



"""

ForeignKey

CREATE TABLE `index_reporter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `index_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `content` longtext NOT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `ip` char(39) DEFAULT NULL,Article
  `null_bool` tinyint(1) DEFAULT NULL,
  `uuid` char(32) DEFAULT NULL,
  `reporter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_message_username_2e6c4f68` (`username`),
  KEY `index_message_reporter_id_0e365e65_fk_index_reporter_id` (`reporter_id`),
  CONSTRAINT `index_message_reporter_id_0e365e65_fk_index_reporter_id` FOREIGN KEY (`reporter_id`) REFERENCES `index_reporter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

reporter = models.ForeignKey(Reporter, on_delete=models.CASCADE, null=True) # 定义关联外键
    on_delete=models.CASCADE： 当删除 reporter表 记录的时候，对应的 message表的记录也会被删除
    
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
			
 
"""

class Publication(models.Model):
    title = models.CharField(max_length=30)
	# articles = models. ManyToManyField(Article)
    def __str__(self):
        return self.title

class Article(models.Model):
    headline = models.CharField(max_length=100)
    publications = models.ManyToManyField(Publication)    # 定义多对多关联关系表

    def __str__(self):
        return self.headline


"""

ManyToMany: 多对多关系 • 
我们这里创建两张表，表示文章和出版社：一篇文章可以由多个出版社出版， 一个出版社可以发表多篇文章

CREATE TABLE `index_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `headline` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 comment='文章表';

CREATE TABLE `index_publication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 comment='发布者/作者表';

CREATE TABLE `index_article_publications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `publication_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_article_publicatio_article_id_publication_i_c75b16f5_uniq` (`article_id`,`publication_id`),
  KEY `index_article_public_publication_id_f1931303_fk_index_pub` (`publication_id`),
  CONSTRAINT `index_article_public_article_id_fe0b71c4_fk_index_art` FOREIGN KEY (`article_id`) REFERENCES `index_article` (`id`),
  CONSTRAINT `index_article_public_publication_id_f1931303_fk_index_pub` FOREIGN KEY (`publication_id`) REFERENCES `index_publication` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 comment='文章和发布者关联表';

from index.models import Article, Publication
操作 index_article 表的写法： Article
操作 index_publication 表的写法： Publication
操作 index_article_publications 关联关系表的写法： publications

"""


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
        return "%s %s" % (self.first_name, self.last_name)

"""

模型继承： Django提供了 abstract model
abstract： 抽象

CREATE TABLE `index_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_update` datetime(6) DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

"""


class Place(models.Model):
    name = models.CharField(max_length=50)
    address = models.CharField(max_length=80)

class Restaurant(Place):
    serves_hot_dogs = models.BooleanField(default=False)
    serves_pizza = models.BooleanField(default=False)


"""

模型继承： OneToOne 的思想

λ python manage.py makemigrations
Migrations for 'index':
  index\migrations\0006_place_restaurant.py
    - Create model Place
    - Create model Restaurant
    
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


"""