import MySQLdb
import logging




# host = "192.168.1.27"
# user = "root"
# passwd = "123456abc"
# db_name = "zst"
# charset = "utf8mb4"

logger = logging.getLogger('logger_test')  # 每行日志记录开头的名称
logger.setLevel(logging.DEBUG)  # 设置日志记录级别，把日志记录级别大于等于DEBUG的记录下来

BASIC_FORMAT = "%(name)s %(asctime)s %(filename)s:%(lineno)s %(levelname)s %(message)s"  # 设置日志记录的格式
DATE_FORMAT = "%Y-%m-%d %H:%M:%S"

formatter = logging.Formatter(BASIC_FORMAT, DATE_FORMAT)  # 设置日志记录的格式

fhlr = logging.FileHandler('example.log')  # 把日志写入到文件的handler
fhlr.setFormatter(formatter)
logger.addHandler(fhlr)    # 这个步骤不能少

if __name__ == '__main__':

    logger.debug('this is a debug message')

    # db = MySQLdb.connect(
    #     host=host,      # 主机名
    #     user=user,      # 用户名
    #     passwd=passwd,  # 密码
    #     db=db_name,     # 数据库名称
    #     charset=charset
    # )
    #
    # cur = db.cursor()
    # try:
    #     cur.execute("select * from t_activity1 ")
    #     # 也可以使用fetchmany获取指定数量的行数
    #     # print(conn.fetchmany(10))
    #     if cur.rowcount == 0:
    #         print("No result found")
    #     else:
    #         for row in cur.fetchall():
    #             print(row)
    # except Exception as e:
    #     # 异常信息被自动添加到日志消息中
    #
    #     logger.exception(e)
    #     print(e)
    #     # logger.exception(e)
    #     db.rollback()
    # finally:
    #     cur.close()
    #     db.close()