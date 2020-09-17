
ASCII
	ASCII（American Standard Code for Information Interchange，美国信息交换标准代码）是基于拉丁字母的一套电脑编码系统。

	ASCII-不可见的字符-控制字符
	\n 软回车：
		在Windows 中表示换行且回到下一行的最开始位置。相当于Mac OS 里的 \r 的效果
		在Linux、unix 中只表示换行，但不会回到下一行的开始位置。
		
	\r 软空格：
		在Linux、unix 中表示返回到当行的最开始位置。
		在Mac OS 中表示换行且返回到下一行的最开始位置，相当于Windows 里的 \n 的效果	
		
	\t 跳格 tab（移至下一列）。


	操作系统 	换行符号
	Linux，unix \r \n
	Windows 	\n
	Mac OS 		\r
	
	注意：\n实际上代表的是一个字符
	CRLF, LF 是用来表示文本换行的方式。
	可以调整编辑器的换行方式


	名词解释
		CR：    Carriage Return，对应ASCII中转义字符\r，表示回车
		LF：    Linefeed，       对应ASCII中转义字符\n，表示换行
		CRLF：   Carriage Return & Linefeed，\r\n，表示回车并换行
		
		Windows操作系统采用两个字符来进行换行，即CRLF；
		Unix/Linux/Mac OS X操作系统采用单个字符 LF 来进行换行；
		另外，MacIntosh操作系统（即早期的Mac操作系统）采用单个字符CR来进行换行。
		
		-- 理解了。
		
	dos2unix是将Windows格式文件转换为Unix、Linux格式的实用命令。
	Windows格式文件的换行符为\r\n ,而Unix&Linux文件的换行符为\n.
	dos2unix命令其实就是将文件中的\r\n 转换为\n。
	-- dos2unix命令 之前用过，可行。
	
	而unix2dos则是和dos2unix互为孪生的一个命令，它是将Linux&Unix格式文件转换为Windows格式文件的命令。
	
	http://blog.sina.com.cn/s/blog_4586764e0102ykfz.html
	
	
	在windows下写shell脚本，可以把IDE设置为 Unix(LF)。
	
	最好的解决办法就是把开发环境的IDE的换行符设置为跟生产环境的换行符一致。
	
	
	

买回来的磁盘大小有500GB, 但是实际可用的只有465GB. 这是为什么？
	因为计算方式不一样。
	500GB的计算方式:
		1KB = 1000Byte
		select 500*1000*1000*1000; = 500000000000 Byte
		500GB = 500000000000 Byte
		
	465GB的计算方式：
		1KB = 1024Byte
		SELECT 500000000000/1024/1024/1024; = 465.66GB
			

Unicode码：

	Unicode是一个编码方案，Unicode 是为了解决传统的字符编码方案的局限而产生的，它为每种语言中的每个字符设定了统一并且唯一的二进制编码，以满足跨语言、跨平台进行文本转换、处理的要求。
	Unicode 编码共有三种具体实现，分别为utf-8,utf-16,utf-32，其中utf-8占用一到四个字节，utf-16占用二或四个字节，utf-32占用四个字节。
	Unicode 码在全球范围的信息交换领域均有广泛的应用。 


http://blog.sina.com.cn/s/blog_4586764e0102ykfz.html  
GB2312-80 标准
	GB2312-80 是 1980 年制定的中国汉字编码国家标准。
	
	
Python中的encode与decode
	凡是需要通过网络发送、或者需要保存到文件，都需要将字符串进行encode
	
	with open('filename.txt', encoding='utf-8'):
		# 表示以 utf-8 的编码打开 'filename.txt' 文件。
		
	
	