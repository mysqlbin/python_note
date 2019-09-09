#!/usr/local/bin/python3
#coding=utf-8


cc = 52

if not cc:
    print(5513)
else:
    print(111111111)

a = None
if not a:
    seconds_behind_master = None
    print(seconds_behind_master)
    if seconds_behind_master != 0:
        print(1111)



# 1.None表示空，但它不等于空字符串、空列表，也不等同于False，通过下面的代码进行验证:
"""
a = ''
b = False
c = []

print(a==None)   #比较值
print(b==None)
print(c==None)
print(a is None)
"""
"""
输出
False
False
False
False
"""
#



#在写代码的过程中，会对某些代码进行判空操作。
# 比如有一个变量a，那么 if  not a 和 if a is None 两者有区别吗？如果说没有区别，那么不管a为何值时，这两个判断语句会返回相同的结果，但事实是这样吗？一起看下面这段代码，体会一下对None的判空操作
"""
def fun():
    return None

a = fun()
if not a:   #逻辑运算
    print('S')
else:
    print('F')

if a is None:
    print('S')
else:
    print('F')
"""
"""
S
S
运行代码发现，结果是一样的，这是由于我们调用函数时，会返回None
"""

# 将a的值换成一个空列表
a = []
if not a:       # 逻辑运算
    print('S')
else:
    print('F')

if a is None:   # 比较运算
    print('S')
else:
    print('F')

"""
输出
S
F
运行结果，发现会打印不一样的值:
    not a它的意思相当于True， 所以会打印出S
    a is None是比较运算，
    它们不属于同一种类型，因此会出现不一样的打印值。

"""

start_pos = None

start_pos = start_pos if start_pos else 4

print(start_pos)

"""
输出： 4
"""



# 那么对于判空操作语法调用，我一般推荐这样操作  if not a：
# 通过这样一个判空操作，不管a是None还是空字符串、空列表或者布尔值，你都会得到想要的值， 如下所示

b = None
if not b:
    print(b)

"""
输出： None
"""

b = False
if not b:
    print(b)

"""
输出： False
"""

b = ''
if not b:
    print(b)

"""
输出：
"""

b = []
if not b:
    print(b)

"""
输出：[]
"""


print(None)