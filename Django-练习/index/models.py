from django.db import models

# Create your models here.


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



# 创建产品分类表
class Type(models.Model):
    id = models.AutoField(primary_key=True)
    type_name = models.CharField(max_length=20)

# 创建产品信息表
class Product(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    weight = models.CharField(max_length=20)
    size = models.CharField(max_length=20)
    type = models.ForeignKey(Type, on_delete=models.CASCADE)

