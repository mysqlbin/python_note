#!/usr/bin/ptyhon
#coding=utf-8

"""
类里面所有的方法第一个参数要写self
"""

class Hero:
    def __init__(self, name, health_point, magic_point):
        print('will auto run __init__')
        self.name         = name
        self.health_point = health_point
        self.magic_point  = magic_point

    # 类里面所有的方法第一个参数要写self和类方法传入参数
    def final_skill(self, skill_name):
        print('%s 的终极大招是 %s ' % (self.name, skill_name))

caocao = Hero('caocao', 1000, 2000)
caocao.final_skill('一刀斩')
"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python3 2020-03-25-03-class.py
will auto run __init__
caocao 的终极大招是 一刀斩
"""
