#!/usr/bin/env python
# -*- coding:utf-8 -*-

# src/main.py

import sys

print(sys.path)


from proto.mat import Matrix
from utils.mat_mul import mat_mul

"""
import Matrix的方式是 from proto.mat
    这种做法, 直接从项目根目录中导入, 并依次向下导入模块 mat.py 中的 Matrix
    而不是使用 .. 导入 上一级文件夹.

Python 解释器在遇到 import的时候，它会在 sys.path 的列表中寻找模块，第一项为空， Pycharm 做的一件事， 就是将第一项设置为项目根目录的绝对路径。
"""

a = Matrix([[1, 2], [3, 4]])
b = Matrix([[5, 6], [7, 8]])

print(mat_mul(a, b).data)


