#!/usr/bin/ptyhon
#coding=gbk

"""
 �� 1�ӵ�100���ڶ���
"""
ret = 0
for var in range(1,101):
    # ret += var
    print(var)
    ret = var + ret
print(ret)

