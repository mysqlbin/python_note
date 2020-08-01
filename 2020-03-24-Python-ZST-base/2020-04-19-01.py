#!/usr/bin/ptyhon
#coding=gbk

"""
 求 1加到100等于多少
"""
ret = 0
for var in range(1,101):
    # ret += var
    print(var)
    ret = var + ret
print(ret)

