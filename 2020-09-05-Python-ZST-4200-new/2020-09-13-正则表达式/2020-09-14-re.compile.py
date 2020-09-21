#!/usr/local/bin/python3
#coding=utf-8
import re

""" re.I 表示匹配的时候忽略大小写  """

# 大小写敏感，默认的模式 --findall
# str = "abc, ABC, abd"
# pattern = re.compile(r'abc', re.I)
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print('not find')
""" 输出：['abc', 'ABC'] """

# re.I 表示匹配的时候忽略大小写 --findall

# str = "abc, ABC, abd"
# pattern = re.compile(r'abc')
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not find")
""" 输出：['abc'] """


# 大小写敏感，默认的模式 --match
# pattern = re.compile(r"abc")
# m = pattern.match("ABC")
# if m:
#     print(m.group())
# else:
#     print("not match")

# 正则忽略大小写  --match
# pattern = re.compile(r"abc", re.I)
# m = pattern.match("ABC")
# if m:
#     print(m.group())
# else:
#     print("not match")


#---------------------------------------

""" re.M 表示匹配多行 """

# 默认是 非多行模式
# str = "abc\nBC\nabd"
# pattern = re.compile(r'^a')
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not find")

# re.M 表示可以匹配多行
# import re
# str = "abc\nBC\nabd"
# pattern = re.compile(r'^a', re.M)
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not find")

""" re.I|re.M 表示不区分大小写和换行匹配要同时有效"""
# str = "ABC\naBC"
# pattern = re.compile(r"^abc", re.I | re.M)
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not find")

""" re.I|re.M 表示不区分大小写和换行匹配要同时有效"""
# import re
# str = "abc\nABC, abd"
# pattern = re.compile(r'^a', re.I | re.M)
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not find")

#---------------------------------------

""" re.S 点任意匹配模式，改变'.'的行为 """

# . 的默认行为, 表示匹配除 "\n" 之外的任何单个字符。
# str = "ABC123,.\nABC"
# pattern = re.compile(r".", re.I | re.M)
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not match")
# ['A', 'B', 'C', '1', '2', '3', ',', '.', 'A', 'B', 'C']  字符串中的 \n 不会被匹配到

# re.S来改变'.'的行为
# str = "ABC123,.\nABC"
# pattern = re.compile(r".", re.I | re.M | re.S)
# m = pattern.findall(str)
# if m:
#     print(m)
# else:
#     print("not match")
# ['A', 'B', 'C', '1', '2', '3', ',', '.', '\n', 'A', 'B', 'C']


# . 的默认行为, 表示匹配除 "\n" 之外的任何单个字符。
str = "ABC123,.\nABC"
pattern = re.compile(r"ABC.*ABC", re.I | re.M)
m = pattern.findall(str)
if m:
    print(m)
else:
    print("not match")

# re.S来改变'.'的行为

str = "ABC123,.\nABC"
pattern = re.compile(r"ABC.*ABC", re.I | re.M | re.S)
m = pattern.findall(str)
if m:
    print(m)
else:
    print("not match")


#---------------------------------------

# \w 匹配包括下划线的任何单词字符。等价于"[A-Za-z-0-9_]"
# import re
# str = "abc，123我是中国人"
# pattern = re.compile(r'\w')
# print(pattern.findall(str))
# # ['a', 'b', 'c', '1', '2', '3', '我', '是', '中', '国', '人']
#
# import re
# str = "abc，123我是中国人"
# pattern = re.compile(r'\w', re.A)
# print(pattern.findall(str))
# # ['a', 'b', 'c', '1', '2', '3']

