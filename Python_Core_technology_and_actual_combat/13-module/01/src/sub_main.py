#!/usr/bin/env python
# -*- coding:utf-8 -*-

# src/sub_main.py

import sys
#sys.path.append("..")

from utils.class_utils import *

encoder = Encoder()
decoder = Decoder()

print(encoder.encode('abcde'))
print(decoder.decode('edcba'))

########## 输出 ##########
"""
edcba
abcde
"""


