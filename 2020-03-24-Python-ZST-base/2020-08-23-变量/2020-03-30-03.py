#!/usr/bin/ptyhon
#coding=gbk


"""
    在函数中修改全局变量
    通过 global 声明在函数中修改全局变量

"""
var = 12
# print(id(var), 111)
# print(1)
def change_var():
    global var
    # print(id(var), 222)
    var = 13
    return var


if __name__ == "__main__":
    print(var)           # 12
    print(change_var())  # 13
    print(var)           # 13


"""

1473014880 111
1
12
1473014880 222
13
13

"""