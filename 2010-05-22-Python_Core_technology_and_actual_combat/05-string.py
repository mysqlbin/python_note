#!/usr/local/bin/python3
#coding=utf-8

name = 'jason'
city = 'beijing'
text = "welcome to jike shijian"



#字符串的格式
s1 = 'hello'
s2 = "hello"
s3 = """hello"""
s1 == s2 == s3
True


#在字符串中，内嵌带引号的字符串：
strs = "I'm mysqlbin"
print(strs)
### 输出 ###

# strs = 'I'm mysqlbin' 格式错误

#Python 的三引号字符串，则主要应用于多行字符串的情境，比如函数的注释等等。
def calculate_similarity(item1, item2):
    """
    Calculate similarity between two items
    Args:
        item1: 1st item
        item2: 2nd item
    Returns:
      similarity score between item1 and item2
    """

#python的转义字符

str = 'a\nb\t\c'
print(str)
### l输出 ###
# a
# b	\c


#虽然打印的输出横跨了两行，但是整个字符串 s 仍然只有5个元素：
# print(len(s))

name = 'json'
for char in name:
    print(char)
### 输出 ###
# j
# a
# s
# o
# n



#字符串的常用操作

#遍历字符串中的每个字符：
names = 'bin'
for char in names:
    print(char)
"""
b
i
n
"""


#在转义字符的应用中，最常见的就是换行符 '\n' 的使用。比如文件读取，如果我们一行行地读取，那么每一行字符串的末尾，都会包含换行符 '\n' 。而最后做数据处理时，我们往往会丢掉每一行的换行符。



#拼接字符串
#使用 '+=' 操作符拼接字符串：
s = ''
for n in range(0, 10):
    s += str(n)
print(s)


#使用字符串内置的 join函数拼接字符串：
# string.join(iterable)，表示把每个元素都按照指定的格式连接起来。
lists = []
for n in range(0, 10):
    lists.append(str(n))
lists = ' '.join(lists)
print(lists)



#字符串分割函数 sepəreɪtə
# split()， 表示把字符串按照 separator（分割符）  分割成子字符串，并返回一个分割后子字符串组合的列表。

path = 'hive://ads/training_table'
namespace = path.split('//')[1].split('/')[0]
table = path.split('//')[1].split('/')[1]
print(namespace)
### 输出 ###
'ads'
print(table)
### 输出 ###
'training_table'
#拆分
str_a = path.split("//")  #返回一个列表 ['hive:', 'ads/training_table']
str_b = str_a[1]           # ads/training_table
str_c = str_b.split('/')[0]
print(str_c)

"""
string.strip(str)，表示去掉首尾的 str 字符串；
string.lstrip(str)，表示只去掉开头的 str 字符串；
string.rstrip(str)，表示只去掉尾部的 str 字符串。
"""
"""
string.find(sub, start, end)
#表示从 start 到 end 查找字符串中子字符串 sub 的位置
"""

#字符串格式化
# Python2.6 开始，新增了一种格式化字符串的函数 str.format()，它增强了字符串格式化的功能。
#string.format()  是最新的字符串格式化函数与规范
# 基本语法是通过 {} 和 : 来代替以前的 % 。

id = 1
name = 'bin'
print('no data available for person with id: {}, name: {}'.format(id, name))
### 输出 ####no data available for person with id: 1, name: bin
#之前版本中，字符串格式化通常用 % 来表示， %s 表示字符串，%d表示整型
print('no data available for person with id: %s, name: %s' % (id, name))
#no data available for person with id: 1, name: bin




id = 1
name = bin
print('no data available for person with id: {bin}, name: {name}')


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


# str = ' my name is jason '
# str.strip()
# print(str)
### 输出 ###
'my name is jason'

# id = 1
# name = 'bin'
# str = f'no data available for person with id: {id}, name: {name}'
# print(str)
### 输出 ###
# no data available for person with id: 1, name: bin

dicts = {'name': 'bin', 'age': 0, 'gender': 'male'}

for k,v in dicts.items():
   print('key: {}, value: {}'.format(k, v))