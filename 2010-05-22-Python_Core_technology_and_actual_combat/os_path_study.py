#!/usr/local/bin/python3
#coding=utf-8

import os
import re


receiver = ['13202095158@163.com', '1224056230@qq.com']

print(";".join(receiver))



#获取当前文件的绝对路径
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
print(BASE_DIR)

#join: 把目录和文件名合成一个路径
filename_in =  os.path.join(BASE_DIR, 'Python_Core_technology_and_actual_combat', "file\in.txt")
print(filename_in)

filename_out =  os.path.join(BASE_DIR, 'Python_Core_technology_and_actual_combat', "file\out.txt")


"""
读取文件；
去除所有标点符号和换行符，并把所有大写变成小写；
合并相同的词，统计每个词出现的频率，并按照词频从大到小排序；
将结果按行输出到文件 out.txt。
"""

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


with open(filename_in, 'r') as fin:
    text = fin.read()
#print(text)

word_and_freq = parse(text)
print(word_and_freq)
#[('i', 4), ('have', 4), ('a', 4), ('dream', 4), ('that', 3), ('one', 3), ('day', 3), ('my', 1), ('four', 1), ('little', 1), ('children', 1), ('will', 1), ('live', 1), ('today', 1), ('down', 1), ('in', 1), ('alabama', 1), ('with', 1), ('its', 1), ('vicious', 1), ('racists', 1), ('every', 1), ('valley', 1), ('shall', 1), ('be', 1), ('exalted', 1)]

# 把词和频率输出到文件中
with open(filename_out, 'w') as fout:
    for val,time in word_and_freq:
        fout.write('{} {}\n'.format(val, time))
