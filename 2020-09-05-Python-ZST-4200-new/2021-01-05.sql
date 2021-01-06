

	
1. 制造数据 
2. 一层聚合  
3. 多层聚合+指标(Metrics) 
4. Terms聚合 
	4.1 Terms聚合的使用
	4.2 Terms聚合+top_hits	
5. 常见的查询方式
	5.1 match查询也是一种匹配查询
	5.2 like "%%"包含查询
	5.3 range范围查询
	5.4 term等值查询
	5.5 bool 过滤器--AND查询
	5.6 bool 过滤器--OR查询
	
小结
	找到好的学习资料，事半功倍

相关参考
	


可以把查询语法理解为一个json对象


1. 制造数据 
	POST mysql-slowsql-test-2021-01-05/_doc
	{
		"@timestamp": "2020-12-18T07:25:03.881083",
		"finger": "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
		"hash": "05565c7c62dd546642e1a61a3b06cb59",
		"host": "192.168.31.55",
		"lock_time": 3.544714736293374,
		"query_sql": "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
		"query_time": 5.1313155923716858,
		"rows_examined": 750,
		"rows_sent": 1000,
		"schema": "Ana",
		"user": "Ana_dev3"
	}			
			
		
	POST mysql-slowsql-test-2021-01-05/_doc
	{
		"@timestamp": "2020-12-19T07:25:03.881083",
		"finger": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"hash": "0ae70d1d056f46eda180c69c26061fd4",
		"host": "192.168.31.55",
		"lock_time": 3.544714736293374,
		"query_sql": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"query_time": 5.1313155923716858,
		"rows_examined": 750,
		"rows_sent": 1000,
		"schema": "Bna",
		"user": "Bna_dev3"
	}

	POST mysql-slowsql-test-2021-01-05/_doc
	{
		"@timestamp": "2020-12-20T07:25:03.881083",
		"finger": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"hash": "0ae70d1d056f46eda180c69c26061fd4",
		"host": "192.168.31.55",
		"lock_time": 3.544714736293374,
		"query_sql": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"query_time": 5.1313155923716858,
		"rows_examined": 750,
		"rows_sent": 1000,
		"schema": "Bna",
		"user": "Bna"
	}

	POST mysql-slowsql-test-2021-01-05/_doc
	{
		"@timestamp": "2020-12-20T09:25:03.881083",
		"finger": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"hash": "0ae70d1d056f46eda180c69c26061fd4",
		"host": "192.168.31.55",
		"lock_time": 3.544714736293374,
		"query_sql": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"query_time": 5.1313155923716858,
		"rows_examined": 750,
		"rows_sent": 1000,
		"schema": "Cna",
		"user": "Cna"
	}

 
2. 一层聚合  
	把所有的数据根据每小时划分为一桶
			GET mysql-slowsql-test-2020-11-10/_search
			{
			  "aggs": {
				"date": {
				  "date_histogram": {
					"field": "@timestamp",
					"interval": "hour"
				  }
				} 
			  }
			}
			
			
	先查询某一段时间范围内的数据，每隔1个小时划分为一桶

		GET mysql-slowsql-test-2021-01-05/_search
		{
		
			"query": {  // 执行查询
				"bool": {
				  "filter": {  // 过滤查找
					"range": {  // 范围查询
					  "@timestamp": {
						  "gte": "2020-12-20T00:00:00.000Z",
						  "lte": "2020-12-21T00:00:00.000Z"
					  }
					}
				  }
				}
		  }, 
		  "aggs": {    // 表示要分组
			  "date": {  // aggs 后面接着的是一个自定义的name
				"date_histogram": {  // 按照日期时间聚合分析数据
					"field": "@timestamp",  // 分析的字段
					"interval": "hour"      // 按小时间隔 
				}
			} 
		  }
		}
		result 

		  "aggregations" : {
			"date" : {
			  "buckets" : [
				{
				  "key_as_string" : "2020-12-20T07:00:00.000Z",
				  "key" : 1608447600000,
				  "doc_count" : 1
				},
				{
				  "key_as_string" : "2020-12-20T08:00:00.000Z",
				  "key" : 1608451200000,
				  "doc_count" : 0
				},
				{
				  "key_as_string" : "2020-12-20T09:00:00.000Z",
				  "key" : 1608454800000,
				  "doc_count" : 1
				}
			  ]
			}
		  }
	  
		对应的Python代码

