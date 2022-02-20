from django.db import models

# Create your models here.

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

# 省份表
class Province(models.Model):
    name = models.CharField(max_length=10)

# 城市表
class City(models.Model):
    name = models.CharField(max_length=5)
    province = models.ForeignKey(Province, don_delete=models.CASCADE)

# 人物信息表
class Person(models.Model):
    name = models.CharField(max_length=10)
    living = models.ForeignKey(City, on_delete=models.CASCADE)


