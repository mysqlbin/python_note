#!/usr/local/bin/python3
#coding=utf-8


# 自定义构造函数、函数重写
class Persion:
    def __init__(self, name, age, pay=0, job=None):
        self.name = name
        self.age  = age
        self.pay  = pay
        self.job  = job

    def handle_name(self):
        name = self.name.split()[-1]
        return name

    def handle_pay(self, percent):
        self.pay *= (1.0 + percent)

class Manger(Persion):
    def __init__(self, name, age, pay):
        Persion.__init__(self, name, age, pay, 'manager')

    def giveraise(self, percent, bonus=0.1):
        self.pay *= ((1.0 + percent + bonus))

if __name__ == '__main__':

    tom = Manger(name='Tom Doe', age=50, pay=50000)
    print(tom.job)
    print(tom.handle_name())

    tom.handle_pay(0.2)
    print(tom.pay)

    # manager
    # sue.pay *= 1.10
    # print(sue.pay)

    