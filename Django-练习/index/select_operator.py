from django.shortcuts import render
from django.http import HttpResponse, Http404

from index.models import Type,Product

import logging

logger = logging.getLogger('default')

# Create your views here.

def insert_base_data(request):

    id = Type.objects.create(
        type_name = "phone",
    )

    """
        id = models.AutoField(primary_key=True)
        name = models.CharField(max_length=50)
        weight = models.CharField(max_length=20)
        size = models.CharField(max_length=20)
        type = models.ForeignKey(Type, on_delete=models.CASCADE)

    """

    Product.objects.create(
        name = "xiaomi1",
        weight = 10,
        size = 20,
        type = id
    )

    """
    INSERT INTO `messages`.`index_type` (`id`, `type_name`) VALUES ('1', 'phone');

    INSERT INTO `messages`.`index_product` (`id`, `name`, `weight`, `size`, `type_id`) VALUES ('1', 'xiaomi1', '10', '20', '1');
    INSERT INTO `messages`.`index_product` (`id`, `name`, `weight`, `size`, `type_id`) VALUES ('2', 'xiaomi2', '10', '20', '1');
    INSERT INTO `messages`.`index_product` (`id`, `name`, `weight`, `size`, `type_id`) VALUES ('3', 'mac1', '20', '30', '1');
    INSERT INTO `messages`.`index_product` (`id`, `name`, `weight`, `size`, `type_id`) VALUES ('4', 'mac2', '20', '30', '1');
    """
    return HttpResponse("insert_base_data succss")

"""
# 1. all()全表查询

"""
def select_opt(request):

    # 1. all()全表查询
    # 数据以列表形式返回
    p_res_list = Product.objects.all()
    for i, val in enumerate(p_res_list):
        i_val = "i: {}, val: {}".format(i, p_res_list[i].name)
        print(i_val)
    logger.warning(type(p_res_list))
    """
    i: 0, val: xiaomi1
    i: 1, val: xiaomi2
    i: 2, val: mac1
    i: 3, val: mac2
    <class 'django.db.models.query.QuerySet'>
    """

    # 2. values()方法查询某个字段
    name = Product.objects.values('name')
    print("name: {}".format(name[1]['name']))
    # name: xiaomi2

    name2 = Product.objects.filter(id=1).values('name')
    print(name2)
    # <QuerySet [{'name': 'xiaomi1'}]>
    
    return HttpResponse("...")