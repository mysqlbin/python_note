#!/usr/local/bin/python3
#coding=utf-8

args = {"conn_options": fr"-h192.168.1.1 -uroot -p123456abc -P3306 ",
           "stop_never": False,
            "no-primary-key": 1,
            "flashback": 2,
            "back-interval": 3,
            "start-file": 4,
            "start-position": 5,
            "stop-file": 6,
            "stop-position": 7,
            "start-datetime": 8,
            "stop-datetime": 9,
    }

for arg in args.keys():
    print(arg)