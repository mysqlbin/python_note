#!/usr/local/bin/python3
#coding=utf-8


# 函数的几个核心概念

#1. 函数也是对象, 可以把函数变量赋予
def func(message):
    print('Got a message: {}'.format(message))

send_message = func
send_message('hello world 1')

"""
    把函数 func() 赋予了变量 send_message，这样之后你调用 send_message，就相当于是调用函数 func()。
"""


#2. 函数当作参数， 传入另一个函数中：
def get_message(message):
    return 'Got a message: ' + message

def root_call(func, message):
    print(func(message))

root_call(get_message, 'hello world 2')

# return  Got a message: hello world
"""
    把函数 get_message() 以参数的形式，传入了函数 root_call() 中然后调用它。
"""

#3. 函数的嵌套
def func(message):
    def get_message(message):
        print('Got a message: {}'.format(message))
    return get_message(message)

func('hello world 3')

# return  Got a message: hello world
"""
    在函数 func() 里又定义了新的函数 get_message()，调用后作为 func() 的返回值返回。
"""

#4. 函数的返回值可以是函数对象(闭包)
def func_closure():
    def get_message(message):
        print('Got a message: {}'.format(message))
    return get_message      #函数对象

send_message = func_closure()
send_message('hello world 4')

"""
    函数 func_closure() 的返回值是函数对象 get_message() 本身，之后，我们将其赋予变量 send_message，再调用 send_message(‘hello world’)，最后输出了 'Got a message: hello world'
"""


#  手写装饰器
def my_decorator(func):
    def wrapper():
        print('wrapper of decorator')
        func()
    return wrapper

def greet():
    print('hello world')

greet = my_decorator(greet)
greet()

"""
return
wrapper of decorator
hello world
"""

"""
分析:
    变量 greet 指向了内部函数 wrapper()，而内部函数 wrapper() 中又会调用原函数 greet()，因此，最后调用 greet() 时，就会先打印 'wrapper of decorator',
    然后 输出 'hello world';
    函数 my_decorator() 就是一个装饰器，它把真正需要执行的函数 greet() 包裹在其中，并且改变了它的行为，但是原函数 greet() 不变。
"""

# Python中的装饰器
def my_decorator(func):
    def wrapper():
        print('wrapper of decorator')
        func()
    return wrapper

@my_decorator
def greet():
    print('hello world')

greet()

"""
return
wrapper of decorator
hello world
"""

"""
分析:
    @ 称之为 语法糖, @my_decorator就相当于 手写装饰器里面的 greet = my_decorator(greet), 写法更加简洁;
    程序中 有其它函数需要做类似的装饰, 只需要在 它们的上方加上 @decorator就可以了;
    使用装饰器, 大大提高了函数的重复利用和程序的可读性.
"""

"""
手写装饰器 和 Python中装饰器 的对比:
手写装饰器:
def my_decorator(func):
    ........
def greet():
    print('hello world')
greet = my_decorator(greet)
greet()

Python中的装饰器:
def my_decorator(func):
    ........
@my_decorator
def greet():
    print('hello world')
greet()

 @my_decorator就相当于 手写装饰器里面的 greet = my_decorator(greet)
"""


#带有参数的装饰器:
print('''..................param.........................''')

def param_decorator(func):
    def wrapper(*args, **kwargs):
        print('wrapper of decorator')
        func(*args, **kwargs)
    return wrapper

@param_decorator
def celebrate(name, message, a=2):
    print(name, message, a=2)

celebrate('lujb', 'hello world')

"""
return
wrapper of decorator
('lujb', 'hello world')
"""

"""
分析:
把 *args 和 **kwargs 作为装饰器内部函数 wrapper的参数；
*args 和 **kwargs 表示接受任意数量和类型的参数
"""

print('''..................self.........................''')
# 带有自定义参数的装饰器
def repeat(num):
    def my_decorator(func):
        def wrapper(*args, **kwargs):
            for i in range(num):
                print('wrapper of decorator')
                func(*args, **kwargs)
        return wrapper
    return my_decorator


@repeat(4)
def greet(message):
    print(message)

greet('hello world')

"""
输出：
wrapper of decorator
hello world
wrapper of decorator
hello world
wrapper of decorator
hello world
wrapper of decorator
hello world
"""

"""
分析：
    定义一个参数， 用来表示装饰器内部函数被执行的次数
"""

print('''...........................................''')


# 原函数已经不是原函数
print(greet.__name__)

"""
输出： wrapper
"""
help(greet)

"""
输出：
   Help on function wrapper in module __main__:
   wrapper(*args, **kwargs)
"""
print('''...........................................''')


#使用内置的装饰器 @functools.wraps(func)，它会帮助保留原函数的元信息
import functools


def my_decorator(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        print('wrapper of decorator')
        func(*args, **kwargs)

    return wrapper


@my_decorator
def greet(message):
    print(message)

print(greet.__name__)

"""
输出：
    greet
"""

"""
分析：
    由于greet() 函数被装饰以后，它的元信息变了。元信息告诉我们“它不再是以前的那个 greet() 函数，而是被 wrapper() 函数取代了”；
    使用内置的装饰器 @functools.wraps(func)，它会帮助保留原函数的元信息（也就是将原函数的元信息，拷贝到对应的装饰器函数里）。
"""


print('''类装饰器''')
"""
类也可以作为装饰器;
类装饰器主要依赖于函数 __call_()，每当你调用一个类的示例时，函数__call__()就会被执行一次.
"""

class Count:
    def __init__(self, func):
        self.func = func
        self.num_calls = 0

    def __call__(self, *args, **kwargs):
        self.num_calls += 1
        print('num of calls is: {}'.format(self.num_calls))
        return self.func(*args, **kwargs)

@Count
def example():
    print("hello world")

example()

example()

"""
输出
num of calls is: 1
hello world
num of calls is: 2
hello world
"""


"""
分析
定义了类 Count，初始化时传入原函数 func()，而__call__()函数表示让变量 num_calls 自增 1，然后打印，并且调用原函数。
因此，在我们第一次调用函数 example() 时，num_calls 的值是 1，而在第二次调用时，它的值变成了 2。
"""





"""
    *args 和 **kwargs 表示接受任意数量和类型的参数
    *args: 返回元组格式的数据类型
    **kwargs: 返回字典格式的数据类型
"""