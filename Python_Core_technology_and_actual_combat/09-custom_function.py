#!/usr/local/bin/python3
#coding=utf-8

#Python中自定义函数

def my_func(message):
    print('Got a message: {}'.format(message))

# 调用函数 my_func()
my_func('Hello World')
# 输出
#Got a message: Hello World



def my_sum(a, b):
    return a + b

result = my_sum(3, 5)
print(result)

# 输出
# 8



def find_largest_element(l):
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





