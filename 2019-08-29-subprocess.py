#!/usr/local/bin/python3
#coding=utf-8


import  subprocess
import logging
import traceback

logger = logging.getLogger('default')


"""
subprocess模块：
    是派生进程的主要替换方案，可以单纯地执行任务，或者通过标准文件(stdin、stdout、stderr)进行进程间通信。 By Python核心编程第3版 163页
    stdin：  表示程序的标准输入

    stdout： 表示程序的标准输出
    stderr： 表示程序的标准错误输出

    subprocess.Popen:
        subprocess模块下的Popen方法，实现：在执行该程序的服务器上实现shell命令的执行；

    subprocess.PIPE--->管道机制：一个程序与另一个程序实现通信，
    例如：cmd命令提示符与屏幕显示，又如：subprocess 与屏幕显示
    subprocess.POPE：
        有stdout:标准输出内容扔到管道；
        有stderr：标准错误输出内容扔到管道；
        有stdin：标准输入内容扔到管道；


subprocess用于调用终端命令
参考文章:
    https://www.jianshu.com/p/932fda772506
    https://blog.csdn.net/ak739105231/article/details/86742031
    https://www.jianshu.com/p/11090e197648

tail -f /data/mysql/mysql3306/data/error.log
"""


def execute_cmd(cmd_args, shell):
    """
    执行命令并且返回process
    :return:
    """
    try:
        p = subprocess.Popen(cmd_args,
                             shell=shell,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             universal_newlines=True)
        return p
    except Exception as e:
        logger.error("命令执行失败\n{}".format(traceback.format_exc()))
        raise RuntimeError('命令执行失败，失败原因:%s' % str(e))

if __name__ == '__main__':
    cmd_args = 'tail -f /data/mysql/mysql3306/data/error.log'
    p = execute_cmd(cmd_args, shell=True)
    for line in iter(p.stdout.readline, ''):
        print line