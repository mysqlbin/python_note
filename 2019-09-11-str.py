#!/usr/local/bin/python3
#coding=utf-8



# 切片：提取字符串
str = 'spam eggs ham'
print(str[5:10])
### 输出 ###
# eggs

#字符串拼接/连接
str = 'spam ' + 'eggs ham'
print(str)
### 输出 ###
#spam eggs ham'

#格式化表达式: 替换
str = 'spam %s %s' % ('eggs', 'ham')
print(str)
### 输出 ###
#spam eggs ham'

#格式化方法：%的替代方法
str = 'spam {} {}'.format('eggs', 'ham')
print(str)
### 输出 ###
#spam eggs ham'