#!/usr/local/bin/python3
#coding=utf-8


import json
import os

#JSON序列化与实战

"""
JSON的概念:
    JSON（JavaScript Object Notation）是一种轻量级的数据交换格式
    JSON 在当今互联网中应用非常广泛，也是每一个用 Python 程序员应当熟练掌握的技能点。

JSON的设计意图:
    是把所有事情都用设计的字符串来表示，这样既方便在互联网上传递信息，也方便人进行阅读（相比一些 binary 的协议）。

JSON的两种黑箱:
    第一种，输入这些杂七杂八的信息，比如 Python 字典，输出一个字符串；
    第二种，输入这个字符串，可以输出包含原始信息的 Python 字典。

"""

"""
params = {
    'symbol': '123456',
    'type': 'limit',
    'price': 123.4,
    'amount': 23
}

params_str = json.dumps(params)

print('after json serialization')
print('type of params_str = {}, params_str = {}'.format(type(params_str), params))

original_params = json.loads(params_str)

print('after json deserialization')
print('type of original_params = {}, original_params = {}'.format(type(original_params), original_params))
"""
########## 输出 ##########

"""
after json serialization
type of params_str = <class 'str'>, params_str = {'symbol': '123456', 'type': 'limit', 'price': 123.4, 'amount': 23}
after json deserialization
type of original_params = <class 'dict'>, original_params = {'symbol': '123456', 'type': 'limit', 'price': 123.4, 'amount': 23}
"""


"""
json.dumps() 函数:
    表示接受 Python 的基本数据类型，然后将其序列化为 string；
json.loads() 函数:
    表示接受一个合法字符串，然后将其反序列化为 Python 的基本数据类型。
记得加上错误处理。不然，哪怕只是给 json.loads() 发送了一个非法字符串，而你没有 catch 到，程序就会崩溃了。
"""



# 输出字符串到文件，或者从文件中读取 JSON 字符串
"""
    通过 open() 和 read()/write() ，先将字符串读取 / 输出到内存，再进行 JSON 编码 / 解码
"""



params = {
    'symbol': '123456',
    'type': 'limit',
    'price': 123.4,
    'amount': 23
}

path = os.path.abspath(os.path.dirname(__file__))
filename = os.path.join(path, "params.json")

with open(filename, 'w') as fout:
    params_str = json.dump(params, fout)


with open(filename, 'r') as fin:
    original_params = json.load(fin)

print('after json deserialization')
print('type of original_params = {}, original_params = {}'.format(type(original_params), original_params))

########## 输出 ##########
"""
after json deserialization
type of original_params = <class 'dict'>, original_params = {'symbol': '123456', 'type': 'limit', 'price': 123.4, 'amount': 23}
"""


