#!/usr/local/bin/python3
#coding=utf-8

""" re.I 表示匹配的时候忽略大小写 """
import re
str = "abc, ABC, abd"
pattern = re.compile(r'abc', re.I)
print(pattern.findall(str))
""" 输出：['abc', 'ABC'] """

import re
str = "abc, ABC, abd"
pattern = re.compile(r'abc')
print(pattern.findall(str))
""" 输出：['abc'] """

----------------------------------------

""" re.M 表示匹配多行 """

import re
str = "abc\nABC, abd"
pattern = re.compile(r'^a')
print(pattern.findall(str))
['a']

import re
str = "abc\nABC, abd"
pattern = re.compile(r'^a', re.I)
print(pattern.findall(str))
['a']

import re
str = "abc\nABC, abd"
pattern = re.compile(r'^a', re.M)
print(pattern.findall(str))
['a']

""" re.I|re.M 表示不区分大小写和换行匹配要同时有效"""
import re
str = "abc\nABC, abd"
pattern = re.compile(r'^a', re.I|re.M)
print(pattern.findall(str))
['a', 'A']


----------------------------------------

""" 下面是 python2 的环境 """
import re
str = "abc，123我是中国人"
pattern = re.compile(r'\w')
print(pattern.findall(str))
['a', 'b', 'c', '1', '2', '3']

import re
str = "abc，123我是中国人"
pattern = re.compile(r'\w',)
print(pattern.findall(str))
['a', 'b', 'c', '1', '2', '3']

import re
str = "abc，123我是中国人"
pattern = re.compile(r'\w', re.A)
print(pattern.findall(str))


