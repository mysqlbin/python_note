#!/usr/bin/ptyhon
#coding=gbk

"""
����Ĭ�ϻ�̳и����Ĭ�Ϸ���
���������Ĭ�ϻ�̳и����  eat() ����
"""

class Faster:

    def __init__(self, age, height):
        self.age    = age
        self.height = height

    def eat(self):
        print('�Ҷ��ˣ���Է�')

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
�Ҷ��ˣ���Է�
"""
