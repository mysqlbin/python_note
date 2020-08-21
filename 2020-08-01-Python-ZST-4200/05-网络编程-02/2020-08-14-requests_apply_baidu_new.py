#coding=utf-8

import requests
from bs4 import BeautifulSoup

if __name__ == "__main__":

    links = requests.get('https://news.baidu.com/')
    # links.encoding = 'utf-8'
    # print(type(links.text))
    # print(links.text)
    s = BeautifulSoup(links.text, 'html.parser')
    # print(s)
    # for item in s.select('.hotnews > ul > li > strong > a'):
    #     with open('20200814_baidu_new.sql', 'a', encoding='utf-8') as f:
    #         f.write('title: {}, href: {}, \n'.format(item.string.strip(),  item['href']))
    #
    #
    # for item in s.select('.mod-tab-content > div > ul > li > a'):
    #     print(item)
    #     with open('20200814_baidu_new.sql', 'a', encoding='utf-8') as f:
    #         f.write('title: {}, href: {}, \n'.format(item.string.strip(),  item['href']))


    new_content = s.select_one('.mod-tab-content')
    # print(new_content)

    hotnews = new_content.select('.hotnews > ul > li > strong > a')

    if hotnews is not None:
        for item in hotnews:
            if item is not None:
                print(item.get_text().strip())

    general_news = new_content.select('.mod-tab-content > div > ul > li > a')
    if general_news is not None:
        for item in general_news:
            if item is not None:
                print(item.get_text().strip())

