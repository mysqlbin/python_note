#!/usr/bin/env python
#coding=utf-8

import os
cur_path = './'
if os.path.isdir(cur_path):
    files = os.listdir(cur_path)   # 返回指定路径下的文件和文件夹列表。返回结果的数据类型是一个列表
    print(files)
    for file in files:
        # print(file)
        print(os.path.join('usr', file))


"""
print(files) 的结果：
['bak_pt_archiver_by_date_py2.py', 'pt_archiver_by_date_py2.py', 'mongodb_backcup.sh', 'score_monitor_py2.py', 'abc', '2020-08-06-file.py']

[root@localhost scripts]# ls
2020-08-06-file.py  abc  bak_pt_archiver_by_date_py2.py  mongodb_backcup.sh  pt_archiver_by_date_py2.py  score_monitor_py2.py

可以看到， os.listdir 等于 Linux 的 ls 命令的，只是 os.listdir 返回结果的数据类型是一个列表 

--------------------------------------------------------------------------------------------------------------------------------------------

[root@localhost scripts]# ll
总用量 36
-rwxr-xr-x. 1 root root  336 8月   6 14:45 2020-08-06-file.py
drwxr-xr-x. 2 root root   32 8月   6 14:46 abc
-rwxr-xr-x. 1 root root 9506 6月  18 14:39 bak_pt_archiver_by_date_py2.py
-rwxr-xr-x. 1 root root  540 7月  10 16:03 mongodb_backcup.sh
-rwxr-xr-x. 1 root root 9833 6月  18 14:39 pt_archiver_by_date_py2.py
-rwxr-xr-x. 1 root root 2000 7月  14 15:41 score_monitor_py2.py

print(os.path.join('usr', file)) 的结果
[root@localhost scripts]# python 2020-08-06-file.py 
usr/bak_pt_archiver_by_date_py2.py
usr/pt_archiver_by_date_py2.py
usr/mongodb_backcup.sh
usr/score_monitor_py2.py
usr/abc
usr/2020-08-06-file.py

"""