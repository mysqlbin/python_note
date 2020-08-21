import MySQLdb
import logging

# 执行sql并获取内容

host = "192.168.0.242"
user = "ljb_user"
passwd = "123456abc"
db_name = "test_db"
charset = "utf8mb4"

import string
import random

if __name__ == '__main__':

    # 这里要也要加异常控制
    db = MySQLdb.connect(
        host=host,      # 主机名
        user=user,      # 用户名
        passwd=passwd,  # 密码
        db=db_name,     # 数据库名称
        charset=charset
    )

    lists = random.sample(string.ascii_letters + string.digits, 8)

    # ['h', 'G', 'p', 'd', '9', 'O', 'K', 'w']
    strs = "".join(lists)

    print(type(strs))
    print(strs)

    cur = db.cursor()
    try:
        for i in range(3):
            salt = ''.join(random.sample(string.ascii_letters + string.digits, 8))
            cur.execute("INSERT INTO t_activity VALUES (null, %s, Now(), %s)", (salt, salt))
        db.commit()  # 一定需要commit()


    except Exception as e:
        # 异常信息被自动添加到日志消息中
        # logger.debug(e)
        print(e)
        # print(e)
        db.rollback()
    finally:
        cur.close()
        db.close()

    # 异常控制：就算上面的SQL语句执行异常了，代码还会继续往下走

