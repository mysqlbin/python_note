

import requests
import json

if __name__ == "__main__":


   # host = "https://5f4ca835ea007b0016b1e3f5.mockapi.io/article"
   # resp = requests.post(host)
   # print(resp.text)


   host = "https://5f4ca835ea007b0016b1e3f5.mockapi.io/article"
   resp = requests.get(host)
   print(resp.text)  # 读取返回的数据