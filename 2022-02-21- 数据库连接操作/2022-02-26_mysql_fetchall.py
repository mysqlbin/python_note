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

host = "101.37.253.14"
user = "root"
passwd = "123456abc"
db_name = "test_db"
charset = "utf8mb4"

"""

CREATE TABLE `trade_detail` (
  `id` int(11) NOT NULL,
  `tradeid` varchar(32) NOT NULL,
  `trade_step` tinyint(4) NOT NULL,
  `step_info` varchar(32) NOT NULL,
  `step_data` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_tradeid_step_info_trade_step` (`tradeid`,`step_info`,`trade_step`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('1', 'aaaaaaaa', '1', 'add', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('2', 'aaaaaaaa', '2', 'update', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('3', 'aaaaaaaa', '3', 'commit', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('4', 'aaaaaaab', '6', 'add', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('5', 'aaaaaaab', '7', 'update', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('6', 'aaaaaaab', '8', 'update again', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('7', 'aaaaaaab', '9', 'commit', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('8', 'aaaaaaac', '10', 'add', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('9', 'aaaaaaad', '11', 'commit', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('10', 'aaaaaaad', '11', 'commit', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('11', 'aaaaaaad', '11', 'commit', '');


mysql> select * from trade_detail;
+----+----------+------------+--------------+-----------+
| id | tradeid  | trade_step | step_info    | step_data |
+----+----------+------------+--------------+-----------+
|  1 | aaaaaaaa |          1 | add          |           |
|  2 | aaaaaaaa |          2 | update       |           |
|  3 | aaaaaaaa |          3 | commit       |           |
|  4 | aaaaaaab |          6 | add          |           |
|  5 | aaaaaaab |          7 | update       |           |
|  6 | aaaaaaab |          8 | update again |           |
|  7 | aaaaaaab |          9 | commit       |           |
|  8 | aaaaaaac |         10 | add          |           |
|  9 | aaaaaaad |         11 | commit       |           |
| 10 | aaaaaaad |         11 | commit       |           |
| 11 | aaaaaaad |         11 | commit       |           |
+----+----------+------------+--------------+-----------+
11 rows in set (0.00 sec)

"""

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
