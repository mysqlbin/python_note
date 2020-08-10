#!/usr/bin/python
#coding=utf-8

import os

""" 1. os.system """
status = os.system('sh ./2020-08-10.sh')
print(status)
print(status & 127)
print(status >> 8)
"""
输出：
    [root@localhost scripts]# python 2020-08-10-file2.py 
    2020年 08月 10日 星期一 15:50:21 CST
    2020年 08月 10日 星期一 15:50:23 CST
    256
    0
    1
"""

""" 2. os.popen """
tmp = os.popen("ls -alh").readlines()
print(tmp)
"""
输出：
    [root@localhost scripts]# python 2020-08-10-file2.py
    ['\xe6\x80\xbb\xe7\x94\xa8\xe9\x87\x8f 32K\n', 'drwxr-xr-x.  3 root root  153 8\xe6\x9c\x88  10 15:55 .\n', 'dr-xr-x---. 12 root root 4.0K 8\xe6\x9c\x88  10 15:55 ..\n', '-rw-r--r--.  1 root root  210 8\xe6\x9c\x88  10 15:55 2020-08-10-file2.py\n', '-rw-r--r--.  1 root root   61 8\xe6\x9c\x88  10 15:35 2020-08-10.sh\n', 'drwxr-xr-x.  2 root root   32 8\xe6\x9c\x88   6 14:46 abc\n', '-rwxr-xr-x.  1 root root  540 7\xe6\x9c\x88  10 16:03 mongodb_backcup.sh\n', '-rwxr-xr-x.  1 root root 9.7K 6\xe6\x9c\x88  18 14:39 pt_archiver_by_date_py2.py\n', '-rwxr-xr-x.  1 root root 2.0K 7\xe6\x9c\x88  14 15:41 score_monitor_py2.py\n']

[root@localhost scripts]# ls -alh
总用量 32K
drwxr-xr-x.  3 root root  153 8月  10 15:55 .
dr-xr-x---. 12 root root 4.0K 8月  10 15:55 ..
-rw-r--r--.  1 root root  210 8月  10 15:55 2020-08-10-file2.py
-rw-r--r--.  1 root root   61 8月  10 15:35 2020-08-10.sh
drwxr-xr-x.  2 root root   32 8月   6 14:46 abc
-rwxr-xr-x.  1 root root  540 7月  10 16:03 mongodb_backcup.sh
-rwxr-xr-x.  1 root root 9.7K 6月  18 14:39 pt_archiver_by_date_py2.py
-rwxr-xr-x.  1 root root 2.0K 7月  14 15:41 score_monitor_py2.py
"""

""" 3. subprocess """
import subprocess
subprocess.run("ls")
"""
[root@localhost scripts]# python3 2020-08-10-file2.py 
2020-08-10-file2.py  2020-08-10.sh  abc  mongodb_backcup.sh  pt_archiver_by_date_py2.py  Python-3.7.4  Python-3.7.4.tgz  score_monitor_py2.py
[root@localhost scripts]# ls
2020-08-10-file2.py  2020-08-10.sh  abc  mongodb_backcup.sh  pt_archiver_by_date_py2.py  Python-3.7.4  Python-3.7.4.tgz  score_monitor_py2.py
执行这个命令，会自动把结果打印到标准输出中。
"""

import subprocess
subprocess.run(["ls", "-lah"])
"""
==
"""
subprocess.run("ls -lah", shell=True)

