import pymysql
import logging
import sys

host = "101.37.253.14"
user = "root"
passwd = ""
db_name = "test_db"
charset = "utf8mb4"



def execute(db_name=None, sql=''):

    conn = get_connection(db_name=db_name)
    try:
        cursor = conn.cursor()
        cursor.execute(statement)
        conn.commit()
        cursor.close()
    except Exception as e:
        logger.warning(f"MySQL语句执行报错，语句：{sql}，错误信息{traceback.format_exc()}")
        result.error = str(e)
    if close_conn:
        self.close()
    return result

def get_connection(self, db_name=None):
    conn = pymysql.connect(
        host=host,  # 主机名
        user=user,  # 用户名
        passwd=passwd,  # 密码
        db=db_name,  # 数据库名称
        charset=charset
    )
    return conn


if __name__ == '__main__':

    # print(sys.version)
    # print(11111)

    try:

        cur = get_connect(host, user, passwd, db_name, charset)

        sql = "select * from trade_detail where tradeid='aaaaaaad'"

        cur.execute(sql)

        print("rowcount: {}".format(cur.rowcount))

        data = cur.fetchall()

        print("type(data): {}".format(type(data)))
        print("data: {}".format(data))

        for i in data:
            print("取二维元组的一维元组: {}".format(i))     
            print("取二维元组的一维元组的第1个元素: {}".format(i[0])) 
            print("取二维元组的一维元组的第2个元素: {}".format(i[1]))  
       

        if data is not None:
            print(222222)
        
        """
        返回的数据格式为元组
        查询到数据的场景
            select * from trade_detail where tradeid='aaaaaaad'
            rowcount: 3
            type(data): <class 'tuple'>
            data: ((9, 'aaaaaaad', 11, 'commit', ''), (10, 'aaaaaaad', 11, 'commit', ''), (11, 'aaaaaaad', 11, 'commit', ''))
            取二维元组的一维元组: (9, 'aaaaaaad', 11, 'commit', '')
            取二维元组的一维元组的第1个元素: 9
            取二维元组的一维元组的第2个元素: aaaaaaad
            取二维元组的一维元组: (10, 'aaaaaaad', 11, 'commit', '')
            取二维元组的一维元组的第1个元素: 10
            取二维元组的一维元组的第2个元素: aaaaaaad
            取二维元组的一维元组: (11, 'aaaaaaad', 11, 'commit', '')
            取二维元组的一维元组的第1个元素: 11
            取二维元组的一维元组的第2个元素: aaaaaaad
            
        查询不到数据的场景
            rowcount: 0
            type(data): <class 'tuple'>
            data: ()

        """


    except Exception as e:
        # 异常信息被自动添加到日志消息中
        # logger.debug(e)
        logger.exception(e)
        print(e)
    # finally:
    #     cur.close()


    # 异常控制：就算上面的SQL语句执行异常了，代码还会继续往下走
    logger.info('this is a debug message')
