#!/usr/local/bin/python3
#coding=utf-8



import re
str = "abcedfg"
pattern  = re.compile(r'\w')
print(pattern.findall(str))

""" 输出：['a', 'b', 'c', 'e', 'd', 'f', 'g'] """



import re
str = "abcedfg"
pattern  = re.compile(r'\w+')
print(pattern.findall(str))

""" 输出：['abcedfg'] """


import re
str = "abcedfg"
pattern  = re.compile(r'\w?')
print(pattern.findall(str))

""" 输出：['a', 'b', 'c', 'e', 'd', 'f', 'g', ''] """



import re
str = "abcedfg"
pattern  = re.compile(r'\w*?')
print(pattern.findall(str))

""" ['', 'a', '', 'b', '', 'c', '', 'e', '', 'd', '', 'f', '', 'g', ''] """





