#!/usr/bin/ptyhon
#coding=gbk


"""
    �ں������޸�ȫ�ֱ���
    ͨ�� global �����ں������޸�ȫ�ֱ���

"""
var = 12
print(id(var), 111)
print(1)
def change_var():
    global var
    print(id(var), 222)
    var = 13
    return var


if __name__ == "__main__":
    print(var)
    print(change_var())
    print(var)

"""

E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-30-03.py
(6505196, 111)
1
12
(6505196, 222)
13
13

"""