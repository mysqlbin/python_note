#!/usr/local/bin/python3
#coding=utf-8



import re

#match
str = 'foo abc'        # 
m = re.match('foo', str)
if m is not None:
    print(m.group())

import re
str = 'a foo abc'     
m = re.match('foo', str)
print(m)
None
if m is not None:
    print(m.group())
    
    
#search
str_search = 'abc faad'
m_search = re.search('aa', str_search)  #类似于 like '%aa%'
if m_search is not None:
    print(m_search.group())



#search
str_search = '-31'
m_search = re.search('-', str_search)  #类似于 like '%aa%'
if m_search == None:
    print(10)
# my_dict = {'a': 'c'}
#
# if not bool(my_dict):
#     print("Dictionary is empty")

sql = "selecta 2 from t"
if re.search("\*", sql) is not None:
    print(1111)


if re.match("select|show|explain|desc", sql) is None:
    print(2222)


sql_content = 'select id,username from auth_user limit 2;'
if re.match("show", sql_content) is not None:
        limit_num = 0
        print(limit_num)