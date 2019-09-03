#!/usr/local/bin/python3
#coding=utf-8


import  logging
import  traceback


logger = logging.getLogger('default')

def func(a, b):
    return a / b

if __name__ == '__main__':

    try:
        func(1, 0)
    except Exception as e:

        # print(e)
        ### 输出 ###
        """
        division by zero
       """

        logger.error(e)
        ### 输出 ###
        """
        division by zero
        """
        # logger.error(traceback.print_exc())
        ### 输出 ###
        """
        Traceback (most recent call last):
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 17, in <module>
            func(1, 0)
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 12, in func
            return a / b
        ZeroDivisionError: division by zero
        None
        """

        # logger.error(traceback.format_exc())
        ### 输出 ###
        """
        Traceback (most recent call last):
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 17, in <module>
            func(1, 0)
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 12, in func
            return a / b
        ZeroDivisionError: division by zero
        """

        # logger.error(traceback.print_exception())
        ### 输出 ###
        """
        Traceback (most recent call last):
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 17, in <module>
            func(1, 0)
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 12, in func
            return a / b
        ZeroDivisionError: division by zero

        During handling of the above exception, another exception occurred:

        Traceback (most recent call last):
          File "E:/20180411/project/python/python_note/2019-09-02-logging-traceback.py", line 49, in <module>
            logger.error(traceback.print_exception())
        TypeError: print_exception() missing 3 required positional arguments: 'etype', 'value', and 'tb'
        """

    """
    思考：
        在项目中如何看到 这些信息 logger.error(f"MySQL语句执行报错，语句：{sql}，错误信息{traceback.format_exc()}")

    Logging：
        https://mp.weixin.qq.com/s/iZEjyEoxVUQ5cner2VY1kg

        logging 模块可以让你跟踪代码运行时的事件，当程序崩溃时可以查看日志并且发现是什么引发了错误。

        Log 信息有内置的层级——调试（debugging）、信息（informational）、警告（warnings）、错误（error）和严重错误（critical）。
            你也可以在 logging 中包含 traceback 信息

        logging 模块的功能：

            控制信息层级，仅记录需要的信息。

            控制显示或者保存日志的时机。

            使用内置信息模板控制日志格式。

            知晓信息来自于哪个模块。

    Traceback:
        1、traceback.print_exc()：是对异常栈输出
        2、traceback.format_exc()：是把异常栈以字符串的形式返回，print(traceback.format_exc()) 就相当于traceback.print_exc()
        3、traceback.print_exception()：traceback.print_exc()实现方式就是traceback.print_exception(sys.exc_info())，可以点sys.exc_info()进去看看实现
    """