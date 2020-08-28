#!/usr/bin/ptyhon
#coding=utf-8

"""
类的初始化
"""
class Hero:
    def __init__(self, name, health_point, magic_point):
        print('auto run __init__')
        self.name         = name
        self.health_point = health_point
        self.magic_point  = magic_point


caocao = Hero('caocao', 1000, 2000)
print('生命值：%s' % caocao.health_point)

"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python3 2020-03-24-class.py
auto run __init__
生命值：1000
"""


