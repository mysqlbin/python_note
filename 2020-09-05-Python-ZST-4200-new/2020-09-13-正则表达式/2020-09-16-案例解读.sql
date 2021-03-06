
正则表达式：^[0-9]+abc$
分析：
	^ 为匹配输入字符串的开始位置。
	[0-9]+ 匹配多个数字，其中[0-9]匹配单个数字，+匹配1个或者多个
	abc$ 匹配字母 abc 并以 abc 结尾，其中 $ 为匹配输入字符串的结束位置。
	
	我们在写用户注册表单时，只允许用户名包含小写字母、数字、下划线和连接字符(-)，并设置用户名的长度，我们就可以使用以下正则表达式来设定。
		^[a-z0-9_-]{3,15}$
		
		^ 为开始标记
		[a-z0-9_-] 为字母(a-z)数字(0-9)下线线_连字符
		3-15个字符的长度
		$ 为结束标识
		
		用户名只允许有：字母(a-z)数字(0-9)下线线_连字符， 
		^ 表示 以 字母(a-z)数字(0-9)下划线_连字符 其中之一开头 
		{3,15}$ 表示以 字母(a-z)数字(0-9)下划线_连字符 中的 3-15个字符结尾。---*****************
		
		-- 完全匹配：比如只要有大写字母就匹配不到
		
		-- 为什么这里要加 '$'结束标识 ?
			不加 '$'结束标识:
				username = "123456A33bc"
				matchOjb = re.match(r'^[a-z0-9_-]{3,15}', username)
				if matchOjb:
					print(matchOjb.group())
				#返回：123456
				
			加 '$'结束标识:
				username = "123456A33bc"
				matchOjb = re.match(r'^[a-z0-9_-]{3,15}$', username)
				if matchOjb:
					print(matchOjb.group())		
						
				# 匹配不到。
				
			-- 通过例子/实验，验证了 $ 结束标识 的作用。
			
							
		import re
		str = "A533abc-_"
		pattern = re.compile(r'[a-z0-9_-]{3,15}')
		print(pattern.findall(str))
		# ['533abc-_']			 
	
		# findall 跟 search 的匹配规则差不多，只是返回结果的数据类型不一样。
		
		
		
		