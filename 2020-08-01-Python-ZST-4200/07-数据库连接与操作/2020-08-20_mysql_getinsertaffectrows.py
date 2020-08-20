import MySQLdb
import logging

# 获取数据插入的自增ID和DML操作影响的行数

host = "192.168.0.242"
user = "ljb_user"
passwd = "123456abc"
db_name = "test_db"
charset = "utf8mb4"

logger = logging.getLogger('logger_test')  # 每行日志记录开头的名称
logger.setLevel(logging.INFO)  # 设置日志记录级别，把日志记录级别大于等于DEBUG的记录下来

BASIC_FORMAT = "%(name)s %(asctime)s %(filename)s:%(lineno)s %(levelname)s %(message)s"  # 设置日志记录的格式
DATE_FORMAT = "%Y-%m-%d %H:%M:%S"

formatter = logging.Formatter(BASIC_FORMAT, DATE_FORMAT)  # 设置日志记录的格式

fhlr = logging.FileHandler('example.log')  # 把日志写入到文件的handler
fhlr.setFormatter(formatter)
logger.addHandler(fhlr)    # 这个步骤不能少

if __name__ == '__main__':

    # 这里要也要加异常控制
    db = MySQLdb.connect(
        host=host,      # 主机名
        user=user,      # 用户名
        passwd=passwd,  # 密码
        db=db_name,     # 数据库名称
        charset=charset
    )

    cur = db.cursor()
    try:
        r = cur.execute("INSERT INTO`t_activity` (`activity_name`, `hold_time`, `form`) VALUES ('e', now(), 'c'), ('f', now(), 'd');")
        # 也可以使用fetchmany获取指定数量的行数
        # print(conn.fetchmany(10))
        # 获取插入行的自增ID, 针对单行记录有效
        print("lastrowid: " + str(cur.lastrowid))
        # 影响了几行
        print("update row: " + str(r))

        db.commit()  # 一定需要commit(),否则不会自动提交

    except Exception as e:
        # 异常信息被自动添加到日志消息中
        # logger.debug(e)
        logger.exception(e)
        # print(e)
        db.rollback()
    finally:
        cur.close()
        db.close()

    # 异常控制：就算上面的SQL语句执行异常了，代码还会继续往下走

    logger.info('this is a debug message')
