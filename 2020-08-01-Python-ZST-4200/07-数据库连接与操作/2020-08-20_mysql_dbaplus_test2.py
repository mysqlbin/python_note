# 抓取程序
import logging
import requests
from bs4 import BeautifulSoup
from bs4 import Tag
import MySQLdb

# 将beautifulsoap的Tag对象，解析成一个词典dict对象
def parse_activity_li(li):
    # 判断 li 是否是一个标签
    if not isinstance(li, Tag):
        return None  # 这里还不理解

    # 获取 active name 活动名称
    name_ele = li.select_one('.activ-text > .text > a')
    if name_ele is  None:
        return None  # 这里还不理解
    activity_name = name_ele.get_text().strip()

    # 获取日期和形式
    date_div = li.find(class_="date")
    if date_div is None:
        return None  # 这里还不理解

    span_list = date_div.find_all('span')
    if span_list is None or len(span_list) != 2:
        return None    # 这里还不理解

    time_splits = span_list[0].get_text().strip()
    # print('活动时间：{}'.format(time_splits.split("：")[1]))

    style_splits = span_list[1].get_text().strip()
    # print('活动形式：{}'.format(style_splits.split("：")[1]))

    dict_data = {
        'activity_name': activity_name,
        'hold_name': time_splits.split("：")[1],
        'active_style': style_splits.split("：")[1]
    }
    return dict_data



if __name__ == '__main__':

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

    for li in list_group.children:

        if li.name != "li":
            continue

        activity = parse_activity_li(li)
        if activity is None:
            continue

        print(activity['activity_name'])

        # logging.debug("activity name: %s", activity['activity_name'])


