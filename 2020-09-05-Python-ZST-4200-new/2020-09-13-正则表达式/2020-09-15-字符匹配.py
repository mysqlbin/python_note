#!/usr/local/bin/python3
#coding=utf-8
import re

""" . 匹配除 \n 之外的 """
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'.')
print(pattern.findall(str))
""" 输出：['3'] """


""" \d 匹配数字"""
import re
str = "abc123456"
pattern = re.compile(r'\d')  # 正则表达式的匹配模式/规则 匹配的正则表达式
print(pattern.findall(str))  # 把所有的字符串都找出来
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


""" \S 匹配非空格、tab 等"""
import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\S')
print(pattern.findall(str))
""" 输出：['a', 'b', 'c', ',', '1', '2', '3'] """

""" . 匹配任何，任何的字符"""
import re
str = "13202095158\n0775-2929123abc"
pattern = re.compile(r'.')
print(pattern.findall(str))

""" 输出： ['1', '3', '2', '0', '2', '0', '9', '5', '1', '5', '8', '0', '7', '7', '5', '-', '2', '9', '2', '9', '1', '2', '3', 'a', 'b', 'c'] """


