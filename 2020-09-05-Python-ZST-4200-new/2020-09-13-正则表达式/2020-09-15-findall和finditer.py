#!/usr/local/bin/python3
#coding=utf-8
import re

""" findall """
import re
line = 'Cats are smarter than dogs'
matchOjb = re.findall(r'\w+', line, re.M | re.I)
print(matchOjb)
""" 输出： ['Cats', 'are', 'smarter', 'than', 'dogs'] """

# 等价于
import re
line = 'Cats are smarter than dogs'
pattern = re.compile(r'\w+', re.M | re.I)
print(pattern.findall(line))
""" 输出： ['Cats', 'are', 'smarter', 'than', 'dogs'] """


""" finditer """
import re
line = 'Cats are smarter than dogs'
matchOjb = re.finditer(r'\w+', line, re.M | re.I)
print(matchOjb)
""" 输出： <callable-iterator object at 0x7f49023a5dd0> """
for items in matchOjb:
    print (items.group())

"""
输出：
Cats
are
smarter
than
dogs
"""
