
使用vue的好处，自带有很多的功能，不需要自己写复杂的js等


1. 需要安装的包
2. 父子组件的传值和修改
3. 新建app slowsql 
4. ES数据结构
6. 未解决和未完成
7. 从kibana上的查询结果跟界面的统计数据对比



1. 需要安装的包	
	pipenv install elasticsearch-dsl
	pipenv install elasticsearch
	pipenv install tqdm
	pipenv install requests

	curl http://192.168.0.45:9200/





2. 父子组件的传值和修改
	从父组件传进来的值，子组件默认不能对它进行修改   -- 新版本可以
	因此需要一个监听事件，监听值的变化，通过 this.$emit() 在子组件向父组件传递数据
	父组件需要这个值，因为搜索的时候需要用到  -- 明白了

	父子组件的关系都没搞懂


	https://www.cnblogs.com/vickylinj/p/10877765.html  [Vue]子组件与父组件之间传值


3. 新建app slowsql 
	django-admin startapp slowsql


4. ES数据结构

	{
	  "mappings": {
		"_doc": {
		  "properties": {
			"@timestamp": {
			  "type": "date"
			},
			"finger": {
			  "type": "text",    -- 使用的是ES的排序索引 
			  "fields": {
				"keyword": {
				  "type": "keyword",  -- 
				  "ignore_above": 256
				}
			  }
			},
			"schema": {
			  "type": "text",
			  "fields": {
				"keyword": {
				  "type": "keyword",
				  "ignore_above": 256
				}
			  }
			},
			
			
		"type": "text",     -- 使用的是ES的倒排索引， 不能使用 schema.type=text 字段进行分组，因为它使用的是倒排索引
		"type": "keyword",  -- 是一个整体，可以用  schema.fields.keyword.type=keyword 字段进行分组


6. 未解决和未完成
	
	1. 如何查询指定字段的值
	
	2. slowlog 是指哪个字段
		s = s.filter('match', slowlog_query='select').scan()
		-- slowlog_query 是1个字段名称
	
	
	3. text 、 keyword
	
	4. .bucket 和 .metric 的区别
	
	5. 点击某个地方可以查看SQL的详情
	
		或者参考： https://demo.archerydms.com/slowquery/  分2个tab来做，1个是慢日志统计，另1个是慢日志明细
		
		聚合显示的 sql指纹、不聚合显示sql语句	
		sql指纹、SQL语句太长怎么处理？
		添加1列，两个按钮：按钮1为查看完整的指纹、按钮2为查看语句的详情
		
		聚合页面: 添加1列，加个按钮：点击"查看慢日志明细"按钮可以查看语句的详情	
	

	6. 默认不聚合，就不需要做 group by，显示的结果就是慢查询记录一行行的展示
 
	
				
7. 从kibana上的查询结果跟界面的统计数据对比

	插入数据	
		
		https://blog.csdn.net/apple_wolf/article/details/109404820
		
		
		POST mysql-slowsql-test-2020-11-10/_doc
		{
			"@timestamp": "2020-12-18T07:25:03.881083",
			"finger": "select * from t_user where a = o and d like ljuz;",
			"hash": "c2e50534cba2678374afc4bcf74551a1",
			"host": "192.168.31.55",
			"lock_time": 3.544714736293374,
			"query_sql": "select * from T_user where a = o and d like ljuz;",
			"query_time": 5.1313155923716858,
			"rows_examined": 750,
			"rows_sent": 1000,
			"schema": "Ana",
			"user": "Ana_dev3"
		}			

		POST mysql-slowsql-test-2020-11-10/_doc
		{
			"@timestamp": "2020-12-18T07:25:03.881083",
			"finger": "select * from t_user where a = o and d like ljuz;",
			"hash": "c2e50534cba2678374afc4bcf74551a1",
			"host": "192.168.31.55",
			"lock_time": 3.544714736293374,
			"query_sql": "select * from T_user where a = o and d like ljuz;",
			"query_time": 1.1313155923716858,
			"rows_examined": 750,
			"rows_sent": 1000,
			"schema": "Ana",
			"user": "Ana_dev3"
		}	


	
	"hash" : "c2e50534cba2678374afc4bcf74551a1",
	"query_time" : 5.131315592371686,
	"rows_examined" : 70513,
	"rows_sent" : 80182,
	 ------------------------------------------------
	"hash" : "c2e50534cba2678374afc4bcf74551a1",
	"query_time" : 1.1313155923716858,
	"rows_examined": 750,
	"rows_sent": 1000,
	------------------------------------------------
	"hash" : "c2e50534cba2678374afc4bcf74551a1"
	"query_time" : 1.1313155923716858,
	"rows_examined": 750,
	"rows_sent": 1000,
	
	query_time_avg: select (5.131315592371686+1.1313155923716858+1.1313155923716858)/3 = 2.46464892570501920000
																						2.464648962020874  --by界面的数据
	rows_examined_avg: select (70513+750*2)/3 = 24004.3333
										24004.333333333332   --by界面的数据
										
	rows_sent_avg: select (80182+1000*2)/3 = 27394
										27394                --by界面的数据
					

es 在kibana上做查询还有待加强，需要系统学习下


		
数据结构
  {
	"_index" : "mysql-slowsql-test-2020-11-11",
	"_type" : "_doc",
	"_id" : "zhogg3YBQ5LDcFvTyUmN",
	"_score" : 0.0,
	"_source" : {
	  "query_sql" : "select * from T_money where e like npcbdvftqw and a = lskgatph or b like ert;",
	  "@timestamp" : "2020-11-11T11:17:25.176468",
	  "query_time" : 4.208698476839378,
	  "lock_time" : 8.188964490889036,
	  "rows_sent" : 3488,
	  "rows_examined" : 40718,
	  "user" : "Arnoldo_dev2",
	  "schema" : "Arnoldo",
	  "host" : "192.168.31.55",
	  "finger" : "select * from t_money where e like npcbdvftqw and a = lskgatph or b like ert;",
	  "hash" : "e3f8eb8f1566a802615974b7e68bddda"  --这个是什么？ "hash": hashlib.md5(finger_print.encode('utf-8')).hexdigest() 即 sql指纹md5+hash过后的值
	}
  },
  
 
print(aggs)
{'date': {'buckets': [{'key_as_string': '2020-11-01T00:00:00...'}

 
print(aggs.date)
{'buckets': [{'key_as_string': '2020-11-01T00:00:00.000Z', '...'}

print(aggs['date'])

{'buckets': [{'key_as_string': '2020-11-01T00:00:00.000Z', '...'}


