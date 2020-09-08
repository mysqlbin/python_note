
JavaScript encodeURI() 函数 和 decodeURI() 函数
	
	encodeURI('知数堂')
		"%E7%9F%A5%E6%95%B0%E5%A0%82"
		
	decodeURI('%E7%9F%A5%E6%95%B0%E5%A0%82')
		"知数堂"

	
get 请求的请求报文和响应报文

get请求报文

	Hypertext Transfer Protocol
		# 请求行
		GET //cookies/set/zst/123456 HTTP/1.1\r\n
		
		# 请求头
		Host: httpbin.org\r\n
		User-Agent: python-requests/2.24.0\r\n
		Accept-Encoding: gzip, deflate\r\n
		Accept: */*\r\n
		Connection: keep-alive\r\n
		\r\n
		
		# 请求体，其中请求数据没有具体的格式。
		[Full request URI: http://httpbin.org//cookies/set/zst/123456]
		[HTTP request 1/2]
		[Response in frame: 260]
		[Next request in frame: 261]
	
	*/
	
	
get请求的响应报文	

	Hypertext Transfer Protocol
		
		# 响应行
		HTTP/1.1 200 OK\r\n  
		
		# 响应头
		Date: Mon, 07 Sep 2020 02:27:33 GMT\r\n
		Content-Type: application/json\r\n
		Content-Length: 43\r\n
		Connection: keep-alive\r\n
		Server: gunicorn/19.9.0\r\n
		Access-Control-Allow-Origin: *\r\n
		Access-Control-Allow-Credentials: true\r\n
		\r\n
		
		# 响应体/响应正文
		[HTTP response 2/2]
		[Time since request: 0.232278000 seconds]
		[Prev request in frame: 232]
		[Prev response in frame: 260]
		[Request in frame: 261]
		[Request URI: http://httpbin.org/cookies]
		File Data: 43 bytes

