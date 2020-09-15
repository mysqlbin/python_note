#!/usr/local/bin/python3
#coding=utf-8
import re

""" ^ 匹配一行的开头 """
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'^\d')
print(pattern.findall(str))
""" 输出：['1'] """


""" ^ 匹配一行的结尾 """
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'\d$')
print(pattern.findall(str))
""" 输出：['3'] """






