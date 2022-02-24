#!/usr/local/bin/python3
#coding=utf-8
import re

# 1. match
# 2. search
# 3. 小结
# 4. MySQL 中的模糊匹配/查找


# 1. match

line = 'Cats are smarter than dogs'
matchOjb = re.match(r'dogs', line, re.M|re.I)
print(matchOjb)
if matchOjb is not None:
    print("matchOjb: {}".format(matchOjb))
    print("matchOjb.group(): {}".format(matchOjb.group()))
else:
    print('None')
"""
    None
"""
print("..................................................")

line = 'Cats are smarter than dogs'
matchOjb = re.match(r'Cats are', line, re.M|re.I)
if matchOjb is not None:
    print("matchOjb: {}".format(matchOjb))
    print("matchOjb.group(): {}".format(matchOjb.group()))
else:
    print('None')
"""
    matchOjb: <re.Match object; span=(0, 8), match='Cats are'>
    matchOjb.group(): Cats are
"""

print("..................................................")


# 2. search
line = 'Cats are smarter than dogs'
searchOjb = re.search(r'smarter', line, re.M|re.I)
if searchOjb is not None:
    print("searchOjb: {}".format(searchOjb))
    print("searchOjb.group(): {}".format(searchOjb.group()))
else:
    print('None')

""" 
searchOjb: <re.Match object; span=(9, 16), match='smarter'>
searchOjb.group(): smarter
"""

print("..................................................")

line = 'Cats are smarter than dogs'
searchOjb = re.search(r'dog', line, re.M|re.I)
if searchOjb is not None:
    print("searchOjb: {}".format(searchOjb))
    print("searchOjb.group(): {}".format(searchOjb.group()))
else:
    print('None')
"""
searchOjb: <re.Match object; span=(22, 25), match='dog'>
searchOjb.group(): dog
"""


print("..................................................")

line = 'Cats are dogs smarter than dogs'
searchOjb = re.search(r'dog', line, re.M|re.I)
if searchOjb is not None:
    print("searchOjb: {}".format(searchOjb))
    print("searchOjb.group(): {}".format(searchOjb.group()))
else:
    print('None')
"""
searchOjb: <re.Match object; span=(9, 12), match='dog'>
searchOjb.group(): dog
"""

# 3. 小结
"""
    match：匹配以什么开头的，相当于MySQL的 like 'xxx%';
    search：匹配包含'xxx'的，相当于MySQL的 like '%xxx%'; 
"""

# 4. MySQL 中的模糊匹配/查找

"""
CREATE TABLE `regulars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `regulars` (`id`, `name`) VALUES ('1', 'Cats are smarter than dogs');


mysql> select * from regulars;
+----+----------------------------+
| id | name                       |
+----+----------------------------+
|  1 | Cats are smarter than dogs |
+----+----------------------------+
1 row in set (0.00 sec)

-- 包含 smarter 的
mysql> select * from regulars where name like '%smarter%';
+----+----------------------------+
| id | name                       |
+----+----------------------------+
|  1 | Cats are smarter than dogs |
+----+----------------------------+
1 row in set (0.00 sec)

-- 以 Cats 开头的
mysql> select * from regulars where name like 'Cats%';
+----+----------------------------+
| id | name                       |
+----+----------------------------+
|  1 | Cats are smarter than dogs |
+----+----------------------------+
1 row in set (0.00 sec)

-- 以 dogs 结尾的
mysql> select * from regulars where name like '%dogs';
+----+----------------------------+
| id | name                       |
+----+----------------------------+
|  1 | Cats are smarter than dogs |
+----+----------------------------+
1 row in set (0.00 sec)
"""




# Match 属性
pattern = re.compile(r"abc", re.I)
m = pattern.match("ABCDEF")
if m:
    # 匹配时使用的文本
    # print(m.string)

    # 匹配时使用的正则表达式
    # print(m.re)

    # 文本中正则表达式开始搜索的索引。
    print(m.pos)

    # 文本中正则表达式结束搜索的索引。
    print(m.endpos)

    print(m.lastindex)

    print(m.lastgroup)

else:
    print("not match")


import re
line = '13202095158'
matchOjb = re.match(r'(\d{3})(\d{4})(\d{4})', line)

"""
print(matchOjb)
# 获得一个或多个分组截获的字符串；
print(matchOjb.group())
print(matchOjb.group(0))
print(matchOjb.group(1))
print(matchOjb.group(2))
print(matchOjb.group(3))
print(matchOjb.group(4))
# 以元组形式返回全部分组截获的字符串。
print(matchOjb.groups())

>>> print(matchOjb)
<_sre.SRE_Match object; span=(0, 11), match='13202095158'>

>>> print(matchOjb.group())
13202095158

>>> print(matchOjb.group(0))
13202095158

>>> print(matchOjb.group(1))
132

>>> print(matchOjb.group(2))
0209

>>> print(matchOjb.group(3))
5158

>>> print(matchOjb.group(4))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: no such group

>>> print(matchOjb.groups())
('132', '0209', '5158')

"""



# 匹配手机号码
line = "13202095158555"
matchOjb = re.match(r'\d{11}', line)
# print(matchOjb)
# <_sre.SRE_Match object; span=(0, 11), match='13202095158'>
# print(type(matchOjb))
# <class '_sre.SRE_Match'>
# print(matchOjb.group())
# 13202095158

# line = "13202095158555"
# matchOjb = re.match(r'\d{11}$', line)
# print(matchOjb)
# None


# line = "13202095158"
#
# pattern = re.compile(r'\d{11}$')
# matchOjb = pattern.match(line)
# print(matchOjb.group())
#
# # 等价于
#
# matchOjb = re.match(r'\d{11}$', line)
# print(matchOjb.group())

# -------------------------------------------------------------------------

# username = "123456A33bc"
# matchOjb = re.match(r'^[a-z0-9_-]{3,15}', username)
# if matchOjb:
#     print(matchOjb.group())



