#!/usr/local/bin/python3
#coding=utf-8



""" \d 匹配数字"""
""" \d 匹配数字 """

import re
str = "abc123456"
pattern = re.compile(r'\d')
print(pattern.findall(str))

""" 输出： ['1', '2', '3', '4', '5', '6'] """


""" \w 匹配数字或者字母"""

import re
str = "abc,123456"
pattern = re.compile(r'\w')
print(pattern.findall(str))

""" 输出： ['a', 'b', 'c', '1', '2', '3', '4', '5', '6'] """



""" \W 匹配非数字或者字母"""

import re
str = "abc,123456……%"
pattern = re.compile(r'\W')
print(pattern.findall(str))

""" 输出： [',', '…', '…', '%'] """


""" \s 匹配空格、tab 等"""

import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\s')
print(pattern.findall(str))

""" 输出：['\n', ' ', ' ', '\t', '\r'] """


""" \S 匹配空格、tab 等"""

import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\S')
print(pattern.findall(str))
""" 输出：['a', 'b', 'c', ',', '1', '2', '3'] """




