#!/usr/local/bin/python3
#coding=utf-8

# 正则表达式通常被用来检索、替换那些符合某个模式的文本

# 贪婪模式：
import re
div_content = "其它元素<div><span>用户:<span/><span>张三<span/></div> <br /><div><span>密码:<span/><span>123456<span/></div> 其它元素"
pattern = re.compile(r'<div>.*</div>')
match = pattern.findall(div_content)
print(match)
"""
返回：['<div><span>用户:<span/><span>张三<span/></div> <br /><div><span>密码:<span/><span>123456<span/></div>']
"""

# 非贪婪模式：
import re
div_content = "其它元素<div><span>用户:<span/><span>张三<span/></div> <br /><div><span>密码:<span/><span>123456<span/></div> 其它元素"
pattern = re.compile(r'<div>.*?</div>')
match = pattern.findall(div_content)
print(match)
"""
返回：['<div><span>用户:<span/><span>张三<span/></div>', '<div><span>密码:<span/><span>123456<span/></div>']
分析： 匹配第一个div标签结束之后，得到第一个div标签的内容；发现第二个div标签也符合匹配规则，得到第二个div标签的内容。
因此返回结果是 ['<div><span>用户:<span/><span>张三<span/></div>', '<div><span>密码:<span/><span>123456<span/></div>']
"""
# print(match)
# if match:
#     print(match.group())
# # print(match)
# print('no match')


# 贪婪模式
import re
div_content = "my string is:<li>QQemail</li><li>Not read email</a></li>"
pattern = re.compile(r'<li>.*</li>')
match = pattern.findall(div_content)
print(match)
# ['<li>QQemail</li><li>Not read email</a></li>']

# 非贪婪模式
import re
div_content = "my string is:<li>QQemail</li><li>Not read email</a></li>"
pattern = re.compile(r'<li>.*?</li>')
match = pattern.findall(div_content)
print(match)
# 匹配第一个li标签结束之后，得到第一个li标签的内容；发现第二个li标签也符合匹配规则，得到第二个li标签的内容。因此返回结果是 ['<li>QQemail</li>', '<li>Not read email</a></li>']。


# 非贪婪模式
import re
str = "aacbacbc"
pattern = re.compile(r'a.*?b')
match = pattern.findall(str)
print(match)



"""
相关参考： 
    https://www.runoob.com/regexp/regexp-syntax.html
"""


