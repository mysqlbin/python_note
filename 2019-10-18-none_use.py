#!/usr/local/bin/python3
#coding=utf-8

"""
# 1. None表示空(Null)，但它不等于空字符串、空列表，也不等同于False，通过下面的代码进行验证
# 2. if  not a和if a is None两者的区别
# 3. None和False
# 4. 判空操作的推荐方法
# 5. None和False
# 6. 相关参考
# 7. not
# 8. is or ==
"""

# 1.None表示空，但它不等于空字符串、空列表，也不等同于False，通过下面的代码进行验证
""""""
a = ''
b = False
c = []
d = None

print(a == None)   #比较值
print(b == None)
print(c == None)
print(d == None)
print(a is None)
print(b is None)
print(c is None)
print(d is None)

"""
输出
False
False
False
True
False
False
False
True
"""
#


# 2. if  not a和if a is None两者的区别
# 在写代码的过程中，会对某些代码进行判空操作。
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
# 返回：
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
    not a：它的意思相当于True， 所以会打印出S。初步明白了。
    a is None是比较运算
    它们不属于同一种类型，因此会出现不一样的打印值。

"""

end_pos = None
if end_pos:
    print(1)
else:
    print("start_pos = None is false")

end_pos = 0
if end_pos:
    print("end_pos = 0 is false")

end_pos_02 = False
if end_pos_02:
    print("end_pos_02 = 0 is false")

end_pos_03 = {}
if end_pos_03:
    print("end_pos_02 = {} is false")

end_pos_04 = ()
if end_pos_04:
    print("end_pos_04 = () is false")




"""
输出： 4
"""

# 4. 判空操作的推荐方法

"""
那么对于判空操作语法调用，我一般推荐这样操作  if not a：
通过这样一个判空操作，不管a是None还是空字符串、空列表或者布尔值，你都会得到想要的值， 如下所示
https://www.cnblogs.com/devops-qxw/p/9641316.html    python中的not具体表示是什么
"""
print(".......................")
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
print(".......................")

# 5. None和False
"""
很多时候，当我们运行if  None和if  False会得到相同的结果，但结果相同并不代表意义一样。

从类型层面上，False是布尔类型，而None是class 'NoneType'；
从意义层面上，None表示不存在，而False表示真假。

"""

# 6. 相关参考
# https://mp.weixin.qq.com/s/CRmatVXsRoOF5diHUojfZw   深入理解Python中的None



# 7. not
"""
https://www.cnblogs.com/devops-qxw/p/9641316.html    python中的not具体表示是什么
在python中not是逻辑判断词，用于布尔型True和False，not True为False，not False为True
"""

cc = 52
if not cc:
    print(5513)
else:
    print(111111111)

a_20220222 = True
if not a_20220222:
    print('not a_20220222: 01')
else:
    print('not a_20220222: 02')


# not True
if not True:
    print('false')
else:
    print('true')



# 8. is or ==
reaCode = None
if (reaCode == None):
    print("== None")
else:
    print("!= None!")

if (reaCode is None):
    print("is None")
else:
    print("not is None")

"""
SyntaxWarning: "is" with a literal. Did you mean "=="?

if (reaCode is ''):
    print("is 空 string")
else:
    print("not is 空 string!")
"""

reaCode = ''
if (reaCode == ''):
    print("= 空 string")
else:
    print("!= 空 string")


if (reaCode == None):
    print("空 string == None")
else:
    print("空 string != None!")

if (reaCode is None):
    print("空 string is None")
else:
    print("空 string not is None!")

a = ''
if a == '':
    print(2222)

"""
None是一个空的对象，代表什么都没有。
而''，是一个字符串对象，代表一个空的字符串。
is判断：
    值要相同，并且内存地址要相同才成立
==判断：
    值要相同就成立
    

"""

