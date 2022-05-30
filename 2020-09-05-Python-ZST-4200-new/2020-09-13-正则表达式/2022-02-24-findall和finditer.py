#!/usr/local/bin/python3
#coding=utf-8
import re

# 1. findall


# 1. findall

import re
line = 'Cats are smarter than dogs'
res = re.findall(r'\w+', line, re.M | re.I)
if res:
    print("res: {}".format(res))
else:
    print("not find")
"""
res: ['Cats', 'are', 'smarter', 'than', 'dogs']
"""
print("..................................................")

# 等价于
import re
line = 'Cats are smarter than dogs'
pattern = re.compile(r'\w+', re.M | re.I)
res = pattern.findall(line)
if res:
    print("res: {}".format(res))
else:
    print("not find")
"""
res: ['Cats', 'are', 'smarter', 'than', 'dogs']
"""

print("..................................................")

line = 'carry the barcardi to the car'
res = re.findall('car', line)
if res:
    print("res: {}".format(res))
else:
    print("not find")
"""
res: ['car', 'car', 'car']
"""

print("..................................................")

line = 'carry the barcardi to the car'
res_03 = re.findall('car222', line)
print("res_03: {}".format(res_03))

print("..................................................")



# 2. finditer
""" finditer """
import re
line = 'Cats are smarter than dogs'
res = re.finditer(r'\w+', line, re.M | re.I)
print("type: {}".format(type(res)))
if res:
    for items in res:
        print(items.group())
else:
    print("not find")
"""
type: <class 'callable_iterator'>
Cats
are
smarter
than
dogs
"""

print("..................................................")

line = 'carry the barcardi to the car'
res = re.finditer('car', line)
print("type: {}".format(type(res)))
if res:
    for items in res:
        print(items.group())
else:
    print("not find")

"""
type: <class 'callable_iterator'>
car
car
car
"""


print("..................................................")

