#!/usr/bin/ptyhon
#coding=gbk


"""
    1. �ں����ڲ����Ȳ��Ҿֲ�������
        ����� var = 13
    2. ����ִ����ֲ��������ͷ��ˣ�Ȼ���ھֲ��Ҳ��������ȥ�ֲ���ľֲ��ң�
        �������  12

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