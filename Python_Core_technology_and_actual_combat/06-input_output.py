#!/usr/local/bin/python3
#coding=utf-8

#输入输出基础
#键盘操作
#例子一
name = input('your name:')
gender = input('you are a boy?(y/n)')
print(name)
print(gender)
###### 输入下面的内容 ######
"""
your name:Bin
you are a boy?(y/n)y
"""
###### 输出下面的内容, 即获取到输入的值 #########
"""
Bin
y
"""
# 做判断之后, 格式化输出
welcome_str = 'Welcome to the matrix {prefix} {name}.'
welcome_dic = {
    'prefix': 'Mr.' if gender == 'y' else 'Mrs',
    'name': name
}

print('authorizing...')
print(welcome_str.format(**welcome_dic))

########## 输出下面的内容 ##########
"""
authorizing...
Welcome to the matrix Mr. Bin.
"""



#例子二
a = input()
b = input()

print('a + b = {}'.format(a + b))
########## 输出下面注释的内容 ##############
"""
a + b = 12
"""
print('type of a is {}, type of b is {}'.format(type(a), type(b)))
########## 输出下面注释的内容 ##############
"""
type of a is <class 'str'>, type of b is <class 'str'>
"""
print('a + b = {}'.format(int(a) + int(b)))
########## 输出下面注释的内容 ##############
"""
a + b = 3
"""

#把 str 强制转换为 int 请用 int()，转为浮点数请用 float()。而在生产环境中使用强制转换时，请记得加上 try except（即错误和异常处理）。




#文件输入输出 

import re

# 你不用太关心这个函数
def parse(text):
    # 使用正则表达式去除标点符号和换行符
    text = re.sub(r'[^\w ]', ' ', text)

    # 转为小写
    text = text.lower()

    # 生成所有单词的列表
    word_list = text.split(' ')

    # 去除空白单词
    word_list = filter(None, word_list)

    # 生成单词和词频的字典
    word_cnt = {}
    for word in word_list:
        if word not in word_cnt:
            word_cnt[word] = 0
        word_cnt[word] += 1

    # 按照词频排序
    sorted_word_cnt = sorted(word_cnt.items(), key=lambda kv: kv[1], reverse=True)

    return sorted_word_cnt

with open('in.txt', 'r') as fin:
    text = fin.read()

word_and_freq = parse(text)

with open('out.txt', 'w') as fout:
    for word, freq in word_and_freq:
        fout.write('{} {}\n'.format(word, freq))

########## 输出 (省略较长的中间结果) ##########


"""
先用 open()函数拿到文件的指针
    第一个参数指定文件位置(相对位置或者绝对位置)
    第二个参数:
        r: 表示读取
        w: 表示写入
        rw: 表示读取和写入
        a: 表示 append(追加)
            打开的文件, 如果需要写入,会从原始文件的最末尾开始写入.
拿到文件的指针后, 通过 read() 函数来读取文件的全部内容
    text = fin.read() 表示把文件所有内容读取到内存中, 并赋值给变量 text.
"""

"""
with 语句:
    open() 函数对应于 close() 函数
    打开了文件, 在完成读取任务后, 就应该立即关掉它
    使用了 with 语句, 不需要显示调用 close();
    在 with的语境下任务执行完毕后, close()函数会被自动调用.
"""

