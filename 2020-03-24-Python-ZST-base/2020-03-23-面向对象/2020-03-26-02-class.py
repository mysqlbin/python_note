#!/usr/bin/ptyhon
#coding=gbk

"""
类实例属性继承需要在 __init__(self) 中加上 FasterCalss.__init__(self)
"""

class Faster:
    
    def __init__(self, age, height):
        print('will auto run __init__')
        self.age    = age
        self.height = height

    def eat(self):
        print('我饿了，想吃饭')

class Son(Faster):

    def __init__(self, age, height):
        Faster.__init__(self, age, height)

    def sing(self):
        print('我想唱歌')

me = Son(8, 150)
print(me.age)
print(me.height)
me.eat()
me.sing()

"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-26-01-class.py
will auto run __init__
8
150
我饿了，想吃饭
我想唱歌
"""
