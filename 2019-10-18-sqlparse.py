#!/usr/local/bin/python3
#coding=utf-8


import sqlparse

sql = "select * from t where id=1; select * from t where id=2;"

sql = sqlparse.format(sql, strip_comments=True)
print(sql)
sql = sqlparse.split(sql)[0]
print(sql)

