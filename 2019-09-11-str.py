#!/usr/local/bin/python3
#coding=utf-8



# 切片：提取字符串
# str = 'spam eggs ham'
# print(str[5:10])
### 输出 ###
# eggs

#字符串拼接/连接
# str = 'spam ' + 'eggs ham'
# print(str)
### 输出 ###
#spam eggs ham'

#格式化表达式: 替换
# str = 'spam %s %s' % ('eggs', 'ham')
# print(str)
### 输出 ###
#spam eggs ham'

#格式化方法：%的替代方法
# str = 'spam {} {}'.format('eggs', 'ham')
# print(str)
### 输出 ###
#spam eggs ham'

# str = 'hello'
# print(str[1:])


str = ' my name is jason '
str.strip()
print(str)
### 输出 ###
'my name is jason'

id = 1
name = 'bin'
str = f'no data available for person with id: {id}, name: {name}'
print(str)
### 输出 ###
no data available for person with id: 1, name: bin

