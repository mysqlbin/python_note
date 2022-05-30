#!/usr/local/bin/python3
#coding=utf-8



import sqlparse


# https://zhuanlan.zhihu.com/p/279297051


sql = 'select * from t where id=2; select * from bar;'


sql_split_res = sqlparse.split(sql)
print("sql_split_res_type: {}".format(type(sql_split_res)))
print("sql_split_res: {}".format(sql_split_res))
for val in sql_split_res:
    print("sql_list: {}".format(val))

"""
sql_split_res_type: <class 'list'>
sql_split_res: ['select * from t where id=2;', 'select * from bar;']
sql_list: select * from t where id=2;
sql_list: select * from bar;
"""






