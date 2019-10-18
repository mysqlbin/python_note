#!/usr/local/bin/python3
#coding=utf-8
import os
import sys
print(sys.version)

result = {'status': 0, 'msg': 'ok', 'data': {'priv_check': 1111, 'limit_num': 0}}
print(result['data']['priv_check'])



BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
print(BASE_DIR)

#遍历
dict_20190624 = {'name': 'jason', 'age': 20, 'gender': 'male'}
dict_20190624_for = [res for res in dict_20190624]

print(dict_20190624_for)
"""
返回:
    ['gender', 'age', 'name']
"""
#字典本身只有键是可以迭代的.
#[res for res in dict_20190624] 等于下面的写法

list_20190624 = []
for res in dict_20190624:
    list_20190624.append(res)
print(list_20190624)



#创建字典
d1 = {'name': 'jason', 'age': 20, 'gender': 'male'}
d2 = dict({'name': 'jason', 'age': 20, 'gender': 'male'})
d3 = dict([('name', 'jason'), ('age', 20), ('gender', 'male')])
d4 = dict(name='jason', age=20, gender='male')
print(d1)
print(d2)
print(d3)
print(d4)
"""
{'name': 'jason', 'age': 20, 'gender': 'male'}
"""
#创建集合
s1 = {1, 2, 3}
s2 = set([1, 2, 3])
s1 == s2
print(s1)
print(s2)
"""
{1, 2, 3}
"""

#访问字典
d = {'name': 'jason', 'age': 20}
print(d.get('name'))  #'jason'
print(d.get('location', 'null'))   #null

#判断一个元素在不在字典或者集合内，可以用 value in dict/set 来判断
#判断一个元素在不在集合内  #集合不支持索引操作
s = {1, 2, 3}
print(1 in s)    #True
print(10 in s)   #False


#判断一个元素在不在字典内                ***************常用的判断
d = {'name': 'jason', 'age': 20}
print('name' in d)       #True
print('location' in d)  #False


#字典增加元素
add_dict = {'name': 'jason', 'age': 20}
add_dict['gender'] = 'male' # 增加元素对'gender': 'male'
add_dict['dob'] = '1999-02-01' # 增加元素对'dob': '1999-02-01'
print(add_dict)

#字典更新元素
update_dict = {'name': 'jason', 'age': 20, 'gender': 'male', 'dob': '1999-02-01'}
update_dict['dob'] = '1998-01-01' # 更新键'dob'对应的值
print(update_dict)

#字典删除元素
delete_dict = {'name': 'jason', 'age': 20, 'gender': 'male', 'dob': '1999-02-01'}
delete_dict.pop('dob') # 删除键为'dob'的元素
print(delete_dict)


#集合增加元素
add_set = {1,2,3}
add_set.add(4)             #从集合中添加元素4
print(add_set)
#集合删除元素
delete_set = {1,2,3,4}
delete_set.remove(4)       #从集合中删除元素4
print(delete_set)


#对字典或集合进行排序

#对于字典，我们通常会根据键或者值，进行升序或降序排序：
d = {'b': 1, 'a': 2, 'c': 10}
d_sorted_by_key = sorted(d.items(), key=lambda x: x[0])    # 根据字典键的升序排序
d_sorted_by_value = sorted(d.items(), key=lambda x: x[1])  # 根据字典值的升序排序
#当然，因为字典本身是无序的，所以这里返回了一个列表。列表中的每个元素，是由原字典的键和值组成的元组。
print(d_sorted_by_key)       #[('a', 2), ('b', 1), ('c', 10)]
print(d_sorted_by_value)     #[('b', 1), ('a', 2), ('c', 10)]

#而对于集合，其排序和前面讲过的列表、元组很类似，直接调用 sorted(set) 即可，结果会返回一个排好序的列表。
sort_set = {1,3,4,2}
sort_set = sorted(sort_set)
print(sort_set)   #{1，2，3，4}


"""
import time
id = [x for x in range(0, 100000)]
price = [x for x in range(200000, 300000)]
products = list(zip(id, price))

# 计算列表版本的时间
start_using_list = time.perf_counter()
find_unique_price_using_list(products)
end_using_list = time.perf_counter()
print("time elapse using list: {}".format(end_using_list - start_using_list))
## 输出
time elapse using list: 41.61519479751587

# 计算集合版本的时间
start_using_set = time.perf_counter()
find_unique_price_using_set(products)
end_using_set = time.perf_counter()
print("time elapse using set: {}".format(end_using_set - start_using_set))
# 输出
time elapse using set: 0.008238077163696289

"""


