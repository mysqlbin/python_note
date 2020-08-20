
from selenium import webdriver
import time

if __name__ == "__main__":

   # browser_for_login 为正常浏览器，用于登录
   browser_for_login = webdriver.Chrome()

   browser_for_login.get("https://passport.jd.com/new/login.aspx")

   while browser_for_login.current_url != 'https://www.jd.com/':
      time.sleep(2)

   print("login")

   browser_for_login.get("https://cart.jd.com/cart.action")

   time.sleep(2)

   browser_for_login.page_source

   for item in browser_for_login.find_elements_by_css_selector('.goods-item'):
      print(item.find_element_by_tag_name('a'))

      for a_item in item.find_elements_by_tag_name('a'):
         print(a_item.text)

   browser_for_login.close()


   """
   print(item.find_element_by_tag_name('a'))
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="ba973f46-bd7d-4c32-acd4-38221f33f879")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="96940b2f-6aba-4f19-84df-e9127ef66f01")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="a952193a-3f23-413c-ad9b-2c28c5c70c2f")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="a3b5aa49-5aec-4f79-b88d-1d36d787e067")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="5c786120-6bdd-456e-aa9a-5f59bdb8aa75")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="ea894e0a-ecfc-4bca-a84f-1fc74e123225")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="434b0521-3e4a-4c98-ae32-e04c18255cc9")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="e22883b4-461f-42ed-b5ad-61fd39b94585")>
      <selenium.webdriver.remote.webelement.WebElement (session="012db71190b8e17cfe15b2420e713310", element="f3b14188-f8c3-418c-933f-f33b7a6d64cc")>
      
      
      
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="69e5c75b-0210-4294-8789-d4b10abe5efa")>
   
   【2提装】认养一头牛 全脂纯牛奶 250ml*12盒*2箱儿童学生成人营养早餐纯奶整箱 两提装
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="6fb8e13b-a5fa-4ee9-a519-244dbb8e0596")>
   
   美的（Midea）波轮洗衣机全自动 8公斤 专利免清洗十年桶如新 10分钟快洗 DIY自编程 MB80V31
   选服务
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="df9053e6-fd60-45e7-8782-bc3ae83dbb62")>
   
   美的（Midea）电饭煲电饭锅3L迷你电饭煲24小时预约微压蒸汽阀黄晶内胆家用电饭煲MB-WFS3018Q
   选服务
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="b2e53249-261f-4add-89d3-109fff02518e")>
   
   美的（Midea）电压力锅 4升小容量旋钮控制电高压锅W12PCH402E（李现推荐）
   选服务
   礼品包装
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="e00a790e-ef6e-4225-a76a-9ac62c979a96")>
   
   男人来自火星，女人来自金星（套装共4册）（升级版）
   选服务
   礼品包装
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="96aa1921-8f44-4a34-901e-1247677b65da")>
   
   MySQL运维内参：MySQL、Galera、Inception核心原理与最佳实践(博文视点出品)
   选服务
   礼品包装
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="e30183e1-fe45-4c3f-ad46-c1082e4f3e0c")>
   
   公牛（BULL）新国标插座套装/插线板/插排/排插/接线板/拖线板 GN-B3440+GN-B3220 8位+4位 1.8米组合套装
   选服务
   礼品包装
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="d3019681-5a98-415e-b63e-f2d96f14d32c")>
   
   美的（Midea）炒锅 厚底匀热无烟多用不粘平底锅 燃磁通用 32CM口径 CL32T1
   选服务
   <selenium.webdriver.remote.webelement.WebElement (session="d2ae9ca8c01d64cd566f23174f5e0f87", element="8687511f-7f0b-4e66-87c3-03a0e0c1dcc2")>
   
   浪莎袜子女纯棉中筒袜秋季款吸汗防臭全棉运动女士袜子 掌柜推荐款--五色6双 100%棉秋季女袜


   """