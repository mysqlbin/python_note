from selenium import webdriver
import time

if __name__ == "__main__":

   webbrowser = webdriver.Chrome()
   webbrowser.get("https://news.baidu.com/")
   time.sleep(2)
   print(webbrowser.page_source)     # 返回‘https://news.baidu.com/’这个网页的源代码
   webbrowser.close()

