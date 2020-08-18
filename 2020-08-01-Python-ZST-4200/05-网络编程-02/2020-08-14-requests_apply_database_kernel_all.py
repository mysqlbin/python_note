#coding=utf-8

import requests
from bs4 import BeautifulSoup

if __name__ == "__main__":

    web_url = 'http://mysql.taobao.org'
    links = requests.get('http://mysql.taobao.org/monthly/')
    links.encoding = 'utf-8'
    print(type(links.text))
    s = BeautifulSoup(links.text, 'html.parser')

    for item in s.select('.posts > li > h3 > a'):
        # print(item['href'])
        # print(item.string.strip())
        with open('20200814_database_Kernel_detail.sql', 'a', encoding='utf-8') as f:
            print(item['href'])
            # f.write('href: {}{}, title: {} \n'.format(web_url, item['href'], item.string.strip()))
            f.write('{}\n'.format(item.string.strip()))

            links_detail = requests.get('{}{}'.format(web_url, item['href']))
            links_detail.encoding = 'utf-8'
            # print(type(links.text))
            str_detail = BeautifulSoup(links_detail.text, 'html.parser')
            # print(type(str_detail))
            for item_detail in str_detail.select('.posts > li > h3 > a'):
                print(item_detail['href'])
                # print(item_detail.string.strip())
                with open('20200814_database_Kernel_detail.sql', 'a', encoding='utf-8') as f:
                    f.write('  href: {}{} title: {} \n'.format(web_url, item_detail['href'], item_detail.string.strip()))

