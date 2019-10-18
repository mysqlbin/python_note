#!/usr/local/bin/python3
#coding=utf-8

# len: 判断数据类型是否为空
lists = []
if lists.__len__() == 0:
    print('empty list1')

if len(lists) == 0:
    print('empty list2')

tuples = (1, None)

if len(tuples) == 0:
    print('empty tuples')


a = 1
b = a
a = a + 1
