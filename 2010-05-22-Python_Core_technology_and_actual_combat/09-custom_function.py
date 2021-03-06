#!/usr/local/bin/python3
#coding=utf-8

#Python中自定义函数


def my_func(message):
    print('Got a message: {}'.format(message))

# 调用函数 my_func()
my_func('Hello World')
# 输出
# Got a message: Hello World

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
"""
    定义了函数 find_largest_element，作用是遍历输入的列表，找出最大的值并打印。
    当我们调用它，并传递列表  [8, 1, -3, 2, 0]  作为参数时，程序就会输出 largest element is: 8
"""
# 输出
"""
largest element is: 8
"""


#函数要在调用之前先声明好

my_func('hello world')
def my_func(message):
    print('Got a message: {}'.format(message))


# 输出
NameError: name 'my_func' is not defined


#　函数内部调用其它函数, 函数间哪个声明在前, 哪个在后就无所谓, 因为 def 是可执行语句, 函数在调用之前都不存在, 只需要保证调用时, 所需的函数都已经声明定义
def my_func(message):
    my_sub_func(message)  # 调用 my_sub_func() 在其声明之前不影响程序执行

def my_sub_func(message):
    print('Got a message: {}'.format(message))

my_func('hello world')

# 输出
Got a message: hello world


# 函数可以设定默认值，在调用函数 func() 时，如果参数 param 没有传入，则参数默认为 0；而如果传入了参数 param，其就会覆盖默认值。

def func(param = 0):
    ...


# Python 是 dynamically typed 的, 可以接受任何数据类型(整型, 浮点, 字符串, 列表等等)的参数

#　把列表作为参数传递，表示将两个列表相连接
print(my_sum([1, 2], [3, 4]))
# 输出
[1, 2, 3, 4]


# 字符串作为参数传递，表示让两个字符串相合并拼接
print(my_sum('hello ', 'world'))

# 输出
hello world


#函数支持嵌套：
# 函数嵌套: 表示函数里面又有函数

def f1():
    print('hello')
    def f2():
        print('world')
    f2()
f1()

# 输出
hello
world

# 函数 f1() 的内部，又定义了函数 f2()。在调用函数 f1() 时，会先打印字符串 ‘hello’, ，然后 f1() 内部再调用 f2()，打印字符串 'world'
# 函数嵌套的作用：

def connect_DB():
    def get_DB_configuration():
        ...
        return host, username, password
    conn = connector.connect(get_DB_configuration())
    return conn

get_DB_configuration()
# 输出
NameError: name 'get_DB_configuration' is not defined


def read_text_from_file(file_path):
    with open(file_path) as file:
        ...


<<<<<<< HEAD

MIN_VALUE = 1
MAX_VALUE = 10
def validation_check(value):
    global MIN_VALUE
    ...
    MIN_VALUE += 1
    ...
validation_check(5)
=======
MIN_VALUE = 1
MAX_VALUE = 10
def validation_check(value):
    if value < MIN_VALUE or value > MAX_VALUE:
        raise Exception('validation check fails')
>>>>>>> 00a8ce24b5e0de5806cc4fcda509b43c95029bdd


MIN_VALUE = 1
MAX_VALUE = 10
def validation_check(value):
<<<<<<< HEAD
    MIN_VALUE = 3
    ...



def outer():
    x = "local"
    def inner():
        x = 'nonlocal' # 这里的 x 是 inner 这个函数的局部变量
        print("inner:", x)
    inner()
    print("outer:", x)
outer()
# 输出
"""
inner: nonlocal
outer: local
"""

# 闭包
# 使用闭包计算一个数的 N次幂
def nth_power(exponent):
    def exponent_of(base):
        return base ** exponent
    return exponent_of # 返回值是 exponent_of 函数

square = nth_power(2) # 计算一个数的平方
cube = nth_power(3) # 计算一个数的立方
print(square)
print(cube)
"""
# 输出
<function __main__.nth_power.<locals>.exponent(base)>

# 输出
<function __main__.nth_power.<locals>.exponent(base)>
"""
print(square(2))  # 计算 2 的平方
print(cube(2)) # 计算 2 的立方
"""
# 输出
4 # 2^2
8 # 2^3
"""




# 不用毕包计算一个数的 N次幂
def nth_power_rewrite(base, exponent):
    return base ** exponent


# 不适用闭包
res1 = nth_power_rewrite(base1, 2)
res2 = nth_power_rewrite(base2, 2)
res3 = nth_power_rewrite(base3, 2)
...

# 使用闭包
square = nth_power(2)
res1 = square(base1)
res2 = square(base2)
res3 = square(base3)
...


=======
    ...
    MIN_VALUE += 1
    ...
validation_check(5)

# 输出报错信息
UnboundLocalError: local variable 'MIN_VALUE' referenced before assignment
>>>>>>> 00a8ce24b5e0de5806cc4fcda509b43c95029bdd
