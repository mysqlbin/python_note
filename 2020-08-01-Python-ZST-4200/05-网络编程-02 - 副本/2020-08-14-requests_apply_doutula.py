#coding=utf-8

import requests
from bs4 import BeautifulSoup

if __name__ == "__main__":

    links = requests.get('https://www.doutula.com/')
    # links.encoding = 'utf-8'
    print(type(links.text))
    print(links.text)
    s = BeautifulSoup(links.text, 'html.parser')
    print(s)
    for item in s.select('.pic-content > div > a > img'):
        print(item)
        if item is not None and item.has_attr('data-original'):
            print(item['data-original'])
            # print(item['data-original'])
            # print(item.string.strip())
            # with open('20200814_database_Kernel.sql', 'a', encoding='utf-8') as f:
            #     f.write('href: {}, title: {} \n'.format( item['href'], item.string.strip()))