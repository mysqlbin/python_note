#!/usr/local/bin/python3
#coding=utf-8

# len: 判断数据类型是否为空
a = -10
if a > -11:
    print(11)

lists = [1,2,3]
if isinstance(lists, list):
    print(3)



def my_func5(l2):
	l2 = l2 + [4]
	return l2

l1 = [1, 2, 3]
l1 = my_func5(l1)
print(l1)
### 输出 ###
[1, 2, 3, 4]


