#!/usr/local/bin/python3
#coding=utf-8

import argparse
import sys
import logging
import re

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='argparse.log',
                    filemode='a')

logger = logging.getLogger(__name__)

"""
https://www.imooc.com/article/34047
https://www.cnblogs.com/dengtou/p/8413609.html

argparse模块
    argparse是python用于解析命令行参数和选项的标准模块，用于代替已经过时的optparse模块

使用步骤
    import argparse  # 导入模块
    parser = argparse.ArgumentParser()  # 实例化一个对象，默认参数一堆，只有description参数可以设置一下
    parser.add_argument()  # 一次加入每一个参数或选项，主要是这里
    parser.parse_args()  # 解析命令行获取参数，用的时候给他赋个值


样例应用：
    python 2019-09-06-argparse.py -soD=1 -soT=2 -deD=3 -deT=4

"""
"""
parser = argparse.ArgumentParser(description = 'this is a description')
parser.add_argument('-soD', '--source-database', dest = 'source_database', help='source database', type=str)
parser.add_argument('-soT', '--source-table', dest = 'source_table', help='source table', type=str)
parser.add_argument('-deD', '--dest-database', dest = 'dest_database', help='dest database', type=str)
parser.add_argument('-deT', '--dest-table', dest = 'dest_table', help='dest table', type=str)

-soD 是短参数
--source-databas 是长参数

args = parser.parse_args()

# if args.source-table:
print(args.source_database)
print(args.source_table)
print(args.dest_database)
print(args.dest_table)
"""


def parse_args_fun():

   parser = argparse.ArgumentParser()
   parser.add_argument('-soD', '--source-database', dest='source_database', help='source database', type=str)
   parser.add_argument('-soT', '--source-table', dest='source_table', help='source table', type=str)
   parser.add_argument('-deD', '--dest-database', dest='dest_database', help='dest database', type=str)
   parser.add_argument('-deT', '--dest-table', dest='dest_table', help='dest table', type=str)
   parser.add_argument('-beforeDay', '--before-data', dest='before_day', help='before day', type=int)

   return parser


def command_line_args(args):
    parser = parse_args_fun()
    args = parser.parse_args(args)
    return args



if __name__ == '__main__':

    print(sys.argv[1:])
    ### 输出 ####
    """
        ['-soD=1', 'soT=2', '-deD=3', '-deT=4']
    """
    args = command_line_args(sys.argv[1:])   #接收参数
    source_database = args.source_database
    source_table = args.source_table
    before_day = args.before_day

    if source_database == '' or source_table == '' or before_day == '':
        print('test')
        logger.error('source_database is Null or source_table is null')
        exit()

    if before_day > 0:
        logger.error('The date format does not match . exit')
        exit()

    # print(args.source_database)
    # print(args.source_table)
    # print(args.dest_database)
    # print(args.dest_table)
    # print(before_day)