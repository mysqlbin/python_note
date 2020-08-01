#!/usr/bin/ptyhon
#coding=gbk


"""
    1. 在函数内部优先查找局部作用域：
        先输出 var = 13
    2. 函数执行完局部变量就释放了，然后在局部找不到，便会去局部外的局部找：
        所以输出  12

"""
var = 12

def change_var():
    var = 13
    return var


if __name__ == "__main__":
    print(change_var())
    print(var)

"""

E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-30-02.py
13
12

"""