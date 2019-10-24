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
# [1, 2, 3, 4]

#在字符串中，内嵌带引号的字符串：
str = "I'm mysqlbin"
print(str)
### 输出 ###
I'm mysqlbin

receiver = ['13202095158@163.com', '1224056230@qq.com']
str = ",".join(receiver)
print(str)
### 输出 ###
# '13202095158@163.com, 1224056230@qq.com'

def pt_cmd(condition):
    archiver_cmd = "pt-archiver --where '{}'".format(condition)
    return archiver_cmd
source_field = 'tEndtime'
before_datetime = '2019-09-12 12:00:00'
condition = '{}<"{}.000"'.format(source_field, before_datetime)
where = pt_cmd(condition)
print(where)
### 输出 ###
pt-archiver --where 'tEndtime<"2019-09-12 12:00:00.000"'



len(s)
5
