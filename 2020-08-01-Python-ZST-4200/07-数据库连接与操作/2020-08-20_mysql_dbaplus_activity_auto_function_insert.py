# 抓取和数据库插入程序
import logging
import requests
from bs4 import BeautifulSoup
from bs4 import Tag
import MySQLdb


# 将beautifulsoap的Tag对象，解析成一个词典dict对象
def parse_activity_li(li):
    # 判断 li 是否是一个标签
    if not isinstance(li, Tag):
        return None

    # 获取 active name 活动名称
    name_ele = li.select_one('.activ-text > .text > a')
    if name_ele is None:
        return None
    activity_name = name_ele.get_text().strip()

    # 获取日期和形式
    date_div = li.find(class_="date")
    if date_div is None:
        return None

    span_list = date_div.find_all('span')
    if span_list is None or len(span_list) != 2:
        return None
    # 获取日期
    time_splits = span_list[0].get_text().strip()
    # 获取活动形式
    style_splits = span_list[1].get_text().strip()

    dict_data = {
        'activity_name': activity_name,
        'hold_time': time_splits.split("：")[1],
        'form': style_splits.split("：")[1]
    }

    return dict_data


if __name__ == '__main__':

    host = "192.168.0.242"
    user = "ljb_user"
    passwd = "123456abc"
    db_name = "test_db"
    charset = "utf8mb4"
    # 这里要也要加异常控制
    db = MySQLdb.connect(
        host=host,  # 主机名
        user=user,  # 用户名
        passwd=passwd,  # 密码
        db=db_name,  # 数据库名称
        charset=charset
    )

    # db.autocommit(True)

    cur = db.cursor()

    logging.basicConfig(level=logging.DEBUG, format="%(asctime)s %(levelname)s %(message)s")

    resp = requests.get("https://dbaplus.cn/")
    if resp.status_code >= 300:
        logging.error("failed to make a request to dbaplus, status_code: %d", resp.status_code)
        exit(1)

    soup = BeautifulSoup(resp.text, 'html.parser')
    # 拿到 ul class="list-group"> .....  </ul> 标签列表
    list_group = soup.select_one('.list-group')
    # print(list_group)
    if list_group is None:
        logging.error("failed to get list-group")
        exit(1)

    count = 0
    for li in list_group.children:
        # li.name 表示获取 标签名称
        if li.name != "li":
            continue

        activity = parse_activity_li(li)
        if activity is None:
            continue

        print(activity['activity_name'])
        print(tuple([activity["activity_name"]]))
        print("select 1 from t_activity where activity_name = '%s'", tuple([activity['activity_name']]))
        cur.execute("select 1 from t_activity where activity_name = %s", tuple([activity["activity_name"]]))
        # print("select 1 from t_activity where activity_name='{}'".format(activity['activity_name']))
        # cur.execute("select 1 from t_activity where activity_name='{}'".format(activity['activity_name']))

        print("select 1 from t_activity where activity_name = %(activity_name)s", activity)
        cur.execute("select 1 from t_activity where activity_name= %(activity_name)s", activity)


        if cur.rowcount > 0:
            continue  # continue：让程序跳出当前这层循环，继续执行下面的循环（终止此次循环，整个while循环则继续）；

        print(type(activity))
        cur.execute("insert into t_activity values (null, %(activity_name)s, %(hold_time)s, %(form)s)", activity)    # 参数化，不需要拼接SQL语句。

        count += 1
        print(count)

    db.commit()
    logging.info("Insert %d rows", count)
    """
        非自动提交
            2020-08-21T10:48:18.036629+08:00	31885 Query	SET autocommit=0
            --                                              select 1 from t_activity where activity_name='%s' ('“T-Live产业互联系列直播”| 金融专场',)
            2020-08-21T10:48:18.698993+08:00	31885 Query	select 1 from t_activity where activity_name = '2020 DAMS中国数据智能管理峰会-上海站'
            2020-08-21T10:48:18.700377+08:00	31885 Query	insert into t_activity values (null, '2020 DAMS中国数据智能管理峰会-上海站', '2020-10-30', '线下峰会')
            ..........................................................................................................................................
            2020-08-21T10:48:18.738799+08:00	31885 Query	select 1 from t_activity where activity_name = '云加社区沙龙online'
            2020-08-21T10:48:18.740148+08:00	31885 Query	insert into t_activity values (null, '云加社区沙龙online', '2020-07-28', '线上分享')
            2020-08-21T10:48:18.740952+08:00	31885 Query	COMMIT
        
        db.autocommit(True)  # 自动提交模式
            2020-08-21T10:46:34.488609+08:00	31879 Query	SET autocommit=0
            2020-08-21T10:46:34.489094+08:00	31879 Query	SET autocommit=1
            2020-08-21T10:46:35.136128+08:00	31879 Query	select 1 from t_activity where activity_name = '2020 DAMS中国数据智能管理峰会-上海站'
            2020-08-21T10:46:35.137553+08:00	31879 Query	insert into t_activity values (null, '2020 DAMS中国数据智能管理峰会-上海站', '2020-10-30', '线下峰会')
            ..........................................................................................................................................
            2020-08-21T10:46:36.139771+08:00	31879 Query	select 1 from t_activity where activity_name = '云加社区沙龙online'
            2020-08-21T10:46:36.140738+08:00	31879 Query	insert into t_activity values (null, '云加社区沙龙online', '2020-07-28', '线上分享')
        
    """
