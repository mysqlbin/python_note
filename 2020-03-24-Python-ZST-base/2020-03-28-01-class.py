#!/usr/bin/ptyhon
#coding=gbk

"""

"""

import  time

class Hero:
    def __init__(self, health, output1, time1, output2, time2):
        self.health  = health
        self.output1 = output1
        self.time1   = time1
        self.output2 = output2
        self.time2   = time2

    def skill(self):
        print("�ͷŵ�һ���� %s" % (self.output1))
        return self.output1

    def skill2(self):
        print("�ͷŵڶ����� %s" % (self.output2))
        return self.output2


class Liubang(Hero):
    pass

class Xianghu(Hero):
    pass

liubang = Liubang(5000, 1300, 5, 1700, 7)
xianghu = Xianghu(6000, 1300, 4, 1200, 6)

# 1. ��¼��ս��ʱ��
begin_time = time.time()

#  2. ����һ��ʼ�ͻ����һ���ܡ������ܣ� ��Ӧ�ľ�������ֵ�����ˣ��Լ�������ֵ - �Է��ŵ�һ���ܣ�
# �����˼����ʱ�򣬸���˦��һ���ܺͶ����ܣ������ȿ�ս

"""
value1 = xianghu.health - liubang.skill()
value2 = value1 - liubang.skill2()

print(value1)
print(value2)

value1 = liubang.health - xianghu.skill()
value2 = value1 - xianghu.skill2()

print(value1)
print(value2)

"""

# �����˼����ʱ�򣬸���˦��һ���ܺͶ����ܣ������ȿ�ս

value1 = liubang.skill()
xianghu.health -= value1
value2 = liubang.skill2()
xianghu.health -= value2
print(xianghu.health)

value1 = xianghu.skill()
liubang.health -= value1
value2 = xianghu.skill2()
liubang.health -= value2
print(liubang.health)

# ���￪ʼ�Դ�
while True:

    now_time = time.time()

    if liubang.health <= 0:
        print('liubang ����')
        break

    if xianghu.health <= 0:
        print('xianghu ����')
        break

    intveral_time = int(now_time - begin_time)

    #  intveral_time % 4 == 0  ��ʾ4�ı����� ��ȴʱ�䵽�ˣ��Ϳ��Լ����ż����ˡ�
    if intveral_time % 4 == 0:
        liubang.health -= xianghu.skill()

    if intveral_time % 5 == 0:
        xianghu.health -= liubang.skill()

    if intveral_time % 6 == 0:
        liubang.health -= xianghu.skill2()

    if intveral_time % 7 == 0:
        xianghu.health -= liubang.skill2()

"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-28-01-class.py
�ͷŵ�һ���� 1300
�ͷŵڶ����� 1700
3000
�ͷŵ�һ���� 1300
�ͷŵڶ����� 1200
2500
�ͷŵ�һ���� 1300
�ͷŵ�һ���� 1300
�ͷŵڶ����� 1200
�ͷŵڶ����� 1700
liubang ����

"""






