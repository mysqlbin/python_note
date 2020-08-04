#!/usr/local/bin/python3
#coding=utf-8

""" match """
line = 'Cats are smarter than dogs'
matchOjb = re.match(r'dogs', line, re.M|re.I)
print(matchOjb)
""" 输出: None """

line = 'Cats are smarter than dogs'
matchOjb = re.match(r'Cats are', line, re.M|re.I)
print(matchOjb.group())
""" 输出: Cats are """

""" match """
line = 'Cats are smarter than dogs'
matchOjb = re.search(r'smarter', line, re.M|re.I)
print(matchOjb.group())
""" 输出: smarter """
"""
小结：
    match：匹配以什么开头的，相当于MySQL的 like 'dogs%';
    search：匹配包含‘search’的，相当于MySQL的 like '%dogs%';
    
"""

"""
CREATE TABLE `regulars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `regulars` (`id`, `name`) VALUES ('1', 'Cats are smarter than dogs');


root@mysqldb 17:40:  [audit_db]> select * from regulars;
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


