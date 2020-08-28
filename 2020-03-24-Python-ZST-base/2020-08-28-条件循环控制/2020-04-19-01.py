#!/usr/bin/ptyhon
#coding=gbk

"""
 求 1加到100等于多少
"""
ret = 0
for item in range(1, 101):
    ret += item  # ret = item + ret
print(ret)

print(sum(range(1, 101)))