#!/usr/bin/ptyhon
#coding=gbk

"""
 �� 1�ӵ�100���ڶ���
"""
ret = 0
for item in range(1, 101):
    ret += item  # ret = item + ret
print(ret)

print(sum(range(1, 101)))