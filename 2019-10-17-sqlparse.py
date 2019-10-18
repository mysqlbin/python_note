#!/usr/local/bin/python3
#coding=utf-8



import sqlparse

sql = 'select * from t where id=2'


"""
sql_split = sqlparse.split(sql, encoding=None)

print(sql_split)
# ['select * from t where id=2']
print(sql_split[0])
# select * from t where id=2

"""

sql_format = sqlparse.format(sql, strip_comments=True)
print(sql_format)
# select * from t where id=2






