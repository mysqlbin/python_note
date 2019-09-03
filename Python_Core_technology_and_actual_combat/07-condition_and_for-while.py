#!/usr/local/bin/python3
#coding=utf-8





#条件语句的格式
"""
if condition_1:
    statement_1
elif condition_2:
    statement_2
...
elif condition_i:
    statement_i
else:
    statement_n
"""

# id = 3
# if id == 0:
#     print('red')
# elif id == 1:
#     print('yellow')
# else:
#     print('green')


"""
除了 boolean类型的数据, 条件判断最好是显性的;
判断一个整型是否为0时, 要写出以下判断条件:
"""
#判断一个整型是否为0时, 一般有以下两种方法：

# 1. 只写出变量名
# if i:
#     ...

# 2. 显性的判断：
# if i != 0:
#     ...


#循环语句  for or while

# for item in <iterable>:
#     ...


#for循环
#遍历一个列表的所有元素
# list = [1, 2, 3, 4]
# for item in list:
#     print(item)

#字典本身只有键是可以迭代的，如果我们要遍历它的值或者键值对，需要通过内置的函数 values() 或者 items()实现。
#其中， values() 返回字典的值的集合
#       items()  返回键值对的集合

dict = {'name': 'bin', 'age': 0, 'gender': 'male'}
#返回键
#方式一
for k in dict:
    print(k)
"""
name
age
gender
"""
#方式二:

for k in dict.keys():
    print(k)


#返回值
for v in dict.values():
    print(v)
"""
bin
0
male
"""
#返回键值对
for k,v in dict.items():
   print('key: {}, value: {}'.format(k, v))
"""
key: name, value: bin
key: age, value: 0
key: gender, value: male
"""

#遍历一个列表中的元素，当索引小于5时，打印输出：
list_s = [1, 2, 3, 4, 5, 6, 7]
# len() 方法返回列表中元素的个数。
print(len(list_s))
"""
7
"""
for index in range(0, len(list_s)):
    # print(index)
    if index < 5:
        print(list_s[index])
"""
1
2
3
4
5
"""

#优化方法：
#当同时需要索引和元素时，通过Python内置的函数 enumerate().
#用它遍历集合， 同时返回每个元素和元素对应的索引
list_s = [1, 2, 3, 4, 5, 6, 7]
for index, item in enumerate(list_s):
    if index < 5:
        print(item)

"""
1
2
3
4
5
"""

#while循环：

# while condition:
#     ....

l = [1, 2, 3, 4]
index = 0
while index < len(l):
    print(l[index])
    index += 1

"""
1
2
3
4
"""

"""
用 for循环的场景：
    遍历已知的集合，找出满足条件的元素，并进行相应的操作
用 while循环的场景：
    需要在满足某个条件前，不停地重复某些操作，并且没有特定的集合需要去遍历
举例说明

"""
#比如，某个交互式问答系统，用户输入文字，系统会根据内容做出相应的回答。为了实现这个功能，我们一般会使用 while 循环，大致代码如下：
"""
while True:
    try:
        text = input('Please enter your questions, enter "q" to exit')
        if text == 'q':
            print('Exit system')
            break
        ...
        ...
        print(response)
    except as err:
        print('Encountered error: {}'.format(err))
        break
"""


"""
for 循环和while循环的效率问题
i = 0
while i < 1000000:
    i += 1
print(i)
等值于 for 循环：
for i in range(0, 1000000):
    print(i)
"""

"""
for 循环的效率更胜一筹:
要知道，range() 函数是直接由 C 语言写的，调用它速度非常快。
而 while 循环中的“i += 1”这个操作，得通过 Python 的解释器间接调用底层的 C 语言；
并且这个简单的操作，又涉及到了对象的创建和删除（因为 i 是整型，是 immutable，i += 1 相当于 i = new int(i + 1)）。
"""

# 条件和循环的复用

# 有 else语句
#expression1 if condition else expression2 for item in iterable
#造价于
"""
for item in iterable:
    if condition:
        expression1
    else:
        expression2
"""

# 没有 else语句
#expression for item in iterable if condition
#造价于
"""
for item in iterable:
    if condition:
        expression
"""

#处理文件中的字符串时，常常遇到的一个场景：
#将文件中逐行读取的一个完整语句，按逗号分割单词，去掉首位的空字符，并过滤掉长度小于等于 3 的单词，最后返回由单词组成的列表。

text = ' Today,  is, Sunday'
text_list = [s.strip() for s in text.split(',') if len(s.strip()) > 3]
print(text_list)
#['Today', 'Sunday']



#熟练之后，你会发现这种写法非常方便。当然，如果遇到逻辑很复杂的复用，你可能会觉得写成一行难以理解、容易出错。
#那种情况下，用正常的形式表达，也不失为一种好的规范和选择。