3. 多层聚合+指标(Metrics) 
		
	需求
		一段时间范围内，根据schema、指纹为维度每隔1个小时做分组
		先查询一段时间范围内的数据，每隔1个小时做一次分组(分为一桶)：根据schema、指纹为维度
		aggregations：聚合
		buckets：桶
		
	POST mysql-slowsql-test-2021-01-05/_doc
	{
		"@timestamp": "2020-12-20T09:25:03.881083",
		"finger": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"hash": "0ae70d1d056f46eda180c69c26061fd4",
		"host": "192.168.31.55",
		"lock_time": 3.544714736293374,
		"query_sql": "select * from t_computer where b like kuexrj or d = czqjhpg;",
		"query_time": 5.1313155923716858,
		"rows_examined": 750,
		"rows_sent": 1000,
		"schema": "Cna",
		"user": "Cna"
	}
	
	查询语法
		GET mysql-slowsql-test-2021-01-05/_search
		{
		  "query": {
			"bool": {
			  "filter": {
				"range": {  // 范围查询
					  "@timestamp": {
						  "gte": "2020-12-20T00:00:00.000Z",
						  "lte": "2020-12-21T00:00:00.000Z"
					  }
					}
				
			  }
			}
		  }, 
		  "aggs": {  // 表示要分组
			  "date": {  -- 自定义的分组聚合名称
				  "date_histogram": { //按照日期时间聚合分析数据
					  "field": "@timestamp",
					  "calendar_interval": "hour"
				  },
				  "aggs": {   //aggs可以嵌套在别的aggs裡面，这里是嵌套在 aggs=date 中
					  "schema": {   //记得使用aggs需要先自定义一个name
						  "terms": { // terms桶 : 针对某个field的值进行分组，field有几种值就分成几组
							  "field": "schema.keyword"
						  },
						  "aggs": {   //aggs可以嵌套在别的aggs裡面，这里是嵌套在 aggs=schema 中
							  "hash": {   //记得使用aggs需要先自定义一个name
								  "terms": {  // terms桶 : 针对某个field的值进行分组，field有几种值就分成几组
									  "field": "hash.keyword"
								  },
								  "aggs": {  //嵌套两个指标avg、avg在terms桶中
									  "rowsExamineAvg": {  //rowsExamineAvg计算每个bucket的平均扫描行数
										"avg": {
										  "field": "rows_examined"
										}
									  },
									  "queryTimeAvg": {  //rowsExamineAvg计算每个bucket的平均执行时间
										  "avg": {
											  "field": "query_time"
										  }
									  } 
								  }
							  }
						  }
					  }
				  }
			  }
		  }
		}
	
	
	
	结果
		取聚合后的数据也是要一层层地取
		"aggregations" : {
			"date" : {
			  "buckets" : [
				{
				  "key_as_string" : "2020-12-20T07:00:00.000Z",
				  "key" : 1608447600000,
				  "doc_count" : 1,
				  "schema" : {
					"doc_count_error_upper_bound" : 0,
					"sum_other_doc_count" : 0,
					"buckets" : [
					  {
						"key" : "Bna",
						"doc_count" : 1,
						"hash" : {
						  "doc_count_error_upper_bound" : 0,
						  "sum_other_doc_count" : 0,
						  "buckets" : [
							{
							  "key" : "0ae70d1d056f46eda180c69c26061fd4",
							  "doc_count" : 1,
							  "queryTimeAvg" : {
								"value" : 5.1313157081604
							  },
							  "rowsExamineAvg" : {
								"value" : 750.0
							  }
							}
						  ]
						}
					  }
					]
				  }
				},
				{
				  "key_as_string" : "2020-12-20T08:00:00.000Z",
				  "key" : 1608451200000,
				  "doc_count" : 0,
				  "schema" : {
					"doc_count_error_upper_bound" : 0,
					"sum_other_doc_count" : 0,
					"buckets" : [ ]
				  }
				},
				{
				  "key_as_string" : "2020-12-20T09:00:00.000Z",
				  "key" : 1608454800000,
				  "doc_count" : 2,
				  "schema" : {
					"doc_count_error_upper_bound" : 0,
					"sum_other_doc_count" : 0,
					"buckets" : [
					  {
						"key" : "Cna",
						"doc_count" : 2,
						"hash" : {
						  "doc_count_error_upper_bound" : 0,
						  "sum_other_doc_count" : 0,
						  "buckets" : [
							{
							  "key" : "0ae70d1d056f46eda180c69c26061fd4",
							  "doc_count" : 2,
							  "queryTimeAvg" : {
								"value" : 5.1313157081604
							  },
							  "rowsExamineAvg" : {
								"value" : 750.0
							  }
							}
						  ]
						}
					  }
					]
				  }
				}
			  ]
			}
		  }
	对应的Python代码



