#!/usr/bin/ptyhon
#coding=utf-8

"""
验证一个对象和另一个对象是否是相等(即判断两个对象是否相等)： 验证他们在内存的ID是否一致
self 是指 类实例对象本身
"""

class Hero:
    def __init__(self, name, health_point, magic_point):
        print('will auto run __init__')
        self.name         = name
        self.health_point = health_point
        self.magic_point  = magic_point

    def cat_self(self):
        print(id(self))

caocao = Hero('caocao', 1000, 2000)
print(id(caocao))
caocao.cat_self()

"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python3 2020-03-25-02-class.py
will auto run __init__
35686720
35686720
"""
