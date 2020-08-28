#!/usr/bin/ptyhon
#coding=gbk

"""
"""

count = 5
while count > 0:
    count = count - 1
    if count == 3:
        continue
    print('数据库和编程每天进步一点点,count: {}'.format(count))

"""
count = 5 大于0，count减1后等于4，不等于3， 输出 数据库和编程每天进步一点点,count: 4
count = 4 大于0，count减1后等于3， 跳过这层循环
count = 3 大于0，count减1后等于2，不等于3， 数据库和编程每天进步一点点,count: 2
count = 2 大于0，count减1后等于1，不等于3， 数据库和编程每天进步一点点,count: 1
count = 1 大于0，count减1后等于0，不等于3， 数据库和编程每天进步一点点,count: 0
0 不大于 0，整个循环结束
"""

