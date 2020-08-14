#coding=utf-8

import requests
from bs4 import BeautifulSoup

if __name__ == "__main__":
    web_url = 'http://mysql.taobao.org'
    links = requests.get('http://mysql.taobao.org/monthly/2020/06/')
    links.encoding = 'utf-8'
    print(type(links.text))
    s = BeautifulSoup(links.text, 'html.parser')

    for item in s.select('.posts > li > h3 > a'):
        print(item['href'])
        print(item.string.strip())
        with open('20200814_database_Kernel.sql', 'a', encoding='utf-8') as f:
            f.write('href: {}{}, title: {} \n'.format(web_url, item['href'], item.string.strip()))