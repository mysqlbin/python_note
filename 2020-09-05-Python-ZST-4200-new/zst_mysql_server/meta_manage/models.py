from django.db import models
from django.core.exceptions import ValidationError

# Create your models here.

# 抽象类
class CommonInfo(models.Model):
    gmt_update = models.DateTimeField(auto_now=True, null=True, blank=True)
    gmt_create = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    class Meta:
        abstract = True


class Host(models.Model):
    name = models.CharField(max_length=30)
    memory = models.CharField(max_length=30)
    cpu = models.IntegerField()

class MySQLSchema(CommonInfo):
    MASTER = 'master'
    SLAVE = 'slave'
    id = models.BigAutoField(primary_key=True)
    # host_ip = models.GenericIPAddressField(max_length=128)
    host_ip = models.ForeignKey(Host, on_delete=models.CASCADE)  # 一个主机下可以有多个数据库实例
    port = models.IntegerField()
    schema = models.CharField(max_length=64)
    role = models.CharField(max_length=64, choices=((MASTER, 'master'), (SLAVE, 'slave')))
    status = models.EmailField(max_length=64, default='online')

    #class Meta:
        # unique_together = ('host_ip', 'port', 'schema', 'role')

    def __str__(self):
        return "MySQLSchema-{}-{}-{}-{}".format(self.host_ip, self.port, self.schema, self.role)


    # def save(self, *args, **kwargs):
    #     exist = MySQLSchema.objects.filter(host_ip=self.host_ip, port=self.port, schema=self.schema, role=self.role).exists()
    #     if exist:
    #         raise ValidationError("repeat data　－" + str(self))
    #     super().save(self, *args, **kwargs)


    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        exists = MySQLSchema.objects.filter(
            host_ip=self.host_ip,
            port=self.port,
            schema=self.schema,
            role=self.role).exists() # objects是一个模型管理器，默认的模型管理
        if exists:
            raise ValidationError("repeat data for " + str(self))
        
        super().save(force_insert=force_insert, force_update=force_update, using=using, update_fields=update_fields)



"""

CREATE TABLE `meta_manage_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `memory` varchar(30) NOT NULL,
  `cpu` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `meta_manage_mysqlschema` (
  `gmt_update` datetime(6) DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `port` int(11) NOT NULL,
  `schema` varchar(64) NOT NULL,
  `role` varchar(64) NOT NULL,
  `status` varchar(64) NOT NULL,
  `host_ip_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `meta_manage_mysqlsch_host_ip_id_fdb874d5_fk_meta_mana` (`host_ip_id`),
  CONSTRAINT `meta_manage_mysqlsch_host_ip_id_fdb874d5_fk_meta_mana` FOREIGN KEY (`host_ip_id`) REFERENCES `meta_manage_host` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



"""