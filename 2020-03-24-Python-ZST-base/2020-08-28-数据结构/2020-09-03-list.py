#!/usr/bin/ptyhon
#coding=gbk


# Python列表高级用法:  列表推导式
# 没有 else
# 题目1： 列出10以内的偶数
# s = [x for x in range(0, 10) if x % 2 == 0]
# print(s)

# 题目2：求1到100内能同时除尽2和3的数
# s = [x for x in range(1, 101) if x % 2 == 0 or x % 3 == 0]
# print(s)

# 有 else
# 题目3: 将10以内的奇数平方、偶数减半
# import math
# s = [math.pow(item, 2) if item % 2 == 1 else item / 2 for item in range(0, 10)]
# print(s)

# 题目4
"""
列表练习题：
a = [1, 3, 4, 5, 8, 'love']
1： 如果是整数、则加1并输出， 如果是字符串， 则直接输出
2： 如果是奇数位并且是整数，则输出加1，如果是字符串，则直接输出

"""
a = [1, 3, 4, 5, 8, 'love']
# s = [item + 1 if type(item) == int else item for item in a]
# print(s)

s = [item + 1 if type(item) == int and item % 2 == 1 else item for item in a]
print(s)


# for item in range(0, 3):
#     print(item)

# range(0, 10) 表示 0-9的数字

"""

条件和循环的进阶操作
    将条件与循环并做一行的操作：
      有 else语句
      expression1 if condition else expression2 for item in iterable
        等价于
        
        for item in iterable:
            if condition:
                expression1
            else:
                expression2
    
      没有else语句
       expression for item in iterable if condition
         等价于
        for item in iterable:
            if condition:
                expression

"""

