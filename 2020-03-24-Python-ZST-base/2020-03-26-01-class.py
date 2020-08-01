#!/usr/bin/ptyhon
#coding=gbk

"""
子类默认会继承父类的默认方法
这里的子类默认会继承父类的  eat() 方法
"""

class Faster:

    def __init__(self, age, height):
        self.age    = age
        self.height = height

    def eat(self):
        print('我饿了，想吃饭')

class Son(Faster):

    pass


me = Son(8, 150)
print(me.age)
print(me.height)
me.eat()

"""
tudy\python\python_note\2020-03-24-Python-ZST>python 2020-03-26-01-class.py
will auto run __init__
8
150
我饿了，想吃饭
"""
