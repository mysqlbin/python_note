

django-admin startapp alertinfo



https://www.runoob.com/python/python-email.html

https://zhuanlan.zhihu.com/p/46890207

https://blog.csdn.net/weixin_40683253/article/details/87376085

http://www.srcmini.com/30789.html  numpy.asarray()函数


pipenv install numpy
pipenv install matplotlib



windows
pip install numpy
pip --default-timeout=3600 install numpy
pip install matplotlib
pip --default-timeout=3600 install matplotlib




['2021-01-10', '2021-01-11', '2021-01-12', '2021-01-13', '2021-01-14']
counts = [4, 12, 36, 32, 212]

import numpy as np
counts = [4, 12, 36, 32, 212]
print(np.asarray(counts))
[  4  12  36  32 212]


返回具有与序列等效值的数组。

