#!/usr/local/bin/python3
#coding=utf-8

import logging

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='myapp.log',
                    filemode='a')

logger = logging.getLogger(__name__)

logger.debug('This is debug message')
logger.info('This is info message')
logger.warning('This is warning message')


### 输出 ###

"""
2019-09-04 15:36:48,126 2019-09-04-logging.py[line:13] DEBUG This is debug message
2019-09-04 15:36:48,127 2019-09-04-logging.py[line:14] INFO This is info message
2019-09-04 15:36:48,127 2019-09-04-logging.py[line:15] WARNING This is warning message
"""

