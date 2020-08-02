#!/usr/bin/env python
# -*- coding:utf-8 -*-


# main.py

import sys


from utils.utils import get_sum
from utils.class_utils import Encoder,Decoder

print(sys.path)

print(get_sum(1, 2))

encoder = Encoder()
decoder = Decoder()

print(encoder.encode('abcde'))
print(decoder.decode('edcba'))


"""
 main.py 调用子目录的模块时， 只需要使用 . 代替 / 来表示子目录， utils.utils 表示 utils 子文件夹下的 utils.py
 sys.path.append("..") 表示将当前程序所在的位置向上提一级，之后就能调用 utils 模块了。
 import 同一个模块只会被执行一次， 这样可以防止重复导入模块出现问题；
    良好的编程习惯应该杜绝代码多次导入的情况；
    除了一些极其特殊的情况， import 必须位于程序的最前端。
"""