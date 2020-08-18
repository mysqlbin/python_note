import requests


if __name__ == "__main__":


   host = "http://httpbin.org/"

   cookie = {
      "zst": "123456"
   }

   resp = requests.get(host + "/cookies/set/zst/123456")

   print("Resp: {}".format(resp.text))   # 自动完成了获取重定向数据的工作，所以能获取到cookie
   print(requests.utils.dict_from_cookiejar(resp.cookies))    # 因为本次requests请求触发了重定向，所以获取不到 cookie


   # host = "http://httpbin.org/"
   #
   # cookie = {
   #    "zst": "123456"
   # }
   #
   # resp = requests.get(host + "/cookies/set/zst/123456", allow_redirects=False)    # allow_redirects=False： 禁止重定向
   #
   # # print("Resp: {}".format(resp.text))     # 获取的是重定向的cookie， 但是因为关闭了重定向，所以获取不到 cookie
   # print(requests.utils.dict_from_cookiejar(resp.cookies))  # 因为关闭了重定向，所以可以获取到 cookie

   
   """
      Resp: <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
      <title>Redirecting...</title>
      <h1>Redirecting...</h1>
      <p>You should be redirected automatically to target URL: <a href="/cookies">/cookies</a>.  If not click the link.
      {'zst': '123456'}
   """

