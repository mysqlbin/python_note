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
        print("释放第一技能 %s" % (self.output1))
        return self.output1

    def skill2(self):
        print("释放第二技能 %s" % (self.output2))
        return self.output2

class Liubang(Hero):

    def skill(self):
        print("%s 释放第一技能： %s" % ('liubang', self.output1))
        return self.output1

    def skill2(self):
        print("%s 释放第二技能： %s" % ('liubang', self.output2))
        return self.output2

class Xianghu(Hero):

    def skill(self):
        print("%s 释放第一技能： %s" % ('xianghu', self.output1))
        return self.output1

    def skill2(self):
        print("%s 释放第二技能： %s" % ('xianghu', self.output2))
        return self.output2

liubang = Liubang(5000, 1300, 5, 1700, 7)
xianghu = Xianghu(6000, 1300, 4, 1200, 6)

# 1. 记录开战的时间
begin_time = time.time()

#  2. 两人一开始就互相放一技能、二技能， 对应的就是生命值减少了（自己的生命值 - 对方放的一技能）
# 两个人见面的时候，各自甩了一技能和二技能，刘邦先开战

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

value1 = liubang.skill()
xianghu.health -= value1
value2 = liubang.skill2()
xianghu.health -= value2
print('xianghu health: %s' % (xianghu.health))

value1 = xianghu.skill()
liubang.health -= value1
value2 = xianghu.skill2()
liubang.health -= value2
print('liubang health: %s' % (liubang.health))

while True:

    now_time = time.time()

    if liubang.health <= 0:
        print(liubang.health)
        print('liubang 输了')
        break

    if xianghu.health <= 0:
        print(xianghu.health)
        print('xianghu 输了')
        break

    intveral_time = int(now_time - begin_time)

    if intveral_time % 4 == 0:
        liubang.health -= xianghu.skill()

    if intveral_time % 5 == 0:
        xianghu.health -= liubang.skill()

    if intveral_time % 6 == 0:
        liubang.health -= xianghu.skill2()

    if intveral_time % 7 == 0:
        xianghu.health -= liubang.skill2()


"""
E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-28-02-class.py
liubang 释放第一技能： 1300
liubang 释放第二技能： 1700
xianghu health: 3000
xianghu 释放第一技能： 1300
xianghu 释放第二技能： 1200
liubang health: 2500
xianghu 释放第一技能： 1300
liubang 释放第一技能： 1300
xianghu 释放第二技能： 1200
liubang 释放第二技能： 1700
0
liubang 输了

xianghu health = 3000 - 1300 - 1700 = 0
liubang health = 2500 - 1300 - 1200 = 0
也就是说其实他们是同时完蛋

"""



