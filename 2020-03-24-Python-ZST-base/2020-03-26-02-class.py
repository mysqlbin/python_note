#!/usr/bin/ptyhon
#coding=gbk

"""
��ʵ�����Լ̳���Ҫ�� __init__(self) �м��� FasterCalss.__init__(self)
"""

class Faster:
    
    def __init__(self, age, height):
        print('will auto run __init__')
        self.age    = age
        self.height = height

    def eat(self):
        print('�Ҷ��ˣ���Է�')

class Son(Faster):

    def __init__(self, age, height):
        Faster.__init__(self, age, height)

    def sing(self):
        print('���볪��')

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
�Ҷ��ˣ���Է�
���볪��
"""
