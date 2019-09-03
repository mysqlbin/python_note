#!/usr/local/bin/python3
#coding=utf-8


import  subprocess

"""
subprocess用于调用终端命令
https://www.jianshu.com/p/932fda772506

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
        # logger.error("命令执行失败\n{}".format(traceback.format_exc()))
        raise RuntimeError('命令执行失败，失败原因:%s' % str(e))

if __name__ == '__main__':
    cmd_args = 'tail -f /data/mysql/mysql3306/data/error.log'
    p = execute_cmd(cmd_args, shell=True)
    for line in iter(p.stdout.readline, ''):
        print line