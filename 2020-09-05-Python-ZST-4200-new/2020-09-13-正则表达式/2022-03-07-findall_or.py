#!/usr/local/bin/python3
#coding=utf-8
import re

# 1. findall


# 1. findall

import re
line = 'Cats are smarter than dogs'
res = re.findall(r'are| dogs', line, re.M | re.I)
if res:
    print("res_01: {}".format(res))
else:
    print("not find")
"""
res_01: ['are', ' dogs']
"""
print("..................................................")


res = re.findall(r'are| dogsaaa', line, re.M | re.I)
if res:
    print("res_02: {}".format(res))
else:
    print("not find")


line = 'Cats are smarter than dogs'
res = re.findall(r'are| dogs', line, re.M | re.I)
if res:
    print("res_01: {}".format(res))
else:
    print("not find")


print("..................................................")


sqltext = "information_schema.tables"


searchOjb = re.search('information_schema| performance_schema', sqltext, re.M|re.I)
if searchOjb:
    print("searchOjb: {}".format(searchOjb))
    print("searchOjb.group(): {}".format(searchOjb.group()))
else:
    print('None')

