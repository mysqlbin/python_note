# 抓取程序
import logging
import requests
from bs4 import BeautifulSoup
from bs4 import Tag
import MySQLdb


# 将beautifulsoap的Tag对象，解析成一个词典dict对象
def parse_activity_li(li):
    if not isinstance(li, Tag):
        return None

    name_ele = li.select_one(".activ-text > .text > a")
    if name_ele is None:
        return None

    date_div = li.find(class_="date")
    if date_div is None:
        return None

    span_list = date_div.find_all('span')
    if span_list is None or len(span_list) != 2:
        return None

    form_text = span_list[1].get_text().strip()
    form_splits = form_text.partition("：")
    if len(form_splits) != 3:
        return None

    time_text = span_list[0].get_text().strip()
    time_splits = time_text.partition("：")
    if len(time_splits) != 3:
        return None

    return {
        "activity_name": name_ele.get_text().strip(),
        "hold_time": time_splits[2].strip(),
        "form": form_splits[2].strip()
    }


if __name__ == '__main__':
    # print("【".encode('utf-8'))
    # # 至少得把日志记录到文件
    # logging.basicConfig(level=logging.DEBUG, format="%(asctime)s %(levelname)s %(message)s")
    #
    # host = "localhost"
    # user = "root"
    # passwd = "rxy123456"
    # db_name = "zst"
    # charset = "utf8mb4"
    #
    # db = MySQLdb.connect(
    #     host=host,  # 主机名
    #     user=user,  # 用户名
    #     passwd=passwd,  # 密码
    #     db=db_name,
    #     charset=charset)  # 数据库名称
    #
    # cur = db.cursor()

    resp = requests.get("https://dbaplus.cn/")
    if resp.status_code >= 300:
        logging.error("failed to make a request to dbaplus, status_code: %d", resp.status_code)
        exit(1)

    soup = BeautifulSoup(resp.text, 'html.parser')
    list_group = soup.select_one('.list-group')
    if list_group is None:
        logging.error("failed to get list-group")
        exit(1)

    count = 0
    for li in list_group.children:
        if li.name != "li":
            continue
        # print(li.name)
        activity = parse_activity_li(li)
        if activity is None:
            continue

    #     print(type(activity))
        print(activity)
    #     logging.debug("activity name: %s", activity['activity_name'])
    #     cur.execute("select * from t_activity where activity_name = %s", tuple([activity["activity_name"]]))
    #     logging.debug("last execute: %s", cur._last_executed)
    #     logging.debug("Row_count1: %d", cur.rowcount)
    #
    #     if cur.rowcount > 0:
    #         continue
    #
    #     cur.execute("insert into t_activity values (null, %(activity_name)s, %(hold_time)s, %(form)s)", activity)
    #     count += 1
    #
    # db.commit()
    # logging.info("Insert %d rows", count)