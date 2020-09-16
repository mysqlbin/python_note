#!/usr/local/bin/python3
#coding=utf-8
import re

""" . 匹配除 \n 之外的 """
import re
str = "13202095158\n0775-2929123-abc"
pattern = re.compile(r'.')
print(pattern.findall(str))
# ['1', '3', '2', '0', '2', '0', '9', '5', '1', '5', '8', '0', '7', '7', '5', '-', '2', '9', '2', '9', '1', '2', '3', '-', 'a', 'b', 'c']


""" \d 匹配数字"""
import re
str = "abc123456_"
pattern = re.compile(r'\d')  # 正则表达式的匹配模式/规则 匹配的正则表达式
print(pattern.findall(str))  # 把所有的字符串都找出来
""" 输出： ['1', '2', '3', '4', '5', '6'] """


""" \w 匹配包括下划线的任何单词字符"""
import re
str = "abc,123456_"
pattern = re.compile(r'\w')
print(pattern.findall(str))
# ['a', 'b', 'c', '1', '2', '3', '4', '5', '6', '_']


""" \W 匹配任何非单词字符"""
import re
str = "abc,123456……%"
pattern = re.compile(r'\W')
print(pattern.findall(str))
# [',', '…', '…', '%']



""" \s 匹配任何空白符，包括空格、制表符、换页符等等"""
import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\s')
print(pattern.findall(str))
# '\n', ' ', ' ', '\t', '\r']


""" \S 匹配任何非空白字符 """
import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\S')
print(pattern.findall(str))
# ['a', 'b', 'c', ',', '1', '2', '3']



"""[158] 匹配1或者5或者8"""
import re
str = "13202095158,133020988"
pattern = re.compile(r'[158]')
print(pattern.findall(str))
# ['1', '5', '1', '5', '8', '1', '8', '8']


""" [^0-8] 匹配非1到8 """
import re
str = "13202095158,133020988"
pattern = re.compile(r'[^0-8]')
print(pattern.findall(str))
""" 输出：['9', ',', '9'] """


""" a|b """
import re
str = "13202095158,13302095158,13402095158"
pattern = re.compile(r'1(32|33)\d')
print(pattern.findall(str))
""" 输出：['32','33'] """

import re
str = "13202095158,13302095158,13402095158"
pattern = re.compile(r'(1(32|33)\d{8})')
print(pattern.findall(str))
""" 输出：[('13202095158', '32'), ('13302095158', '33')] """

import re
str = "13202095158,13302095158,13402095158"
pattern = re.compile(r'((32|33)\d{8})')
print(pattern.findall(str))
""" 输出：[('3202095158', '32'), ('3302095158', '33')] """
