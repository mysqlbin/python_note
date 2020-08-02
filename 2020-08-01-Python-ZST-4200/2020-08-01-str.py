#!/usr/local/bin/python3
#coding=utf-8


"""在字符串，斜杠表示转义"""
s1 = 'I\'m a student.'
print(s1)


"""多行字符串，实际输出的时候还是显示一行"""
s1 = '人生苦短，\
我用Python'
print(s1)
"""
人生苦短，我用Python'
"""


"""多行文本，输出的时候显示多行"""

s1 = """
我
是
谁
"""
print(s1)


"""切片"""

name = 'jason'
name[:2]
"""输出 ja"""

name = 'jason'
name[2:]
"""输出 son"""


name = 'jason'
name[1:3]
"""输出 as"""



"""字符串常用函数"""

s1= "192.168.0.1:3306"
print(s1.split(":"))
print(type(s1.split(":")))
### 输出 ['192.168.0.1', '3306'] ###
### 输出 <class 'list'> ###

s1= "192.168.0.1:3306:3306"
print(s1.partition(":"))
print(type(s1.partition(":")))
""" 
输出 
('192.168.0.1', ':', '3306:3306')
<class 'tuple'>
"""

"""通过 join 方法把列表转换为以逗号分割的字符串"""
receiver = ['13202095158@163.com', '1224056230@qq.com']
str = ",".join(receiver)
print(str)
print(type(str))
### 输出 ###
""" 13202095158@163.com, 1224056230@qq.com """
""" <class 'str'> """



s = "我"
s1 = "我们"
print(s.center(50,'.'))
print(s1.center(50,'.'))
### 输出 ###
"""
........................我.........................
........................我们........................
"""

s = "我"
s1 = "我们"
print(s.center(4,'.'))
print(s1.center(4,'.'))

"""
.我..
.我们.
"""

"""小练习"""

s = "目录引言,天青色等烟雨,而我在等你。"
lists = s.rstrip('。').split(",")
for item in lists:
    print(item.ljust(8, '.'))

lists_new = [item.ljust(8,'.') for item in lists]
print(lists_new)
"""
['目录引言....', '天青色等烟雨..', '而我在等你...']
"""

strs = "\n".join(lists_new)
print(strs)

"""
目录引言....
天青色等烟雨..
而我在等你...
"""

"""小练习理解了。"""


