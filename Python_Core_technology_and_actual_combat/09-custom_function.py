#!/usr/local/bin/python3
#coding=utf-8

#Python中自定义函数
"""
函数的作用:
    使代码更加模块化, 规范化
    函数就是为了实现某一功能的代码段, 只要写好以后, 就可以重复复用.
"""

#定义一个函数
def my_func(message):
    print('Got a message: {}'.format(message))
# 调用函数 my_func()
my_func('Hello World')

"""
 def 是函数的场景
 my_func 是函数的名称
 括号里面的 message是函数的参数
 函数里面的 print是函数的主体部分, 可以执行相应的语句
 在函数最后, 可以返回调用结果(return 或 yield), 也可以不返回.

"""

#函数的参数可以使用默认值
def func(param = 0):
    ...

"""
    在调用函数 func()时:
        如果参数 param没有传入, 则参数默认为0;
        如果传入了参数 param, 其就会覆盖默认值.
"""

#嵌套函数
"""
def connect_DB():
    def get_DB_configuration():
        ...
        return host, username, password
    conn = connector.connect(get_DB_configuration())
    return conn

"""
#内部函数只能被外部函数所调用和访问, 不会暴露在全局作用域.  比如数据库的用户和密码等

# Python是 dynamically typed
# 函数的多态:
    # 对于函数参数来说, 可以把列表, 字符串等作为参数来传递

def my_sum(a, b):
    return a+b

value = my_sum(1,3)
print(value)         # return 4

# 把列表作为参数来传递, 表示列表相连接
value_list = my_sum([1, 2], [3, 4])
print(value_list)   # return [1, 2, 3, 4]

# 把字符串作为参数传递, 表示字符串的合并连接:
str_list = my_sum('hello ', 'word')
print(str_list)     # return hello word


# 函数的嵌套的格式
def f1():
    print('hello')
    def f2():
        print('world')
    f2()

f1()



#函数变量作用域
    #局部变量
    #全局变量

"""
局部变量
    变量在函数内部定义, 只在函数内部有效
    一旦函数执行完毕, 局部变量就会被回收, 无法访问
"""

def read_text_from_file(file_path):
    with open(file_path) as file:
        ...
"""
    在函数内部定义了 file这个变量
    这个变量只在 read_text_from_file函数里有效
    在函数外部则无法访问
"""

"""
全局变量
   全局变量在函数外部定义,, 可以在当前文件内的任务地方访问, 包括函数内部
   不能在函数内部随意改变全局变量的值
   在函数内部改变全局变量的值, 必须加上 global 声明
   如果遇到函数内部局部变量和全局变量同名的情况，那么在函数内部，局部变量会覆盖全局变量
   对于嵌套函数来说，内部函数可以访问外部函数定义的变量，但是无法修改，若要修改，必须加上 nonlocal 这个关键字
   如果不加上 nonlocal 这个关键字，而内部函数的变量又和外部函数变量同名，那么同样的，内部函数变量会覆盖外部函数的变量。
"""

#不能在函数内部随意改变全局变量的值
"""
MIN_VALUE = 1
MAX_VALUE = 10
def validation_check(value):
    ...
    MIN_VALUE += 1
    ...
validation_check(5)
"""
#return UnboundLocalError: local variable 'MIN_VALUE' referenced before assignment



#在函数内部改变全局变量的值, 必须加上 global 声明
MIN_VALUE = 1
MAX_VALUE = 10
def validation_check(value):
    global MIN_VALUE
    ...
    MIN_VALUE += 1
    return MIN_VALUE
    ...
print(validation_check(5))  # return 2
print(MIN_VALUE)            # return 2

"""
这里的 global 关键字，并不表示重新创建了一个全局变量 MIN_VALUE，而是告诉 Python 解释器，
函数内部的变量 MIN_VALUE，就是之前定义的全局变量，并不是新的全局变量，也不是局部变量。
这样，程序就可以在函数内部访问全局变量，并修改它的值了。
"""

#  如果遇到函数内部局部变量和全局变量同名的情况，那么在函数内部，局部变量会覆盖全局变量
MIN_VALUE = 1
MAX_VALUE = 10
def validation_check():
    MIN_VALUE = 3
    return MIN_VALUE
    ...
print(MIN_VALUE)            # return 1
print(validation_check())   # return 3

#对于嵌套函数来说，内部函数可以访问外部函数定义的变量，但是无法修改，若要修改，必须加上 nonlocal 这个关键字
def outer():
    x = "local"
    def inner():
        nonlocal x              # nonlocal 关键字表示这里的 x 就是外部函数 outer 定义的变量 x
        x = 'nonlocal'
        print("inner:", x)
    inner()
    print("outer:", x)
outer()
"""
输出
inner: nonlocal
outer: nonlocal
"""

#如果不加上 nonlocal 这个关键字，而内部函数的变量又和外部函数变量同名，那么同样的，内部函数变量会覆盖外部函数的变量。
def outer():
    x = "local"
    def inner():
        x = 'nonlocal' # 这里的 x 是 inner 这个函数的局部变量
        print("inner:", x)
    inner()
    print("outer:", x)
outer()

"""
输出
inner: nonlocal
outer: local
"""


#闭包
"""
python 操作符** （两个乘号就是乘方）
一个乘号*，如果操作数是两个数字，就是这两个数字相乘，如2*4,结果为8
**两个乘号就是乘方。比如3**4,结果就是3的4次方，结果是81
"""

"""
 闭包和嵌套函数类似,
    不同的是, 外部函数返回的是一个函数, 而不是一个具体的值
    返回的函数通常赋于一个变量,这个变量可以在后面被继续执行调用
"""

#计算一个数的 n次幂, 使用闭包程序和不使用闭包程序的比较
#用闭包
def nth_power(exponent):
    def exponent_of(base):
        return base ** exponent
    return exponent_of # 返回值是 exponent_of 函数

square = nth_power(2) # 计算一个数的平方   #平方²
cube   = nth_power(3)   # 计算一个数的立方　＃立方³

"""
<function nth_power.<locals>.exponent_of at 0x0000000001E9BE18>
<function nth_power.<locals>.exponent_of at 0x0000000001E9BEA0>
"""
print(square(2))  # 计算 2 的平方
print(cube(2)) # 计算 2 的立方
print(cube(3)) # 计算3 的立方

#不用闭包:
def nth_power_rewrite(base, exponent):
    return base ** exponent

print(nth_power_rewrite(2,2))
print(nth_power_rewrite(2,3))
print(nth_power_rewrite(3,3))


#假设需要计算很多个数的平方
"""
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
"""

# 下面使用闭包的方式来做更合理, 每次调用函数都可以少输入一个参数,表达更为简洁.