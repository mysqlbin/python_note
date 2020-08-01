#!/usr/bin/ptyhon
#coding=gbk

"""
子类可以更改继承父类的财产

这里的子类更改了继承父类的 eat() 方法

"""

class Faster:
    
    def __init__(self, age, height):
        print('will auto run __init__')
        self.age    = age
        self.height = height

    def eat(self):
        print('我饿了，想吃饭')

class Son(Faster):

    def __init__(self, age, height, weight):
        Faster.__init__(self, age, height)
        self.weight = weight

    def sing(self):
        print('我想唱歌')

    def eat(self):
        print('我饿了，想喝粥')

me = Son(8, 150, 50)
print(me.age)
print(me.height)
print(me.weight)
me.eat()
me.sing()

"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-26-01-class.py
will auto run __init__
8
150
50
我饿了，想喝粥
我想唱歌
"""