4. Terms聚合
4.1 Terms聚合的使用

	取topsql10的SQL
	根据schema+finger的hash值分组(分桶)，取出现次数最多的前前10个慢查询，再返回每个桶的前1条的finger
	GET mysql-slowsql-test-*/_search
	{
	  "aggs":{
		"schema": {
		  "terms": {  
			"script": "doc['schema.keyword'].value+'#'+doc['hash.keyword'].value",
			"size": 5
		  }
		}
	  }
	}

	result
	  "aggregations" : {
		"schema" : {
		  "doc_count_error_upper_bound" : 14,
		  "sum_other_doc_count" : 495,
		  "buckets" : [
			{
			  "key" : "Ana#05565c7c62dd546642e1a61a3b06cb59",
			  "doc_count" : 1
			},
			{
			  "key" : "Ana#0ae70d1d056f46eda180c69c26061fd4",
			  "doc_count" : 1
			},
			{
			  "key" : "Ana#2a7593c2dba528b8a82d96d8463da608",
			  "doc_count" : 1
			},
			{
			  "key" : "Ana#3b87de8b53853ffd3b426ac652201c9c",
			  "doc_count" : 1
			},
			{
			  "key" : "Ana#3b9ebc56e56b3a265c3f8738e60ed41b",
			  "doc_count" : 1
			}
		  ]
		}
	  }

	-- 对应的代码段 没有 order by ？ 不需要，默认根据 doc_count desc 
	def get_top10_sql(self, request, *args, **kwargs):
		s = self.get_query_by_params(request)
		composite = A('terms', script="doc['schema.keyword'].value+'#'+doc['hash.keyword'].value", size=10)
		s.aggs.bucket('sql', composite).bucket('finger', A('top_hits', _source=["finger"], size=1))
		aggs = s.execute().aggregations

	
4.2 Terms聚合+top_hits	

	
	top_hits桶 : 

		在某个桶底下找出这个桶的前几笔hits，返回的hits格式和主查询query返回的hits格式一模一样	

	
	-- 还写不出下面的查询，没事，花点时间学习下es查询相关的
	GET mysql-slowsql-test-*/_search
	{
	  "aggs":{
		"schema": {   --分组字段
		  "terms": {
			"script": "doc['schema.keyword'].value+'#'+doc['hash.keyword'].value",
			"size": 5
		  },
		  "aggs": {
			"finger": {
			  "top_hits": {    			-- 聚合类型为 top_hits, 返回每个桶的前1条
				"_source": ["finger"],  -- 只取 finger 字段 
				"size": 1               -- 只取1条
			  }
			}
		  }
		}
	  }
	}


	手工补数据
		POST mysql-slowsql-test-2020-11-10/_doc
		{
			"@timestamp": "2020-12-18T07:25:03.881083",
			"finger": "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
			"hash": "05565c7c62dd546642e1a61a3b06cb59",
			"host": "192.168.31.55",
			"lock_time": 3.544714736293374,
			"query_sql": "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
			"query_time": 5.1313155923716858,
			"rows_examined": 750,
			"rows_sent": 1000,
			"schema": "Ana",
			"user": "Ana_dev3"
		}			
				
			
		POST mysql-slowsql-test-2020-11-10/_doc
		{
			"@timestamp": "2020-12-18T07:25:03.881083",
			"finger": "select * from t_computer where b like kuexrj or d = czqjhpg;",
			"hash": "0ae70d1d056f46eda180c69c26061fd4",
			"host": "192.168.31.55",
			"lock_time": 3.544714736293374,
			"query_sql": "select * from t_computer where b like kuexrj or d = czqjhpg;",
			"query_time": 5.1313155923716858,
			"rows_examined": 750,
			"rows_sent": 1000,
			"schema": "Ana",
			"user": "Ana_dev3"
		}	


			
	result
	"aggregations" : {
		"schema" : {
		  "doc_count_error_upper_bound" : 24,
		  "sum_other_doc_count" : 499,
		  "buckets" : [
			{
			  "key" : "Ana#0ae70d1d056f46eda180c69c26061fd4",
			  "doc_count" : 3,
			  "finger" : {
				"hits" : {
				  "total" : {
					"value" : 3,
					"relation" : "eq"
				  },
				  "max_score" : 1.0,
				  "hits" : [
					{
					  "_index" : "mysql-slowsql-test-2020-11-10",
					  "_type" : "_doc",
					  "_id" : "rhryt3YBQ5LDcFvTLU3o",
					  "_score" : 1.0,
					  "_source" : {
						"finger" : "select * from t_computer where b like kuexrj or d = czqjhpg;"
					  }
					}
				  ]
				}
			  }
			},
			{
			  "key" : "Ana#05565c7c62dd546642e1a61a3b06cb59",
			  "doc_count" : 2,
			  "finger" : {
				"hits" : {
				  "total" : {
					"value" : 2,
					"relation" : "eq"
				  },
				  "max_score" : 1.0,
				  "hits" : [
					{
					  "_index" : "mysql-slowsql-test-2020-11-10",
					  "_type" : "_doc",
					  "_id" : "rRrpt3YBQ5LDcFvT5E1W",
					  "_score" : 1.0,
					  "_source" : {
						"finger" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;"
					  }
					}
				  ]
				}
			  }
			}
		  ]
		}
	  }
	}




