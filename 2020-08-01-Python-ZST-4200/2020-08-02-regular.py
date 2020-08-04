#!/usr/local/bin/python3
#coding=utf-8


""" \d 匹配数字"""
""" \d 匹配数字 """
import re
str = "abc123456"
pattern = re.compile(r'\d')  -- 正则表达式的匹配模式/规则 匹配的正则表达式
print(pattern.findall(str))  -- 把所有的字符串都找出来
""" 输出： ['1', '2', '3', '4', '5', '6'] """


""" \w 匹配数字或者字母"""
import re
str = "abc,123456"
pattern = re.compile(r'\w')
print(pattern.findall(str))
""" 输出： ['a', 'b', 'c', '1', '2', '3', '4', '5', '6'] """



""" \W 匹配非数字或者字母"""
import re
str = "abc,123456……%"
pattern = re.compile(r'\W')
print(pattern.findall(str))
""" 输出： [',', '…', '…', '%'] """


""" \s 匹配空格、tab 等"""
import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\s')
print(pattern.findall(str))
""" 输出：['\n', ' ', ' ', '\t', '\r'] """


""" \S 匹配非空格、tab 等"""
import re
str = "abc,123\n  \t\r"
pattern = re.compile(r'\S')
print(pattern.findall(str))
""" 输出：['a', 'b', 'c', ',', '1', '2', '3'] """


""" {n} 匹配的字符数 """
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'\d{11}')
print(pattern.findall(str))
""" 输出：['13202095158'] """


""" *号, 匹配0个或者更多"""
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'\d*')
print(pattern.findall(str))
""" 输出： ['13202095158', '', '0775', '', '2929123', ''] """
"""
首先：* 表示匹配 0 个或者更多
\n 匹配到了一个 "" 空字符串，表示匹配到了0个数字
-  匹配到了一个 "" 空字符串，表示匹配到了0个数字
"""


""" +号, 表示匹配至少1个"""
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'\d+')
print(pattern.findall(str))
""" 输出： ['13202095158', '0775', '2929123'] """
"""
首先：+ 表示匹配 1个或者更多，至少1个
\n 匹配到了一个 "" 空字符串，表示匹配到了0个数字，+ 表示 至少要匹配到1个，所以不符合匹配规则
-  匹配到了一个 "" 空字符串，表示匹配到了0个数字，+ 表示 至少要匹配到1个，所以不符合匹配规则
"""

""" ?号, 表示匹配0个或1个"""
import re
str = "13202095158\n0775-2929123"
pattern = re.compile(r'\d?')
print(pattern.findall(str))

""" 输出：
['1', '3', '2', '0', '2', '0', '9', '5', '1', '5', '8', '', '0', '7', '7', '5',
'', '2', '9', '2', '9', '1', '2', '3', '']
"""
"""
首先：? 表示匹配  0个或1个
\n 匹配到了一个 "" 空字符串，表示匹配到了0个数字，符合匹配规则
-  匹配到了一个 "" 空字符串，表示匹配到了0个数字，符合匹配规则
"""


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










