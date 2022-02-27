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
passwd = ""
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

        sql = "select GROUP_CONCAT(`step_info` SEPARATOR ',') from trade_detail where tradeid='333'"

        cur.execute(sql)

        print("rowcount: {}".format(cur.rowcount))

        data = cur.fetchone()

       
        print(type(data))
        print(data)

        # if data is None:
        #     print(222)

        if data is not None:
            print(222222)
        """
        返回的数据格式为元组
        查询所有的字段 并且查询语句只查询一行记录：select * from trade_detail where id=1
        查询到数据的场景
        <class 'tuple'>
        (1, 'aaaaaaaa', 1, 'add', '')
        
        查询不到数据的场景
        <class 'NoneType'>
        None       
        
        查询2个字段 并且查询语句只查询一行记录: ：select id,aaaaaaaa from trade_detail where id=1
        查询到数据的场景
        <class 'tuple'>
        (1, 'aaaaaaaa')

        查询不到数据的场景
        <class 'NoneType'>
        None       
        
        .....................................................................

        查询语句可以查询到多行记录，但是只取一行
        sql = "select id,tradeid from trade_detail where tradeid='aaaaaaad'"
        <class 'tuple'>
        (9, 'aaaaaaad')

        查询语句有 sum 聚合，并且是查询2个字段
            select sum(trade_step),sum(id) from trade_detail where tradeid='aaaaaaad'

            查询到数据的场景
            rowcount: 1
            <class 'tuple'>
            (Decimal('33'), Decimal('30'))

            查询不到数据的场景
            rowcount: 1
            <class 'tuple'>
            (None, None)

        查询语句有 GROUP_CONCAT
            查询到数据的场景
            select GROUP_CONCAT(`step_info` SEPARATOR ',') from trade_detail where tradeid='aaaaaaad'
            rowcount: 1
            <class 'tuple'>
            ('commit,commit,commit',)

            查询不到数据的场景
            select GROUP_CONCAT(`step_info` SEPARATOR ',') from trade_detail where tradeid='333'            
            rowcount: 1
            <class 'tuple'>
            (None,)
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
