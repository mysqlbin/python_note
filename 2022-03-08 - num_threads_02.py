#!/usr/local/bin/python3
#coding=utf-8


import threading
import time

lists = []

def run_thread():
    for i in range(10000000):
        lists.append(i)

start_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
run_thread()
print(len(lists))
print("start_time: {}".format(start_time))
print("end_time: {}".format(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())))



start_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

t1 = threading.Thread(target=run_thread)
t2 = threading.Thread(target=run_thread)
t3 = threading.Thread(target=run_thread)
t1.start()
t2.start()
t3.start()
t1.join()
t2.join()
t3.join()
print(len(lists))
print("start_time_num_thread: {}".format(start_time))
print("end_time_num_thread: {}".format(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())))

"""
start_time_num_thread: 2022-03-08 12:07:16
end_time_num_thread: 2022-03-08 12:07:19
"""