# 抓取程序
import logging
import requests
from bs4 import BeautifulSoup
from bs4 import Tag
import MySQLdb

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
        name_ele = li.select_one('.activ-text > .text > a')
        # print(name_ele)
        if name_ele is not None:
            # print(name_ele)
            # print(name_ele.string.strip())
            active_name = name_ele.get_text().strip()
            # print(active_name)

        date_div = li.find(class_="date")

        if date_div is not None:
            print('None')
            # print(date_div)

        span_list = date_div.find_all('span')
        # print(span_list)
        # print(len(span_list))

        if span_list is None or len(span_list) != 2:
            print('None')

        time_splits = span_list[0].get_text().strip()

        # print(time_splits.split("：")[1])

        style_splits = span_list[1].get_text().strip()

        print(style_splits.split("：")[1])
            # date_span = date_div.select_one('span').get_text().strip()
            # time_splits = date_span.split("：")[1]

