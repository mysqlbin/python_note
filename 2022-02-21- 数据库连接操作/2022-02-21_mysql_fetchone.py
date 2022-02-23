import pymysql
import logging
import sys
# 利用fetchone一行行读取数据



logger = logging.getLogger('logger_test')  # 每行日志记录开头的名称
logger.setLevel(logging.INFO)  # 设置日志记录级别，把日志记录级别大于等于DEBUG的记录下来

BASIC_FORMAT = "%(name)s %(asctime)s %(filename)s:%(lineno)s %(levelname)s %(message)s"  # 设置日志记录的格式
DATE_FORMAT = "%Y-%m-%d %H:%M:%S"

formatter = logging.Formatter(BASIC_FORMAT, DATE_FORMAT)  # 设置日志记录的格式

fhlr = logging.FileHandler('example.log')  # 把日志写入到文件的handler
fhlr.setFormatter(formatter)
logger.addHandler(fhlr)    # 这个步骤不能少


def get_connect(host, user, passwd, db_name, charset):

    db = pymysql.connect(
        host=host,      # 主机名
        user=user,      # 用户名
        passwd=passwd,  # 密码
        db=db_name,     # 数据库名称
        charset=charset
    )
    cur = db.cursor()
    return cur

    # return db, cur

host = ""
user = "root"
passwd = "123456abc"
db_name = "test_db"
charset = "utf8mb4"

if __name__ == '__main__':

    # print(sys.version)
    # print(11111)

    try:

        cur = get_connect(host, user, passwd, db_name, charset)

        sql = "select * from trade_detail where id=10000"

        cur.execute(sql)

        data = cur.fetchone()

        print(type(data))
        print(data)

        # if data is None:
        #     print(222)

        if data is not None:
            print(222222)
        """
        查询到数据的场景
        <class 'tuple'>
        (1, 'aaaaaaaa', 1, 'add', '')
        
        查询不到数据的场景
        <class 'NoneType'>
        None       
        """


    except Exception as e:
        # 异常信息被自动添加到日志消息中
        # logger.debug(e)
        logger.exception(e)
        print(2222)
    # finally:
    #     cur.close()


    # 异常控制：就算上面的SQL语句执行异常了，代码还会继续往下走
    logger.info('this is a debug message')
