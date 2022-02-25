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






# new_lists中的元素 包含 ; 符号

new_lists = ['1', '2;', '3']

data = ""
if new_lists[-1].find(';') == -1:

    print("new_lists[-1]: {}".format(new_lists[-1]))

    data += ''.join(new_lists[0:-1])

print("data: {}".format(data))

print(".....................")

# new_lists中的元素 不包含 ; 符号


new_lists = ['1', '2', '3']

data = ""
if new_lists[-1].find(';') == -1:

    print("new_lists[-1]: {}".format(new_lists[-1]))

    data += ''.join(new_lists[0:-1])

print("data: {}".format(data))

print(".....................")


# new_lists中的最后1个元素 包含 ; 符号

new_lists = ['1', '2;', '3;']

data = ""
data2 = ""
if new_lists[-1].find(';') == -1:

    print("new_lists[-1]: {}".format(new_lists[-1]))

    data += ''.join(new_lists[0:-1])

else:
    data2 += ''.join(new_lists)

print("data: {}".format(data))
print("data2: {}".format(data2))

print(".....................")

info = 'ab;ca'

print("info.find ; _ {}".format(info.find(';')))
# 字典遍历

import re
sql = "use `sbtest`"
if not re.findall(r'^use ', sql):
    print(1)
else:
    print(2)