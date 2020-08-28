#!/usr/bin/ptyhon
#coding=gbk


"""
下面例子输出1的原因：
    这是使用的局部作用域
"""
var = 10

def test():
    print(var)
    var = 1
    print(var)

if __name__ == "__main__":
    test()

