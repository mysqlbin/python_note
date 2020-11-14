from django.db import models

# Create your models here.

# 基础表，包含了gmt_update 和gmt_create两个字段
class CommonModel(models.Model):
    gmt_update = models.DateTimeField(auto_now=True, null=True)
    gmt_create = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        abstract = True


# 表示MySQL实例所在的物理机
class Hosts(CommonModel):
    name = models.CharField(max_length=30)
    memory = models.CharField(max_length=30)
    cpu = models.CharField(max_length=30)

    def __str__(self):
        return f"Host: {self.id}-{self.name}-{self.memory}-{self.cpu}"