5. 常见的查询方式
5.1 match查询也是一种匹配查询
	
	但是用于text字段，只要包含了这个select这个单词，就能查出来
	
	GET mysql-slowsql-test-2021-01-05/_search
	{
		 "query": {
		    "match": {
		      "query_sql": "abc urtaevhwcz"
		    }
		 }
	}
	
		"hits" : [
		  {
			"_index" : "mysql-slowsql-test-2021-01-05",
			"_type" : "_doc",
			"_id" : "sBoe0nYBQ5LDcFvThk2P",
			"_score" : 1.3042111,
			"_source" : {
			  "@timestamp" : "2020-12-18T07:25:03.881083",
			  "finger" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
			  "hash" : "05565c7c62dd546642e1a61a3b06cb59",
			  "host" : "192.168.31.55",
			  "lock_time" : 3.544714736293374,
			  "query_sql" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
			  "query_time" : 5.131315592371686,
			  "rows_examined" : 750,
			  "rows_sent" : 1000,
			  "schema" : "Ana",
			  "user" : "Ana_dev3"
			}
		  }
		]
	
	result = s.filter('match', query_sql='abc urtaevhwcz').scan()	
	
		{'_id': 'sBoe0nYBQ5LDcFvThk2P', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-18T07:25:03.881083', 'finger': 'select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;', 'hash': '05565c7c62dd546642e1a61a3b06cb59', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Ana', 'user': 'Ana_dev3'}}


	GET mysql-slowsql-test-2021-01-05/_search
	{
		 "query": {
		    "match": {
		      "query_sql.keyword": "abc urtaevhwcz"
		    }
		 }
	}
		 "hits" : {
			"total" : {
			  "value" : 0,
			  "relation" : "eq"
			},
			"max_score" : null,
			"hits" : [ ]
		  }		
	
	
5.2 like "%%"包含查询

	GET mysql-slowsql-test-2021-01-05/_search
	{
		 "query": {
		   "wildcard": {
		      "schema.keyword": "*An*"
		   }
		 }
	}
	
	GET mysql-slowsql-test-2021-01-05/_search
	{
		 "query": {
		   "wildcard": {
		     "schema.keyword": {
		       "value": "*An*"
		     }
		   }
		 }
	}
	
		"hits" : [
		  {
			"_index" : "mysql-slowsql-test-2021-01-05",
			"_type" : "_doc",
			"_id" : "sBoe0nYBQ5LDcFvThk2P",
			"_score" : 1.0,
			"_source" : {
			  "@timestamp" : "2020-12-18T07:25:03.881083",
			  "finger" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
			  "hash" : "05565c7c62dd546642e1a61a3b06cb59",
			  "host" : "192.168.31.55",
			  "lock_time" : 3.544714736293374,
			  "query_sql" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
			  "query_time" : 5.131315592371686,
			  "rows_examined" : 750,
			  "rows_sent" : 1000,
			  "schema" : "Ana",
			  "user" : "Ana_dev3"
			}
		  }
		]	
		
	result = s.filter('wildcard', schema__keyword='*An*').scan()
	
	{'_id': 'sBoe0nYBQ5LDcFvThk2P', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-18T07:25:03.881083', 'finger': 'select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;', 'hash': '05565c7c62dd546642e1a61a3b06cb59', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Ana', 'user': 'Ana_dev3'}}

	

