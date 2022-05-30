#!/usr/local/bin/python3
#coding=utf-8


import threading
import time


def api(i):
    # time.sleep(i)
    # 调用API
    # slowdata = get_slow_log(env, instance_id, region, scan_interval_time, scan_time, i)
    # return slowdata
    return i


def count_thread():
    threads = []
    for i in range(0, 5):
        t = threading.Thread(target=api, args=(i,))
        threads.append(t)
    return threads

threads = count_thread()

for t in threads:
    t.start()
    while True:
        #判断正在运行的线程数量,如果小于5则退出while循环,
        #进入for循环启动新的进程.否则就一直在while循环进入死循环
        if(len(threading.enumerate()) < 5):
            break



# def count():
#     num = 0
#     for i in range(100):
#         num += 1
#         if num % 4:
#             time.sleep(0.1)
#         print(i)
#         # api()
#         t1 = threading.Thread(target=api)
#         t1.start()
#         time.sleep(0.1)
#     return 1



