#!/usr/local/bin/python3
#coding=utf-8

import time
import datetime

# 要加上目录


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

# default_time = time.strftime("%Y-%m-%d %H:%M:%S")
# default_time = datetime.datetime.strptime(default_time, '%Y-%m-%d %H:%M:%S') + datetime.timedelta(days=-1)
# print(default_time)


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

# now = datetime.datetime.now()
# year = now.strftime('%Y')
# month = now.strftime('%m')
# # day = now.strftime('%d')
#
# current_time = time.strftime("%Y-%m-%d")
# current_time = datetime.datetime.strptime(current_time, '%Y-%m-%d') + datetime.timedelta(days=-1)
# day = current_time.strftime('%d')


# 时间戳
import time
print('time.time(): {}'.format(time.time()))
now_time = int(time.time())
print("时间戳：{}".format(now_time))


print('.................................')
# 时间转为时间戳
# 字符类型的时间
tss1 = '2022-02-22 16:00:00'
print('时间: {}'.format(tss1))

# 转为时间数组
timeArray = time.strptime(tss1, "%Y-%m-%d %H:%M:%S")
print(timeArray)

# 转为时间戳
timeStamp = int(time.mktime(timeArray))
print('时间戳: {}'.format(timeStamp))


print('.................................')

# 时间戳转为时间

# 获得指定时间时间戳
now = int(1645516408)
#转换为其他日期格式,如:"%Y-%m-%d %H:%M:%S"
timeArray = time.localtime(now)
otherStyleTime = time.strftime("%Y-%m-%d %H:%M:%S", timeArray)

print('时间: {}'.format(otherStyleTime))

print('.................................')


# nowtime = 1645516800
nowtime = int(time.time())
sql_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(nowtime))
sql_comp_time = str(sql_time) + '.000000'
print("sql_comp_time: 1".format(sql_comp_time))
