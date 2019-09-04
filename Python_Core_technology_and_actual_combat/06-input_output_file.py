#!/usr/local/bin/python3
#coding=utf-8

#文件输入输出 

import os
import re

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

path = os.path.abspath(os.path.dirname(__file__))
filename_in = os.path.join(path, "in.txt")
filename_out = os.path.join(path, "out.txt")

with open(filename_in, 'r') as fin:
    text = fin.read()

word_and_freq = parse(text)

with open(filename_out, 'w') as fout:
    for word, freq in word_and_freq:
        fout.write('{} {}\n'.format(word, freq))

########## 输出 (省略较长的中间结果) ##########
"""
and 15
be 13
......
......
almighty 1
are 1
"""

"""

做一个简单的 NLP（自然语言处理）任务，NLP 任务的基本步骤：

    1. 读取文件；
    2. 去除所有标点符号和换行符，并把所有大写变成小写；
    3. 合并相同的词，统计每个词出现的频率，并按照词频从大到小排序；
    4. 将结果按行输出到文件 out.txt。


parse() 函数：
    做的事情是把输入的 text 字符串，转化为我们需要的排序后的词频统计。
    sorted_word_cnt 则是一个二元组的列表（list of tuples）。

open()函数：
    通过open()函数拿到文件的指针
    第一个参数指定文件位置(相对位置或者绝对位置)
    第二个参数:
        r: 表示读取
        w: 表示写入
        rw: 表示读取和写入
        a: 表示 append(追加)， 这样打开的文件, 如果需要写入,会从原始文件的最末尾开始写入.

read()函数：

    拿到文件的指针后, 通过 read() 函数来读取文件的全部内容
    text = fin.read() 表示把文件所有内容读取到内存中, 并赋值给变量 text.

    read()函数的优缺点:
        优点:
            方便，接下来我们可以很方便地调用 parse 函数进行分析；
        缺点:
            如果文件过大，一次性读取可能造成内存崩溃。
            优化:
                1. 给 read 指定参数 size ，用来表示读取的最大长度
                2. 通过 readline() 函数，每次读取一行
                    这种做法常用于数据挖掘（Data Mining）中的数据清洗，在写一些小的程序时非常轻便。
                    如果每行之间没有关联，这种做法也可以降低内存的压力。

with 语句:
    open() 函数对应于 close() 函数
    如果打开了文件, 在完成读取任务后, 就应该立即关掉它
    使用了 with 语句, 不需要显示调用 close();
    在 with的语境下任务执行完毕后, close()函数会被自动调用.

"""

