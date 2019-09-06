#!/usr/local/bin/python3
#coding=utf-8

"""
*args 的使用方法
    *args 用来将参数打包成 tuple(元组) 给函数体调用
"""
def function(*args):
    print(args, type(args))

function(1)

"""
输出:
((1,), <type 'tuple'>)
"""

def function_2(x, y, *args):
    print(x, y, args)

function_2(1, 2, 3, 4, 5)

"""
输出:
(1, 2, (3, 4, 5))
"""

"""
 **kwargs 的使用方法
 **kwargs 打包关键字参数成 dict(字典) 给函数体调用
"""

def function_03(**kwargs):
    print(kwargs, type(kwargs))

function_03(a=2)

"""
输出
({'a': 2}, <type 'dict'>)
"""


def function_04(**kwargs):
    print(kwargs)

function_04(a=1, b=2, c=3)

"""
输出:
{'a': 1, 'c': 3, 'b': 2}
"""


def function_05(arg,*args,**kwargs):
    print(arg,args,kwargs)

function_05(6,7,8,9,a=1, b=2, c=3)

"""
输出:
(6, (7, 8, 9), {'a': 1, 'c': 3, 'b': 2})
"""

def function_06(*args,**kwargs):
    print(args,kwargs)

function_06('lujb', 'hello world', a=2)

# 参考:
#　https://www.cnblogs.com/yunguoxiaoqiao/p/7626992.html