5.3 range范围查询
	

	GET mysql-slowsql-test-2021-01-05/_search
	{
		  "query": {
		    "bool": {
		      "filter": {
		        "range": {  
					    "@timestamp": {
						   "gte": "2020-12-20T00:00:00.000Z",
						   "lte": "2020-12-21T00:00:00.000Z"
					  }
					}
		      }
		    }
		  }
	}
	
	https://blog.csdn.net/lm324114/article/details/103543621  es 在案例中实战基于range filter来进行范围过滤
	

	对应的Python代码
		from_date = '2020-12-20T00:00:00'
		to_date = '2020-12-21T00:00:00'
		options = {
			'gte': from_date,
			'lte': to_date
		}
		
		result = s.filter('range', **{'@timestamp': options}).execute()	
		for i in result:
		
            print(i.to_dict(include_meta=True))
		
			{'@timestamp': '2020-12-20T07:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Bna', 'user': 'Bna'}
			{'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}
			{'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}
		
		for i in result:
		
            print(i.to_dict(include_meta=True))
			
			{'_id': 'shoe0nYBQ5LDcFvTh02k', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T07:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Bna', 'user': 'Bna'}}
			{'_id': 'sxrE0nYBQ5LDcFvT4E33', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}}
			{'_id': 'tBos03YBQ5LDcFvTzk0g', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}}

		
5.4 term等值查询
		
	GET mysql-slowsql-test-2021-01-05/_search
	{
	  
		"query": {
		  "term": {
			  "schema.keyword": "Ana"
		  }
	  }
	}
	
	对应的Python代码
		result = s.filter('term', schema__keyword='Ana').scan()
		for i in result:
			print(i)
			print(i.to_dict(include_meta=True))
			
	result
		{
		  "took" : 0,
		  "timed_out" : false,
		  "_shards" : {
			"total" : 1,
			"successful" : 1,
			"skipped" : 0,
			"failed" : 0
		  },
		  "hits" : {
			"total" : {
			  "value" : 1,
			  "relation" : "eq"
			},
			"max_score" : 1.3862942,
			"hits" : [
			  {
				"_index" : "mysql-slowsql-test-2021-01-05",
				"_type" : "_doc",
				"_id" : "sBoe0nYBQ5LDcFvThk2P",
				"_score" : 1.3862942,
				"_source" : {
				  "@timestamp" : "2020-12-18T07:25:03.881083",
				  "finger" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
				  "hash" : "05565c7c62dd546642e1a61a3b06cb59",
				  "host" : "192.168.31.55",
				  "lock_time" : 3.544714736293374,
				  "query_sql" : "select * from t_money where e = xch and d = urtaevhwcz and c = zsgplydh;",
				  "query_time" : 5.131315592371686,
				  "rows_examined" : 750,
				  "rows_sent" : 1000,
				  "schema" : "Ana",
				  "user" : "Ana_dev3"
				}
			  }
			]
		  }
		}



5.5 bool 过滤器--AND查询

	
	GET mysql-slowsql-test-2021-01-05/_search
	{
	  "query": {
		"bool": {
		  "must": [{
			  "match": {
			  "query_sql": "T_computer"
			  }
			}, 
			{
				"term": {
					"schema.keyword": "Cna"
				}
			}
		  ]
		}
	  }
	}
	
	result 
	 "hits" : {
		"total" : {
		  "value" : 2,
		  "relation" : "eq"
		},
		"max_score" : 1.1677496,
		"hits" : [
		  {
			"_index" : "mysql-slowsql-test-2021-01-05",
			"_type" : "_doc",
			"_id" : "sxrE0nYBQ5LDcFvT4E33",
			"_score" : 1.1677496,
			"_source" : {
			  "@timestamp" : "2020-12-20T09:25:03.881083",
			  "finger" : "select * from t_computer where b like kuexrj or d = czqjhpg;",
			  "hash" : "0ae70d1d056f46eda180c69c26061fd4",
			  "host" : "192.168.31.55",
			  "lock_time" : 3.544714736293374,
			  "query_sql" : "select * from t_computer where b like kuexrj or d = czqjhpg;",
			  "query_time" : 5.131315592371686,
			  "rows_examined" : 750,
			  "rows_sent" : 1000,
			  "schema" : "Cna",
			  "user" : "Cna"
			}
		  },
		  {
			"_index" : "mysql-slowsql-test-2021-01-05",
			"_type" : "_doc",
			"_id" : "tBos03YBQ5LDcFvTzk0g",
			"_score" : 1.1677496,
			"_source" : {
			  "@timestamp" : "2020-12-20T09:25:03.881083",
			  "finger" : "select * from t_computer where b like kuexrj or d = czqjhpg;",
			  "hash" : "0ae70d1d056f46eda180c69c26061fd4",
			  "host" : "192.168.31.55",
			  "lock_time" : 3.544714736293374,
			  "query_sql" : "select * from t_computer where b like kuexrj or d = czqjhpg;",
			  "query_time" : 5.131315592371686,
			  "rows_examined" : 750,
			  "rows_sent" : 1000,
			  "schema" : "Cna",
			  "user" : "Cna"
			}
		  }
		]
	  }
	
	对应的Python代码
	result = s.filter('match', query_sql='T_computer').filter('term', schema__keyword='Cna').scan()
		result
			{'_id': 'sxrE0nYBQ5LDcFvT4E33', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}}
			{'_id': 'tBos03YBQ5LDcFvTzk0g', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}}



