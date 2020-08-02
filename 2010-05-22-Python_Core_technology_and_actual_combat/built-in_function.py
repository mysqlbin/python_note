#!/usr/local/bin/python3
#coding=utf-8
a = 1
def funs():
    global a
    a = 2

print(a)

#Python中常用的内置函数

# range()函数
"""
rang() 函数可创建一个整数列表， 一般用在 for 循环中。
range(start, stop[, step])
参数说明：
    start: 计数从 start开始。默认是从0开始。 例如 range(5) 等于 range(0, 5);
    stop:  计数到 stop结束， 但不包括 stop。 例如 range(0, 5) 是 [0, 1, 2, 3, 4]，不包括5。
    step： 步长， 默认为1。                  例如 range(0, 5) 造价于 range(0, 5, 1)
#参考： https://www.runoob.com/python/python-func-range.html
"""

print(range(10))        # range(0, 10)
print(range(1, 11))     # range(1, 11)
lists= []
print(range(0, 10, 3))  #步长为 3
for index in range(0, 10, 3):
    lists.append(index)
print(lists)


# List len()方法
"""
 len() 方法用于返回列表元素个数
"""


str = input("请输入：")
print(str)
print ("你输入的内容是: ", str)


text = input('Please enter your questions, enter "q" to exit: ')
if text == 'q':
    print('Exit system')
else:
    print('continue')


"""
python 操作符** （两个乘号就是乘方）
一个乘号*，如果操作数是两个数字，就是这两个数字相乘，如2*4,结果为8
**两个乘号就是乘方。比如3**4,结果就是3的4次方，结果是81
"""
print(2**3)