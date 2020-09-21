#!/usr/local/bin/python3
#coding=utf-8
import re


""" match """

# line = 'Cats are smarter than dogs'
# matchOjb = re.match(r'dogs', line, re.M|re.I)
# print(matchOjb)
# 输出: None

# line = 'Cats are smarter than dogs'
# matchOjb = re.match(r'Cats are', line, re.M|re.I)
# print(matchOjb.group())
# 输出: Cats are


""" search """
# line = 'Cats are smarter than dogs'
# matchOjb = re.search(r'smarter', line, re.M|re.I)
# print(matchOjb.group())
""" 输出: smarter """

"""
小结：
    match：匹配以什么开头的，相当于MySQL的 like 'xxx%';
    search：匹配包含‘search’的，相当于MySQL的 like '%xxx%'; 
"""

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


CREATE TABLE `regulars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `regulars` (`id`, `name`) VALUES ('1', 'smarter abc');
select * from regulars where `name` like 'sma%';

-- 以 sma 开头的。
mysql> select * from regulars where `name` like 'sma%';
+----+-------------+
| id | name        |
+----+-------------+
|  1 | smarter abc |
+----+-------------+
1 row in set (0.00 sec)


"""

""" match 对象, match 方法 """


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