5.6 bool 过滤器--OR查询
	
	GET mysql-slowsql-test-2021-01-05/_search
	{
	  "query": {
		"bool": {
		  "should": [{
			  "match": {
			  "query_sql": "T_computer"
			  }
			}, 
			{
				"term": {
					"schema.keyword": "Cna"
				}
			}
		  ]
		}
	  }
	}

	
	对应的Python代码
	
        q = Q("match", query_sql='T_computer') | Q("term", schema__keyword="Cna")

        result = s.filter(q).scan()

		result
			{'_id': 'sRoe0nYBQ5LDcFvTh02V', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-19T07:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Bna', 'user': 'Bna_dev3'}}
			{'_id': 'shoe0nYBQ5LDcFvTh02k', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T07:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Bna', 'user': 'Bna'}}
			{'_id': 'sxrE0nYBQ5LDcFvT4E33', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}}
			{'_id': 'tBos03YBQ5LDcFvTzk0g', '_index': 'mysql-slowsql-test-2021-01-05', '_source': {'@timestamp': '2020-12-20T09:25:03.881083', 'finger': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'hash': '0ae70d1d056f46eda180c69c26061fd4', 'host': '192.168.31.55', 'lock_time': 3.544714736293374, 'query_sql': 'select * from t_computer where b like kuexrj or d = czqjhpg;', 'query_time': 5.131315592371686, 'rows_examined': 750, 'rows_sent': 1000, 'schema': 'Cna', 'user': 'Cna'}}


6. 排序

	# 时间倒序
	search = search.sort('-@timestamp')
	
	# 时间顺序
	search = search.sort('@timestamp')
	
	# 多字段排序
	search = search.sort('-@timestamp', 'rows_examined')
	
	
	
小结
	找到好的学习资料，事半功倍

相关参考
	https://blog.csdn.net/weixin_40341116/article/details/81173016   ElasticSearch - 聚合 aggs
	https://blog.csdn.net/weixin_40341116/article/details/80608874   ElasticSearch - 基本类型与映射 (es5.x以上)

	https://www.elastic.co/guide/cn/elasticsearch/guide/current/query-dsl-intro.html  查询表达式(Query DSL)

	https://blog.csdn.net/Veritas_C/article/details/81216653   Elasticsearch： 布尔(bool)过滤器--AND、OR、NOT查询、设置多个查询字段

	https://www.qedev.com/bigdata/173801.html  elasticsearch – 格式错误的查询,预期END_OBJECT但在Kibana中发现FIELD_NAME错误(弹性搜索)
	
	

未掌握
	阅读本文前要先知道 分词、倒排索引 的概念，并需要知道 text, keyword 在 ES 5.x 以上的差别 (ES基本类型与映射)



