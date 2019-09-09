#!/usr/local/bin/python3
#coding=utf-8

#Python中自定义函数


def my_func(message):
    print('Got a message: {}'.format(message))

# 调用函数 my_func()
# my_func('Hello World')
# 输出
#Got a message: Hello World

def name(param1, param2, ..., paramN):
    statements
    return/yield value # optional


def my_sum(a, b):
    return a + b

result = my_sum(3, 5)
print(result)

"""
定义了 my_sum() 这个函数，它有两个参数 a 和 b，作用是相加；
随后，调用 my_sum() 函数，分别把 3 和 5 赋于 a 和 b；
最后，返回其相加的值，赋于变量 result，并输出得到 8。
"""

# 输出
# 8



def find_largest_element(l):
    """
        这段代码做了很严谨的判断，学习了
    """
    if not isinstance(l, list):
        print('input is not type of list')
        return
    if len(l) == 0:
        print('empty input')
        return
    largest_element = l[0]
    for item in l:
        if item > largest_element:
            largest_element = item
    print('largest element is: {}'.format(largest_element))


find_largest_element([8, 1, -3, 2, 0])

# 输出
"""
largest element is: 8
"""

#函数要在调用之前先声明好
"""
my_func('hello world')
def my_func(message):
    print('Got a message: {}'.format(message))
"""

# # 输出
# NameError: name 'my_func' is not defined


#　函数内部调用其它函数, 函数间哪个声明在前, 哪个在后就无所谓, 因为 def 是可执行语句, 函数在调用之前都不存在, 只需要保证调用时, 所需的函数都已经声明定义
def my_func(message):
    my_sub_func(message)  # 调用 my_sub_func() 在其声明之前不影响程序执行

def my_sub_func(message):
    print('Got a message: {}'.format(message))

my_func('hello world')

# 输出
#Got a message: hello world


# 函数可以设定默认值，在调用函数 func() 时，如果参数 param 没有传入，则参数默认为 0；而如果传入了参数 param，其就会覆盖默认值。
"""
def func(param = 0):
    ...
"""

# Python 是 dynamically typed 的, 可以接受任何数据类型(整型, 浮点, 字符串, 列表等等)的参数

#　把列表作为参数传递，表示将两个列表相连接
print(my_sum([1, 2], [3, 4]))
# 输出
# [1, 2, 3, 4]


# 字符串作为参数传递，表示让两个字符串相合并拼接
print(my_sum('hello ', 'world'))

# 输出
#  hello world


#函数支持嵌套：
# 函数嵌套: 表示函数里面又有函数

def f1():
    print('hello')
    def f2():
        print('world')
    f2()
f1()

# 输出
"""
hello
world
"""
# 函数 f1() 的内部，又定义了函数 f2()。在调用函数 f1() 时，会先打印字符串 ‘hello’, ，然后 f1() 内部再调用 f2()，打印字符串 'world'
# 函数嵌套的作用：



