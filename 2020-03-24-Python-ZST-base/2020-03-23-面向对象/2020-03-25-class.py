#!/usr/bin/ptyhon
#coding=utf-8

"""
类实例属性，在类的所有方法中，可以直接使用
类实例属性: 在 __init__ 函数中、一般作为参数传进来， 要赋予类实例属性
"""

class Hero:
    def __init__(self, name, health_point, magic_point):
        print('will auto run __init__')
        self.name         = name
        self.health_point = health_point
        self.magic_point  = magic_point

    # 类方法传入参数
    def final_skill(self, skill_name):
        print(self.magic_point)       # 类实例属性，在类的所有方法中，可以直接使用\
        print('%s 的终极大招是 %s ' % (self.name, skill_name))

caocao = Hero('caocao', 1000, 2000)
caocao.final_skill('一刀斩')
"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python3 2020-03-25-class.py
will auto run __init__
2000
caocao 的终极大招是 一刀斩
"""
