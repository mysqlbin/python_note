#!/usr/local/bin/python3
#coding=utf-8

# Python变量及其赋值

#不可变对象的赋值
a = 1
b = a
c = a
a = a + 1

print(a)
print(b)
print(c)

"""
return 2
return 1
"""

"""
 Python 的数据类型，例如整型（int）、字符串（string）等等，是不可变的；
 a = a + 1　并不是让　ａ的值增加１，而是表示重新创建了一个新的值为２的对象，并让ａ指向它；

 b仍然不变， 仍然指向 1 这个对象。

 简单的赋值 b = a，并不表示重新创建了新对象，只是让同一个对象被多个变量指向或引用。

"""

#可变对象的赋值
list_01 = [1,2,3]
list_02 = list_01

list_01.append(4)

print(list_01)
print(list_02)

"""
return [1,2,3,4]
return [1,2,3,4]
"""

"""
让列表 l1和l2 同时指向了 [1,2,3] 这个对象；
列表是可变的，list_01.append(4)不会创建新的列表，会在原列表的末尾插入了元素4，变成 [1,2,3,4]；
l1和l2 同时指向这个列表， l1和l2 的值就都变为了 [1,2,3,4]

"""

"""
小结：
可变的数据类型，原变量在赋值给新变量之后，对原变量的对象做修改，新变量对应的对象会改变
不可变的数据类型，原变量在赋值给新变量之后，对原变量的对象做修改，新变量对应的对象不会改变
"""



def my_func1(b):
    b = 2

a = 1
my_func1(a)
print(a)
#return 1


def my_func2(b):
    b = 2
    return b

a = 1
a = my_func2(a)
print(a)
# return 2


def my_func3(l2):
    l2.append(4)

l1 = [1, 2, 3]
my_func3(l1)
print(l1)
#return [1, 2, 3, 4]

def my_func4(l2):
    l2 = l2 + [4]

l1 = [1, 2, 3]
my_func4(l1)
print(l1)
# return [1, 2, 3]



def my_func5(l2):
	l2 = l2 + [4]
	return l2

l1 = [1, 2, 3]
l1 = my_func5(l1)
print(l1)
# return [1, 2, 3, 4]


"""
要改变 l1的值， 需要让函数返回一个新列表，再赋予 l1
"""


"""
因此，通过一个函数来改变某个变量的值，通常有两种方法。
    一种是直接将可变数据类型（比如列表，字典，集合）当作参数传入，直接在其上修改；
    第二种则是创建一个新变量，来保存修改后的值，然后将其返回给原变量。
在实际工作中，我们更倾向于使用后者，因为其表达清晰明了，不易出错。
"""