import requests


if __name__ == "__main__":

   #
   # host = "http://httpbin.org/"
   #
   # cookie = {
   #    "zst": "123456"
   # }
   #
   # resp = requests.get(host + "/cookies/set/zst/123456")
   #
   # print("Resp: {}".format(resp.text))   # 自动完成了获取重定向数据的工作
   # print(requests.utils.dict_from_cookiejar(resp.cookies))
   #


   host = "http://httpbin.org/"

   cookie = {
      "zst": "123456"
   }

   resp = requests.get(host + "/cookies/set/zst/123456", allow_redirects=False)

   # print("Resp: {}".format(resp.text))
   print(requests.utils.dict_from_cookiejar(resp.cookies))


   """
      Resp: <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
      <title>Redirecting...</title>
      <h1>Redirecting...</h1>
      <p>You should be redirected automatically to target URL: <a href="/cookies">/cookies</a>.  If not click the link.
      {'zst': '123456'}
   """

