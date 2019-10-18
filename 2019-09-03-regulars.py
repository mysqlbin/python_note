#!/usr/local/bin/python3
#coding=utf-8



import re

#match
str = 'foo abc'        # 类似于 like 'foo'
m = re.match('foo', str)
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

sql = "select 2 from t"
if re.search("\*", sql) is not None:
    print(1111)