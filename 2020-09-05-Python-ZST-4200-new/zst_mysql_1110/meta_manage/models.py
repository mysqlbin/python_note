from django.db import models
from django.core.exceptions import ValidationError


# 基础表，包含了gmt_update 和gmt_create两个字段
class CommonModel(models.Model):
    gmt_update = models.DateTimeField(auto_now=True, null=True)
    gmt_create = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        abstract = True


# 表示MySQL实例所在的物理机
class Host(CommonModel):
    name = models.CharField(max_length=30)
    memory = models.CharField(max_length=30)
    cpu = models.CharField(max_length=30)

    def __str__(self):
        return f"Host: {self.id}-{self.name}-{self.memory}-{self.cpu}"

# Create your models here.
class MySQLSchema(CommonModel):
    MASTER = 'master'
    SLAVE = 'slave'
    id = models.BigAutoField(primary_key=True)
    host_ip = models.GenericIPAddressField(max_length=64)
    port = models.IntegerField()
    schema = models.CharField(max_length=64)
    role = models.CharField(max_length=64, choices=((MASTER, 'master'), (SLAVE, 'slave')))
    status = models.EmailField(max_length=64, null=False, default='online')
    phy_host = models.ForeignKey(Host, null=True, on_delete=models.PROTECT, db_constraint=False)
    instance_name = models.CharField(max_length=128, null=True, default=None)

    class Meta:
        db_table = "mysql_schema"

    def __str__(self):
        return "MySQLSchema-{}-{}-{}-{}".format(self.host_ip, self.port, self.schema, self.role)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        exists = MySQLSchema.objects.filter(
            host_ip=self.host_ip,
            port=self.port,
            schema=self.schema,
            role=self.role).exists() # objects是一个模型管理器，默认的模型管理
        if exists:
            raise ValidationError("repeat data for " + str(self))

        super().save(force_insert=force_insert, force_update=force_update, using=using,update_fields=update_fields)


class SchemaModel(models.Model):
    MYSQL = 'MySQL'
    SQLSERVER = 'SQLServer'
    REDIS = 'Redis'
    schema = models.CharField(max_length=128, verbose_name='库名')
    db_type = models.CharField(choices=[
        (MYSQL, 'mysql'),
        (SQLSERVER, 'sqlserver'),
        (REDIS, 'redis')
    ], max_length=128, verbose_name='数据库类型')
    ip = models.GenericIPAddressField(verbose_name='ip')
    port = models.IntegerField(verbose_name='端口')



class SchemaTest3(models.Model):
    MYSQL = 'MySQL'
    SQLSERVER = 'SQLServer'
    REDIS = 'Redis'
    schema = models.CharField(max_length=128, verbose_name='库名')
    db_type = models.CharField(choices=[
        (MYSQL, 'mysql'),
        (SQLSERVER, 'sqlserver'),
        (REDIS, 'redis')
    ], max_length=128, verbose_name='数据库类型')
    ip = models.GenericIPAddressField(verbose_name='ip')
    port = models.IntegerField(verbose_name='端口')

    class Meta:
        managed = False
        db_table = 'schema_test3'
        verbose_name = u'测试表'
        verbose_name_plural = u'测试表'

