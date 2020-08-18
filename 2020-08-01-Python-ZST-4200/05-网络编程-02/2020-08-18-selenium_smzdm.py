
from selenium import webdriver
import time

if __name__ == "__main__":

   # browser_for_login 为正常浏览器，用于登录
   browser_for_login = webdriver.Chrome()

   browser_for_login.get("https://www.smzdm.com/")

   print('0')

   browser_for_login.page_source

   time.sleep(2)

   print('1')

   browser_for_login.find_element_by_css_selector('.J_login_trigger').click()

   print('2')

   time.sleep(30)

   print('3')

   browser_for_login.find_element_by_css_selector('.J_punch').click()

   print('4')

   browser_for_login.close()


   """
      selenium.common.exceptions.ElementClickInterceptedException: Message: element click intercepted: Element <a href="javascript:void(0);" class="J_punch">...</a> is not clickable at point (1424, 351). Other element would receive the click: <div class="popup-bg" onclick="dataLayer.push({&quot;event&quot;:&quot;首页_半透明区域&quot;})" _hover-ignore="1"></div>
     (Session info: chrome=83.0.4103.106)
   """