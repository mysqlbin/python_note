#!/usr/local/bin/python3
#coding=utf-8

class Persion:
    def __init__(self, name, age, pay=0, job=None):
        self.name = name
        self.age  = age
        self.pay  = pay
        self.job  = job

if __name__ == '__main__':
    bob = Persion('Bob Smith', 42, 30000, 'software')
    sue = Persion('Sue Jones', 45, 40000, 'hardware')

    print('{} {}'.format(bob.name, sue.pay))

    print(bob.name.split()[-1])

    sue.pay *= 1.10
    print(sue.pay)

    