#!/usr/bin/ptyhon
#coding=gbk


"""
下面例子输出1的原因：
    这是使用的局部作用域
"""
var = 10

def test():
    var = 1
    print(var)

if __name__ == "__main__":
    test()

"""

E:\Study\python\python_note\2020-03-24-Python-ZST>python 2020-03-30-01.py
1

"""