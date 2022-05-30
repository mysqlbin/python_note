#!/usr/local/bin/python3
#coding=utf-8
import re


sql_type = "count(*)"
sql_template = 'select count(*) from aaa'
# searchOjb = re.search(sql_type,sql_template)
# if searchOjb:
#     print("searchOjb.group(): {}".format(searchOjb.group()))

if sql_type in sql_template:
    print(sql_type)