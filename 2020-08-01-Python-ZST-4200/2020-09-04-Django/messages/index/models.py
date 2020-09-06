from django.db import models

# Create your models here.

class Reporter(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    email = models.EmailField()

class Message(models.Model):
    id = models.BigAutoField(primary_key=True)  # 更改主键类型
    reporter = models.ForeignKey(Reporter, on_delete=models.CASCADE, null=True) # 定义关联外键
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

"""

class Publication(models.Model):
    title = models.CharField(max_length=30)
	# articles = models. ManyToManyField(Article)
    def __str__(self):
        return self.title

class Article(models.Model):
    headline = models.CharField(max_length=100)
    publications = models.ManyToManyField(Publication)

    def __str__(self):
        return self.headline


"""

CREATE TABLE `index_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `headline` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `index_publication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `index_article_publications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `publication_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_article_publicatio_article_id_publication_i_c75b16f5_uniq` (`article_id`,`publication_id`),
  KEY `index_article_public_publication_id_f1931303_fk_index_pub` (`publication_id`),
  CONSTRAINT `index_article_public_article_id_fe0b71c4_fk_index_art` FOREIGN KEY (`article_id`) REFERENCES `index_article` (`id`),
  CONSTRAINT `index_article_public_publication_id_f1931303_fk_index_pub` FOREIGN KEY (`publication_id`) REFERENCES `index_publication` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

"""