"""
输出：
    [root@localhost scripts]# python3 2020-08-10-file2.py 
    总用量 22M
    drwxr-xr-x.  4 root root  197 8月  10 17:16 .
    dr-xr-x---. 12 root root 4.0K 8月  10 17:16 ..
    -rw-r--r--.  1 root root  396 8月  10 17:16 2020-08-10-file2.py
    -rw-r--r--.  1 root root   61 8月  10 15:35 2020-08-10.sh
    drwxr-xr-x.  2 root root   32 8月   6 14:46 abc
    -rwxr-xr-x.  1 root root  540 7月  10 16:03 mongodb_backcup.sh
    -rwxr-xr-x.  1 root root 9.7K 6月  18 14:39 pt_archiver_by_date_py2.py
    drwxr-xr-x. 19  501  501 4.0K 8月  10 16:57 Python-3.7.4
    -rw-r--r--.  1 root root  22M 8月  10 16:45 Python-3.7.4.tgz
    -rwxr-xr-x.  1 root root 2.0K 7月  14 15:41 score_monitor_py2.py
"""


"""
capture output：捕获输出
把输出保存在一个变量当中,原理与shell的重定向符号类似: 加入catpure_output=True的参数

"""
import subprocess
s = subprocess.run("sh ./2020-08-10.sh", shell=True, capture_output=True, text=True)
print(s)
print("Stdout: " + s.stdout)
print("Stderr: " + s.stderr)
print("returncode: {}".format(s.returncode))

"""
输出：
    CompletedProcess(args='sh ./2020-08-10.sh', returncode=1, stdout='2020年 08月 10日 星期一 17:46:05 CST\n', stderr='2020年 08月 10日 星期一 17:46:08 CST\n')
    Stdout: 2020年 08月 10日 星期一 17:42:25 CST
    
    Stderr: 2020年 08月 10日 星期一 17:42:27 CST
    
    returncode: 1

"""


"""
    把标准输出重定向到 PIPE 中
"""
import subprocess
s = subprocess.run("sh ./2020-08-10.sh", shell=True, stdout=subprocess.PIPE, text=True)
print(s)
print("Stdout: ")
print(s.stdout)
print("Stderr: " )
print(s.stderr)

"""
输出：
    [root@localhost scripts]# python3 2020-08-10-file2.py 
    2020年 08月 10日 星期一 18:05:20 CST
    CompletedProcess(args='sh ./2020-08-10.sh', returncode=1, stdout='2020年 08月 10日 星期一 18:05:18 CST\n')
    Stdout: 
    2020年 08月 10日 星期一 18:05:18 CST
    
    Stderr: 
    None

"""

"""
stdout参数也可以是一个文件对象
stdout=fp: 把
"""
import subprocess
fp = open("a.txt", "w")
s = subprocess.run("sh ./2020-08-10.sh", shell=True, stdout=fp)
print(s)
print(f"Args: {s.args}, ReturnCode: {s.returncode}, Output: {s.stdout},{s.stderr}")
fp.close()
"""
输出：
    [root@localhost scripts]# python3 2020-08-10-file2.py 
    2020年 08月 10日 星期一 18:20:11 CST
    CompletedProcess(args='sh ./2020-08-10.sh', returncode=1)
    Args: sh ./2020-08-10.sh, ReturnCode: 1, Output: None,None
    
    [root@localhost scripts]# cat a.txt 
    2020年 08月 10日 星期一 18:20:09 CST

"""


"""
check=True 如果希望当命令执行失败的时候，抛出异常
"""
import subprocess
s = subprocess.run("sh ./2020-08-10.sh", shell=True, capture_output=True, text=True, check=True)
print(s)
print("Stdout: " + s.stdout)
print("Stderr: " + s.stderr)
print("returncode: {}".format(s.returncode))
"""
输出：
    [root@localhost scripts]# python3 2020-08-10-file2.py 
    Traceback (most recent call last):
      File "2020-08-10-file2.py", line 54, in <module>
        s = subprocess.run("sh ./2020-08-10.sh", shell=True, capture_output=True, text=True, check=True)
      File "/usr/local/lib/python3.7/subprocess.py", line 487, in run
        output=stdout, stderr=stderr)
    subprocess.CalledProcessError: Command 'sh ./2020-08-10.sh' returned non-zero exit status 1.
"""


"""
重定向的概念和理解
"""

