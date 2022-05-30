#!/usr/local/bin/python3
#coding=utf-8


import threading
import time

SqlTemplate = "select `link`, `link_name`\nfrom `t_homepage_link_exchange`\nwhere `is_deleted` = ?\n\tand `is_display` = ?\norder by `order_num` asc"


SqlTemplate = SqlTemplate.replace('\n', ' ').replace('\t', '')

print(SqlTemplate)


ids = [1,2,3,3,4,2,3,4,5,6,1]
news_ids = []
for id in ids:
    if id not in news_ids:
        news_ids.append(id)
print(news_ids)



itemLists = ['select count(?) as ? from (select t_alive.app_id from db_ex_alive.t_alive inner join db_ex_alive.t_alive_module_conf on t_alive.id = t_alive_module_conf.alive_id where t_alive_module_conf.is_open_qus = ? and t_alive.zb_start_at between ? and ? group by t_alive.app_id ) as tb;', 'select * from `t_sign_in` where `state` = ?;', 'select * from `t_alive_callback_file` where `file_type` = ? and `has_concat` = ? order by `file_index` asc;', 'select count(?) as ? from (select t_alive.app_id from db_ex_alive.t_alive inner join db_ex_alive.t_alive_module_conf on t_alive.id = t_alive_module_conf.alive_id where t_alive_module_conf.is_open_qus = ? and t_alive.zb_start_at between ? and ? group by t_alive.app_id ) as tb;']

for item in itemLists:
    print(item)

print("..............................")

lists = list(set(itemLists))

for it in lists:
    print(item)



def a():
    return 1
    print(111)

print(a())

filesize = 30
sqlbuf = 10
filename = "abc.sql"
for i in range(1,filesize,sqlbuf):
    print("文件{}: 检测到第{}字节".format(filename,i))

now_time = int(time.time())

print("now_time: {}".format(now_time))

totalAccount = 1
for i in range(0, totalAccount):
    print("i: {}".format(i))


[]