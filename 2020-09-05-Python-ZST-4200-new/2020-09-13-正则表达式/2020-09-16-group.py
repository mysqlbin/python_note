#!/usr/local/bin/python3
#coding=utf-8

""" () 正则分组：匹配规则有里几个()号，就有几组 """
import re
str = "13202095158,13302095158，13402095158"
pattern = re.compile(r'(32|33)\d')
print(pattern.findall(str))
""" 输出：['32','33'] """

import re
str = "13202095158,13302095158，13402095158"
pattern = re.compile(r'(1(32|33)\d)')
print(pattern.findall(str))
""" 输出：[('1320', '32'), ('1330', '33')] """

import re
str = "13202095158,13302095158，13402095158"
pattern = re.compile(r'(1(32|33)\d+)')
print(pattern.findall(str))

""" 输出：[('13202095158', '32'), ('13302095158', '33')] """

import re
str = "13202095158,13302095158，13402095158"
pattern = re.compile(r'(1(32|33)(\d+))')
print(pattern.findall(str))

""" 输出：[('13202095158', '32', '02095158'), ('13302095158', '33', '02095158')] """
