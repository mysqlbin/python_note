#!/usr/local/bin/python3
#coding=utf-8

import pymysql

"""
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `t` VALUES ('1', '1', '1');
INSERT INTO `t` VALUES ('2', '2', '2');
INSERT INTO `t` VALUES ('3', '3', '3');

"""
# sql = 'select * from zst.t;'
# host = '192.168.1.27'
# user = 'root'
# passwd = '123456abc'
# port = 3306
#
# connojb = pymysql.connect(host=host,user=user,passwd=passwd,port=int(port),charset='utf8mb4')
# cursor = connojb.cursor()
# cursor.execute(sql)

# 获取查询结果的第一行数据
# tuple_format = cursor.fetchone()
# print(tuple_format)
"""
(1,1,1)
"""

# 获取查询结果的前n行数据
# listoftuple_format = cursor.fetchmany(2)
# print(listoftuple_format)
"""
((1,1,1), (2,2,2))
"""

# 取查询结果的所有行记录
# listoftuple = cursor.fetchall()
# print(listoftuple)
"""
((1,1,1), (2,2,2), (3,3,3))
"""

#循环遍历结果
# for row in listoftuple:
#     print(row)
"""
(1,1,1)
(2,2,2)
(3,3,3)
"""

#元组拆包，用来挑选指定的列值
# for (a,b) in listoftuple:
#     print(a, ':', b)

#只提取所需的列
# a_filed = [res[0] for res in listoftuple]
# print(a_filed)
"""
[1,2,3]
"""

#构建记录字典
# connojb = pymysql.connect(host=host,user=user,passwd=passwd,port=int(port),charset='utf8mb4')
# cursor = connojb.cursor()
# cursor.execute(sql)
# index  = cursor.description
# listof_tuple = cursor.fetchall()
# rowdicts = []
# colnames = [i[0] for i in index]

# print(index)
"""
(('id', 3, None, 11, 11, 0, False), ('a', 3, None, 11, 11, 0, True), ('b', 3, None, 11, 11, 0, True))
"""

# print(listof_tuple)
"""
((1,1,1), (2,2,2), (3,3,3))
"""

# print(colnames)
"""
['id', 'a', 'b']
"""
#记录的字典结构的方式1
# for row in listof_tuple:
#     newdict = {}
#     for col, val in zip(colnames, row):
#         newdict[col] = val
#     rowdicts.append(newdict)
#
# print(rowdicts)
"""
[{'id': 1, 'a': 1, 'b': 1},{'id': 2, 'a': 2, 'b': 2},{'id': 3, 'a': 3, 'b': 3}]
"""
# for row in rowdicts:
#     print(row)
"""
{'id': 1, 'a': 1, 'b': 1}
{'id': 2, 'a': 2, 'b': 2}
{'id': 3, 'a': 3, 'b': 3}
"""



def mysql_query(sql,user,passwd,host,port,dbname):
    try:
        conn   = pymysql.connect(host=host,user=user,passwd=passwd,port=int(port),connect_timeout=5,charset='utf8mb4')
        conn.select_db(dbname)
        cursor = conn.cursor()
        count  = cursor.execute(sql)
        index  = cursor.description
        col=[]
        #获取列名
        try:
            for i in index:
                col.append(i[0])
        except Exception as e:
            cursor.close()
            conn.close()
            return (['ok'], ''), ['set']

        result=cursor.fetchall()
        cursor.close()
        conn.close()
        return (result, col)
    except Exception as e:
        return ([str(e)],''), ['error']

sql = 'show binary logs;'
host = '192.168.0.54'
user = 'root'
passwd = '123456abc'
port = 3306
data, col = mysql_query(sql, user, passwd, host, port, 'mysql')


print(data)
"""
(('mysql-bin.000021', 1326),('mysql-bin.000022', 915))
"""
print(col)
"""
['Log_name', 'File_size']
"""




