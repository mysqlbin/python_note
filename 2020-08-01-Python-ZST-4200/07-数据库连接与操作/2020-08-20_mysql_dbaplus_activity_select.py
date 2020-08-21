# 查询程序，不需要手工拼接SQL
import MySQLdb
import argparse
import logging
from datetime import date

if __name__ == '__main__':
    argument_parser = argparse.ArgumentParser(description="DBAPLUS活动查询")
    argument_parser.add_argument("-n", "--name", help="名称")
    group = argument_parser.add_mutually_exclusive_group()
    group.add_argument("-t", "--time", nargs=2, help="查询该时间之后的")
    group.add_argument("-a", "--all", help="是否返回", action="store_true")
    argument_parser.add_argument("-d", "--debug", help="debugg", action="store_true")
    args = argument_parser.parse_args()

    if args.debug is True:
        logging.basicConfig(level=logging.DEBUG)
    else:
        logging.basicConfig(level=logging.INFO)

    host = "192.168.0.242"
    user = "ljb_user"
    passwd = "123456abc"
    db_name = "test_db"
    charset = "utf8mb4"


    db = MySQLdb.connect(
        host=host,
        user=user,
        passwd=passwd,
        db=db_name,
        charset=charset)

    sql = "select * from t_activity"
    # 用于存储where条件
    where_condition = []
    # 用来存储参数值
    params_values = []
    # 如果时间参数为空的话， 默认要打印还没有举行的活动
    if args.time is None:
        # 如果all参数也为空的话
        if args.all is False:
            where_condition.append("hold_time >= Now()")
    else:
        # 用户指定了查询指定时间段的活动
        where_condition.append("hold_time >= %s")
        where_condition.append("hold_time <= %s")
        params_values.append(args.time[0])
        params_values.append(args.time[1])

    if args.name is not None:
        where_condition.append("activity_name like %s")
        params_values.append("%" + args.name + "%")

    print(where_condition)
    print(len(where_condition))
    # ['hold_time >= %s', 'hold_time <= %s']
    print(params_values)
    print(type(params_values))
    print(tuple(params_values))
    print(type(tuple(params_values)))
    # ['2020-02-21', '2020-10-21', '%2020GIAC全球互联网架构大会%']
    # ('2020-02-21', '2020-10-21', '%2020GIAC全球互联网架构大会%')

    # 拼接SQL语句
    if len(where_condition) > 0:
        sql += " where "
        for i in range(len(where_condition)):
            if i > 0:
                sql += " and "
            sql += where_condition[i]

    try:
        cur = db.cursor()
        logging.debug("Execute sql: %s", sql)
        logging.debug("params: %s", params_values)
        cur.execute(sql, tuple(params_values))
        if cur.rowcount == 0:
            print("No activity found")
        else:
            for row in cur.fetchall():
                print(row)
    except Exception as e:
        logging.exception(e)
        db.rollback()
    finally:
        db.close()