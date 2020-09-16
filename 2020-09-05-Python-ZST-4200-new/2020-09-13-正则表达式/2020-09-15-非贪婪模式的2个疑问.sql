

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
		
	