#!/usr/bin/ptyhon
#coding=gbk

"""
类实例属性继承需要在 __init__(self) 中加上 FasterCalss.__init__(self)
可以创造自己的财产即能够创建自己的属性和方法

这里的子类创建了自己的 self.weight 属性
这里的子类创建了自己的 sing() 方法

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
我饿了，想吃饭
我想唱歌
"""
