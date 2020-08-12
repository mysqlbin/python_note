import requests

if __name__ == "__main__":

   """ 0. get 请求 """

   """
   host = "http://httpbin.org/"
   resp = requests.get(host + "/get")
   print(resp.text)
   """

   """
      {
        "args": {},
        "headers": {
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate",
          "Host": "httpbin.org",
          "User-Agent": "python-requests/2.24.0",   # 标识由哪个程序发出请求
          "X-Amzn-Trace-Id": "Root=1-5f33b624-d0b086b6de53ddc4f50cfab6"
        },
        "origin": "121.35.189.165",
        "url": "http://httpbin.org/get"
      }
   """

   """ 1. get 请求 """

   """
   host = "http://httpbin.org/"
   headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36'
   }
   resp = requests.get(host + "/get", headers=headers)
   print(resp.text)
   """
   """
      
      {
        "args": {}, 
        "headers": {
          "Accept": "*/*", 
          "Accept-Encoding": "gzip, deflate", 
          "Host": "httpbin.org", 
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36", 
          "X-Amzn-Trace-Id": "Root=1-5f33b874-a0ed9ba8e4dd2c8ee7667479"
        }, 
        "origin": "121.35.189.165", 
        "url": "http://httpbin.org/get"
      }
   """

   """ 2. post请求： 表单 """

   """
   host = "http://httpbin.org/"
   headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36'
   }
   data = {
      'username': 'mysqlbin',
      'password': 'guangdong',
   }
   resp = requests.post(host + "/post", headers=headers, data=data)
   print(resp.text)
   """

   """
      {
        "args": {}, 
        "data": "", 
        "files": {}, 
        "form": {
          "password": "guangdong", 
          "username": "mysqlbin"
        }, 
        "headers": {
          "Accept": "*/*", 
          "Accept-Encoding": "gzip, deflate", 
          "Content-Length": "36", 
          "Content-Type": "application/x-www-form-urlencoded",     # 表单
          "Host": "httpbin.org", 
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36", 
          "X-Amzn-Trace-Id": "Root=1-5f33b9cb-e3bc2680236e0300165b8300"
        }, 
        "json": null, 
        "origin": "121.35.189.165", 
        "url": "http://httpbin.org/post"
      }

   """


   """ 3. post请求： json """

   """
   host = "http://httpbin.org/"
   headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36',
      "Content-Type": "application/json"
   }
   data = {
      'username': 'mysqlbin',
      'password': 'guangdong',
   }
   resp = requests.post(host + "/post", headers=headers, data=data)
   print(resp.text)
   """
   """
   {
     "args": {}, 
     "data": "username=mysqlbin&password=guangdong", 
     "files": {}, 
     "form": {}, 
     "headers": {
       "Accept": "*/*", 
       "Accept-Encoding": "gzip, deflate", 
       "Content-Length": "36", 
       "Content-Type": "application/json",     # json
       "Host": "httpbin.org", 
       "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36", 
       "X-Amzn-Trace-Id": "Root=1-5f33bb3f-869e74626475da9e2a563262"
     }, 
     "json": null, 
     "origin": "121.35.189.165", 
     "url": "http://httpbin.org/post"
   }
   """

   """ 4. get请求： 传参数 """

   host = "http://httpbin.org/"
   headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36',
      "Content-Type": "application/json"
   }
   data = {
      'username': 'mysqlbin',
      'password': 'guangdong',
   }
   params = {
      'a': 1,
      'b': 2
   }
   resp = requests.post(host + "/post", headers=headers, data=data, params=params)

   # resp = requests.post(host + "/post?a=1&b=2", headers=headers, data=data)

   print(resp.text)

   """
      {
         "args": {
            "a": "1",
            "b": "2"
         },
         "data": "username=mysqlbin&password=guangdong",
         "files": {},
         "form": {},
         "headers": {
            "Accept": "*/*",
            "Accept-Encoding": "gzip, deflate",
            "Content-Length": "36",
            "Content-Type": "application/json",
            "Host": "httpbin.org",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36",
            "X-Amzn-Trace-Id": "Root=1-5f33bd55-717fadbc48436897de74b34f"
         },
         "json": null,
         "origin": "121.35.189.165",
         "url": "http://httpbin.org/post?a=1&b=2"
      }
      
   在浏览器直接传参数：
      http://httpbin.org/get?a=1&b=2
      {
        "args": {
          "a": "1", 
          "b": "2"
        }, 
        "headers": {
          "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9", 
          "Accept-Encoding": "gzip, deflate", 
          "Accept-Language": "zh-CN,zh;q=0.9", 
          "Host": "httpbin.org", 
          "Upgrade-Insecure-Requests": "1", 
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36", 
          "X-Amzn-Trace-Id": "Root=1-5f33bdc0-d4423d36f02c892a6a59c9e2"
        }, 
        "origin": "119.8.100.226", 
        "url": "http://httpbin.org/get?a=1&b=2"
      }
   """

   """ 5. 打印其它数据 """
   print(type(resp.content))
   print(resp.content)

   """
   <class 'bytes'>
   b'{\n  "args": {\n    "a": "1", \n    "b": "2"\n  }, \n  "data": "username=mysqlbin&password=guangdong", \n  "files": {}, \n  "form": {}, \n  "headers": {\n    "Accept": "*/*", \n    "Accept-Encoding": "gzip, deflate", \n    "Content-Length": "36", \n    "Content-Type": "application/json", \n    "Host": "httpbin.org", \n    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36", \n    "X-Amzn-Trace-Id": "Root=1-5f33bf4c-1cf6b5e038d49c1048d990b0"\n  }, \n  "json": null, \n  "origin": "121.35.189.165", \n  "url": "http://httpbin.org/post?a=1&b=2"\n}\n'
   """

   print(type(resp.status_code))
   print(resp.status_code)

   """
   <class 'int'>
   200
   """

   print(type(resp.json()))
   print(resp.json())

   """
   <class 'dict'>
   {'args': {'a': '1', 'b': '2'}, 'data': 'username=mysqlbin&password=guangdong', 'files': {}, 'form': {}, 'headers': {'Accept': '*/*', 'Accept-Encoding': 'gzip, deflate', 'Content-Length': '36', 'Content-Type': 'application/json', 'Host': 'httpbin.org', 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', 'X-Amzn-Trace-Id': 'Root=1-5f33c378-f46c0c30bbac3870fdea87d0'}, 'json': None, 'origin': '121.35.189.165', 'url': 'http://httpbin.org/post?a=1&b=2'}
   """
