from django.shortcuts import render

# Create your views here.

from index.models import  Product
from django.http import HttpResponse
from django.db.models import Q, Sum, Count

def orm_operater(request):

    # 全表查询
    # 数据以列表形式返回
    # p_res = Product.objects.all()
    # return HttpResponse(p_res)
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product`;
    # <QuerySet [<Product: Product object (1)>, <Product: Product object (2)>, <Product: Product object (3)>, <Product: Product object (4)>]>

    # return HttpResponse(p_res[1].name)
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` LIMIT 1 OFFSET 1; args=()
    # xiaomi2


    # 查询前3条记录
    # p_res = Product.objects.all()[:3]
    # return HttpResponse(p_res)
    #  SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` LIMIT 3;


    # 查询某个字段
    # valules 方法, 以列表形式返回数据, 列表元素以字典格式表示
    # p_res = Product.objects.values('name')
    # return HttpResponse(p_res)
    #  SELECT `index_product`.`name` FROM `index_product`;
    # <QuerySet [{'name': 'xiaomi1'}, {'name': 'xiaomi2'}, {'name': 'mac1'}, {'name':'mac2'}]>

    # values_list 方法, 以列表形式返回数据, 列表元素以元组格式表示
    # p_res = Product.objects.values_list('name')
    # return HttpResponse(p_res)
    # SELECT `index_product`.`name` FROM `index_product`;
    # <QuerySet [('xiaomi1',), ('xiaomi2',), ('mac1',), ('mac2',)]>

    # 使用 get方法 查询数据
    # p_res = Product.objects.get(id = 2)
    # return HttpResponse(p_res)
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` WHERE `index_product`.`id` = 2;
    # Product object (2)


    #  return HttpResponse(p_res.name)
    #  xiaomi2
    #  SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` WHERE `index_product`.`id` = 2;

    # 使用 filter 方法查询数据, 查询结果以列表的形式返回
    #p_res = Product.objects.filter(id = 2)
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` WHERE `index_product`.`id` = 2;
    # <QuerySet [<Product: Product object (2)>]>


    # and 查询: 在 filter方法里面添加多个查询条件
    # p_res = Product.objects.filter(name = 'xiaomi2', id = 2)
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` WHERE (`index_product`.`id` = 2 AND `index_product`.`name` = 'xiaomi2') LIMIT 21;
    # <QuerySet [<Product: Product object (2)>]>

    # or 查询, 需要引入 Q, 编写格式 : Q(field = value) | Q(field = value)
    # p_res = Product.objects.filter(Q(name='xiaomi2') | Q(id=2))
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` WHERE (`index_product`.`name` = 'xiaomi2' OR `index_product`.`id` = 2) LIMIT 21;
    # <QuerySet [<Product: Product object (2)>]>

    # count 方法统计查询数据的数据量
    # p_res = Product.objects.filter(name = 'xiaomi2').count()
    # SELECT COUNT(*) AS `__count` FROM `index_product` WHERE `index_product`.`name` = 'xiaomi2';
    # 1

    # distinct 方法, 去重查询, dictinct 方法无须设置参数, 去重方式根据 values 设置的字段执行
    # 以列表形式返回数据, 列表元素以字典格式表示
    # p_res = Product.objects.values('name').filter(name = 'xiaomi2').distinct()
    # SELECT DISTINCT `index_product`.`name` FROM `index_product` WHERE `index_product`.`name` = 'xiaomi2' LIMIT 21;
    # <QuerySet [{'name': 'xiaomi2'}]>

    #  order by
    # p_res = Product.objects.order_by('-id')
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` ORDER BY `index_product`.`id` DESC LIMIT 21;
    # <QuerySet [<Product: Product object (4)>, <Product: Product object (3)>, <Product: Product object (2)>, <Product: Product object (1)>]>

    # p_res = Product.objects.order_by('-id', 'name')
    # SELECT `index_product`.`id`, `index_product`.`name`, `index_product`.`weight`, `index_product`.`size`, `index_product`.`type_id` FROM `index_product` ORDER BY `index_product`.`id` DESC, `index_product`.`name` ASC LIMIT 21;
    # <QuerySet [<Product: Product object (4)>, <Product: Product object (3)>, <Product: Product object (2)>, <Product: Product object (1)>]>


    # 聚合查询

    # annotate方法 实现 group by, annotate方法类似于 group by方法, 如果不设置 values, 就会默认对主键进行 group by 分组
    # p_res = Product.objects.values('name').annotate(sizes_sum = Sum('size'))
    # SELECT `index_product`.`name`, SUM(`index_product`.`size`) AS `sizes_sum` FROM `index_product` GROUP BY `index_product`.`name` ORDER BY NULL LIMIT 21;
    # <QuerySet [{'name': 'xiaomi1', 'sizes_sum': 100.0}, {'name': 'xiaomi2', 'sizes_sum': 200.0}, {'name': 'mac1', 'sizes_sum': 100.0}, {'name': 'mac2', 'sizes_sum': 200.0}]>

    # aggregate方法 实现 将某个字段的值进行计算并只返回计算结果
    # p_res = Product.objects.aggregate(id_count = Count('id'))
    # SELECT COUNT(`index_product`.`id`) AS `id_count` FROM `index_product`;
    # {'id_count': 4}