#!/usr/local/bin/python3
#coding=utf-8

import time
import datetime


# start_time = '2019-06-18 03:00:00'
# start_times = datetime.datetime.strptime(start_time, '%Y-%m-%d %H:%M:%S')
# print(start_times)
#
#
# start_time_a = '2019-06-25 00:30:00'
# start_time_b = datetime.datetime.strptime(start_time_a, '%Y-%m-%d %H:%M:%S')
# print(start_time_b)

# 日期减一天
default_time = time.strftime("%Y-%m-%d")
default_time = datetime.datetime.strptime(default_time, '%Y-%m-%d') + datetime.timedelta(days=-60)
print(default_time)
# print(default_time.strftime('%d'))

# 日期加一天
# default_current_time = time.strftime("%Y-%m-%d")
# default_current_time = datetime.datetime.strptime(default_current_time, '%Y-%m-%d') + datetime.timedelta(days=1)
# print(default_current_time)



# now =   datetime.datetime.strptime(datetime.datetime.now(), '%Y%m%d')


# now=datetime.datetime.now()
# year = now.strftime('%Y')
# month = now.strftime('%m')
# day = now.strftime('%d')
# print(year)
# print(month)
# print(day)

now = datetime.datetime.now()
year = now.strftime('%Y')
month = now.strftime('%m')
# day = now.strftime('%d')

current_time = time.strftime("%Y-%m-%d")
current_time = datetime.datetime.strptime(current_time, '%Y-%m-%d') + datetime.timedelta(days=-1)
day = current_time.strftime('%d')


filename = f'/data/mysql/mysql3306/data/error.log-{year}{month}{day}'
print(filename)


