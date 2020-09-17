

1. 第一个疑问：

	非贪婪模式：--《1-4-正则表达式入门.pdf》中的案例
		• 文本：aacbacbc
		• 正则：a.*?b
		• 匹配结果：aacb
		
	我的问题1：
		匹配结果：aacb; 这里是写错了吧。
		
	验证：
		import re
		str = "aacbacbc"
		pattern = re.compile(r'a.*?b')
		match = pattern.findall(str)
		print(match)
		# 返回： ['aacb', 'acb']
	
	我的问题2：
		非贪婪匹配模式：正则表达式去匹配时，会尽量少的匹配符合条件的内容 也就是说，一旦发现匹配符合要求，立马就匹配成功，而不会继续匹配下去  --《1-4-正则表达式入门.pdf》中提到的。
		
		aacb 已经匹配成功之后，还是会继续匹配 acb。那么跟 "一旦发现匹配符合要求，立马就匹配成功，而不会继续匹配下去" 这个理论感觉对应不上。
		
		
2. 第二个疑问：--课上的案例
	非贪婪模式：
		import re
		div_content = "其它元素<div><span>用户:<span/><span>张三<span/></div> <br /><div><span>密码:<span/><span>123456<span/></div> 其它元素"
		pattern = re.compile(r'<div>.*?</div>')
		match = pattern.findall(div_content)
		print(match)
		
		"""
		返回：['<div><span>用户:<span/><span>张三<span/></div>', '<div><span>密码:<span/><span>123456<span/></div>']
		我的分析： 
			匹配第一个div标签结束之后，得到第一个div标签的内容；发现第二个div标签也符合匹配规则，继续匹配，得到第二个div标签的内容。
			因此返回结果是 ['<div><span>用户:<span/><span>张三<span/></div>', '<div><span>密码:<span/><span>123456<span/></div>']
		"""
		
	我的问题：
		非贪婪匹配模式：正则表达式去匹配时，会尽量少的匹配符合条件的内容 也就是说，一旦发现匹配符合要求，立马就匹配成功，而不会继续匹配下去  --《1-4-正则表达式入门.pdf》中提到的。
		
		第一个div标签的内容 匹配成功之后，还是会继续匹配 第二个div标签的内容。那么跟 "一旦发现匹配符合要求，立马就匹配成功，而不会继续匹配下去" 这个理论感觉对应不上。
		
		-- 这个问题跟第一个疑问的问题2一样。
		

3. 帮忙看下我的描述对不对

	-- 匹配手机号码
	line = "13202095158555"
	matchOjb = re.match(r'\d{11}$', line)
	print(matchOjb)	
	
	
	首先要明白 match() 含义，它是说从字符串的开始位置匹配，如果开始位置匹配失败，就返回None。
	
	\d{11}$ 表示 匹配后11个数字就结束了，但是 line字符串有 14个数字, 而 match() 是从头开始匹配，line字符串开头的 132 没有匹配成功，所以这里匹配失败。
	
	-----------------------------------
	
	-- 匹配手机号码
	line = "13202095158555"
	matchOjb = re.match(r'\d{11}', line)
	print(matchOjb)	
	
	\d{11} 表示 匹配 line字符串前面11个数字, 而不管后面的3位(555)
	match() 是从头开始匹配
	re.match(r'\d{11}', line) 就是说 从头开始匹配到11个数字就结束了，而不管后面的 3位(555)，所以里匹配成功。 
	
	
	
	
	
	
	
	
	
	
	
	
		