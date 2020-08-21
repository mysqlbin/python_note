
from selenium import webdriver
import time

if __name__ == "__main__":

   # browser_for_login 为正常浏览器，用于登录
   browser_for_login = webdriver.Chrome()

   browser_for_login.get("https://www.smzdm.com/")

   print('0')

   time.sleep(3)

   # 触发点击登录按钮
   browser_for_login.find_element_by_css_selector('.J_login_trigger').click()

   print('1')

   # 这里的时间设置得长一点，避免登录操作慢，导致获取不到签到按钮
   time.sleep(15)

   print('2')

   # 触发签到按钮
   browser_for_login.find_element_by_css_selector('.J_punch').click()

   print('3')

   # 关闭浏览器
   browser_for_login.close()


   """
      selenium.common.exceptions.ElementClickInterceptedException: Message: element click intercepted: Element <a href="javascript:void(0);" class="J_punch">...</a> is not clickable at point (1424, 351). Other element would receive the click: <div class="popup-bg" onclick="dataLayer.push({&quot;event&quot;:&quot;首页_半透明区域&quot;})" _hover-ignore="1"></div>
     (Session info: chrome=83.0.4103.106)
   """