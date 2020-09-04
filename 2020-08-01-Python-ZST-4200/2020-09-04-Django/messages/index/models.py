from django.db import models

# Create your models here.

class Reporter(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    email = models.EmailField()

class Message(models.Model):
    id = models.BigAutoField(primary_key=True)  # 更改主键类型
    reporter = models.ForeignKey(Reporter, on_delete=models.CASCADE, null=True)
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
  `ip` char(39) DEFAULT NULL,
  `null_bool` tinyint(1) DEFAULT NULL,
  `uuid` char(32) DEFAULT NULL,
  `reporter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_message_username_2e6c4f68` (`username`),
  KEY `index_message_reporter_id_0e365e65_fk_index_reporter_id` (`reporter_id`),
  CONSTRAINT `index_message_reporter_id_0e365e65_fk_index_reporter_id` FOREIGN KEY (`reporter_id`) REFERENCES `index_reporter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

"""