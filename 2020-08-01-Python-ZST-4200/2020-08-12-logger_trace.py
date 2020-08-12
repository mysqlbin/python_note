import logging

logger = logging.getLogger('logger_test')    # 每行日志记录开头的名称
logger.setLevel('DEBUG')        # 设置日志记录级别，把日志记录级别大于等于DEBUG的记录下来

BASIC_FORMAT = "%(name)s %(asctime)s %(filename)s:%(lineno)s %(levelname)s %(message)s"    # 设置日志记录的格式
DATE_FORMAT = "%Y-%m-%d %H:%M:%S"

# formatter = logging.Formatter(BASIC_FORMAT, DATE_FORMAT)  # 设置日志记录的格式
formatter = logging.Formatter(BASIC_FORMAT)  # 设置日志记录的格式

chlr = logging.StreamHandler()  # 输出到控制台的Handler
chlr.setFormatter(formatter)
chlr.setLevel('DEBUG')          # 也可以不设置，不设置就默认用logger的level

fhlr = logging.FileHandler('example.log')  # 输出到文件的handler
fhlr.setFormatter(formatter)
fhlr.setLevel('INFO')           # 设置日志记录级别，把日志记录级别大于等于INFO的记录下来

logger.addHandler(chlr)
logger.addHandler(fhlr)

if __name__ == "__main__":

   logger.info('this is a info message')    # 记录日志记录的内容
   logger.debug('this is a debug message')
