#!/usr/local/bin/python3
#coding=utf-8

lists = ['1', '2', '3']
# 不取列表的最后1个元素
print("lists[0:-1] : {}".format(lists[0:-1]))
"""
lists[0:-1] : ['1', '2']
"""


"""
data += ''.join(temp[0:-1])
"""
data = ""
data += ''.join(lists[0:-1])
print("data: {}".format(data))
""""
data: 12
"""


nex = lists[-1]
print("nex: {}".format(nex))
"""
nex: 3
"""

data = ""
data += ''.join(lists)
print("data: {}".format(data))
"""
data: 123
"""

listss = [1]
a = ""
a += ''.join(listss[0:-1])
print("a: ".format(a))
# 字典遍历

