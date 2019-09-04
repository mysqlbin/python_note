#!/usr/local/bin/python3
#coding=utf-8



import os

path = os.path.abspath(os.path.dirname(__file__))
filename = os.path.join(path, "iter.txt")

#官方示例：读文件直到读的为空时。
with open(filename) as fp:
    for line in iter(fp.readline, ''):
        print(line)

"""

1. iter(object[, sentinel]) 根据传入的参数创建一个新的可迭代对象。

2、函数功能返回一个可迭代对象。

3、当第二个参数不提供时，第一个参数必须是一个支持可迭代协议(即实现了__iter__()方法)的集合(字典、集合、不可变集合)
    或者支持序列协议(即实现了__getitem__()方法，方法接收一个从0开始的整数参数)的序列(元组、列表、字符串)，否则将报错。
"""









