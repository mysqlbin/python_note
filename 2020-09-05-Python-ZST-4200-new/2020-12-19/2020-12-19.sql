

pipenv install elasticsearch-dsl
pipenv install elasticsearch
pipenv install tqdm
pipenv install requests

curl http://192.168.0.45:9200/






从父组件传进来的值，子组件默认不能对它进行修改   -- 新版本可以
因此需要一个监听事件，监听值的变化，通过 this.$emit() 在子组件向父组件传递数据
父组件需要这个值，因为搜索的时候需要用到  -- 明白了

父子组件的关系都没搞懂


https://www.cnblogs.com/vickylinj/p/10877765.html  [Vue]子组件与父组件之间传值



django-admin startapp slowsql


ES数据结构

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

现有数据和查询方式
现有数据	
	to_dict()
		{'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}
		{'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}
		{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
		{'query_sql': 'select * from T_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', '@timestamp': '2020-11-10T17:43:44.662098', 'query_time': 19.516143900494534, 'lock_time': 19.769934421241025, 'rows_sent': 64289, 'rows_examined': 42634, 'user': 'Dallin_root', 'schema': 'Dallin', 'host': '192.168.31.55', 'finger': 'select * from t_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', 'hash': '8912c82ae854b8d940544c12565ef54f'}
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}

	to_dict(include_meta=True)

		{'_id': '_Rohg3YBQ5LDcFvTSklO', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}}
		{'_id': 'Bhohg3YBQ5LDcFvTVErf', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}}
		{'_id': 'GBohg3YBQ5LDcFvTYErb', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}}
		{'_id': 'Zhohg3YBQ5LDcFvTkUod', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', '@timestamp': '2020-11-10T17:43:44.662098', 'query_time': 19.516143900494534, 'lock_time': 19.769934421241025, 'rows_sent': 64289, 'rows_examined': 42634, 'user': 'Dallin_root', 'schema': 'Dallin', 'host': '192.168.31.55', 'finger': 'select * from t_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', 'hash': '8912c82ae854b8d940544c12565ef54f'}}
		{'_id': 'axohg3YBQ5LDcFvTkUp1', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}}
		{'_id': 'hxohg3YBQ5LDcFvTkkrQ', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}}
		{'_id': 'pBohg3YBQ5LDcFvTk0r3', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}}
		{'_id': 'EBohg3YBQ5LDcFvTmEus', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}}

		'schema' : 'Guillermo'
		'schema' : 'Ena'
		'schema' : 'Leon'
		'schema' : 'Dallin'
		'schema' : 'Gage'
		'schema' : 'Talia'
		'schema' : 'Jameson'
		'schema' : 'Luigi'
		

	s.sort('-@timestamp')
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}
		{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
		{'query_sql': 'select * from T_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', '@timestamp': '2020-11-10T17:43:44.662098', 'query_time': 19.516143900494534, 'lock_time': 19.769934421241025, 'rows_sent': 64289, 'rows_examined': 42634, 'user': 'Dallin_root', 'schema': 'Dallin', 'host': '192.168.31.55', 'finger': 'select * from t_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', 'hash': '8912c82ae854b8d940544c12565ef54f'}
		{'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}

	
查询方式
	
	term等值查询
		
		result = s.filter('term', schema__keyword='Ena').scan()
		for i in result:
			print(i)
			print(i.to_dict(include_meta=True))
		
		
		SlowQuery(index='mysql-slowsql-test-2020-11-10', id='Bhohg3YBQ5LDcFvTVErf')
		{'_id': 'Bhohg3YBQ5LDcFvTVErf', '_index': 'mysql-slowsql-test-2020-11-10', '_source': {'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}}

	
	
	range范围查询
	
        from_date = '2020-11-10T19:00:00'
        to_date = '2020-11-10T20:00:00'
        options = {
            'gte': from_date,
            'lte': to_date
        }
        result = s.filter('range', **{'@timestamp': options}).execute()	
		
		{'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}
		{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}

	
	
	查询以什么开头的
		
		方式1
			s = s.filter('wildcard', schema__keyword='*L*').scan()
			# 查询以 "L" 字符开头的

			{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
			{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}

		方式2
			s = s.filter('prefix', schema__keyword='L').scan()

			{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
			{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
	
	
	match查询也是一种匹配查询
		
		但是用于text字段，只要包含了这个select这个单词，就能查出来
		result = s.filter('match', query_sql='select').scan()
	
		{'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}
		{'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}
		{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
		{'query_sql': 'select * from T_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', '@timestamp': '2020-11-10T17:43:44.662098', 'query_time': 19.516143900494534, 'lock_time': 19.769934421241025, 'rows_sent': 64289, 'rows_examined': 42634, 'user': 'Dallin_root', 'schema': 'Dallin', 'host': '192.168.31.55', 'finger': 'select * from t_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', 'hash': '8912c82ae854b8d940544c12565ef54f'}
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}

		
		result = s.filter('match', query_sql='T_computer').scan()
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
			
		
		result = s.filter('match', query_sql='from select').scan()
		{'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}
		{'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}
		{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
		{'query_sql': 'select * from T_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', '@timestamp': '2020-11-10T17:43:44.662098', 'query_time': 19.516143900494534, 'lock_time': 19.769934421241025, 'rows_sent': 64289, 'rows_examined': 42634, 'user': 'Dallin_root', 'schema': 'Dallin', 'host': '192.168.31.55', 'finger': 'select * from t_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', 'hash': '8912c82ae854b8d940544c12565ef54f'}
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
			
		result = s.filter('match', query_sql='jz T_computer').scan()
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
			
		result = s.filter('match', query_sql='abc T_computer').scan()
	
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
		
		# 分词查找/匹配，只要找到1个分词，就能查出来


		result = s.filter('match', query_sql='abc cda').scan()
		not result
		
		
	And组合
	
		通过链式调用，关系是与
		
		result = s.filter('match', query_sql='T_computer').filter('term', schema__keyword='Talia').scan()
		
		{'query_sql': 'select * from T_computer where e like o;', '@timestamp': '2020-11-27T17:57:06.744475', 'query_time': 1.1986808017893593, 'lock_time': 6.721497574539354, 'rows_sent': 96541, 'rows_examined': 95467, 'user': 'Talia_root', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like o;', 'hash': 'f2ee1126760517763f8d7f832ff848c5'}
		{'query_sql': 'select * from T_computer where a like abxjfmse;', '@timestamp': '2020-11-24T06:24:04.544331', 'query_time': 13.709106739168334, 'lock_time': 9.06695650999721, 'rows_sent': 14643, 'rows_examined': 22924, 'user': 'Talia_dev1', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where a like abxjfmse;', 'hash': '3f88af7b129859beacfe0e16c5e29075'}
		{'query_sql': 'select * from T_computer where a like lifpgws;', '@timestamp': '2020-12-03T06:40:36.508546', 'query_time': 11.835608474771341, 'lock_time': 9.02051780004993, 'rows_sent': 17573, 'rows_examined': 48647, 'user': 'Talia_dev1', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where a like lifpgws;', 'hash': 'f94ab484f21c3cc8a5eb4216b76c875c'}
		{'query_sql': 'select * from T_computer where a like ketbvxz;', '@timestamp': '2020-12-14T19:32:55.083333', 'query_time': 17.113041857312865, 'lock_time': 12.41986087198098, 'rows_sent': 12766, 'rows_examined': 99471, 'user': 'Talia_dev1', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where a like ketbvxz;', 'hash': '3659419251ad6338cc7f4007efe18477'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}
		{'query_sql': 'select * from T_computer where e = erlkywuat and b = kxvq;', '@timestamp': '2020-11-29T08:04:31.007210', 'query_time': 19.81614527989572, 'lock_time': 9.044686453406058, 'rows_sent': 90272, 'rows_examined': 65082, 'user': 'Talia_dba', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e = erlkywuat and b = kxvq;', 'hash': 'ddd2677ef69cc43017027fc1bc720cbf'}
		{'query_sql': 'select * from T_computer where d = yiknzrdvsf or e like aewhobslnf;', '@timestamp': '2020-11-11T17:55:02.831464', 'query_time': 12.07393583563981, 'lock_time': 11.693281515162202, 'rows_sent': 100614, 'rows_examined': 70802, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where d = yiknzrdvsf or e like aewhobslnf;', 'hash': '0f5d4979822f8bc9d2f036222a754e14'}

	or组合
	
		q = Q("match", query_sql='gqfeyhtnr') | Q("term", schema__keyword="Talia")
		
		
		result = s.filter(q).scan()
		
		-- 数据太多，这里展示的是部分有代表性的数据
		{'query_sql': 'select * from T_user where c like shcxge and e = mzodrnqvi or d like g;', '@timestamp': '2020-11-01T02:04:43.926561', 'query_time': 7.945848265570684, 'lock_time': 19.47086245366876, 'rows_sent': 81936, 'rows_examined': 5783, 'user': 'Talia_test', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_user where c like shcxge and e = mzodrnqvi or d like g;', 'hash': 'efa288739ef8c9661e557c05831c23aa'}
		{'query_sql': 'select * from T_computer where e like o;', '@timestamp': '2020-11-27T17:57:06.744475', 'query_time': 1.1986808017893593, 'lock_time': 6.721497574539354, 'rows_sent': 96541, 'rows_examined': 95467, 'user': 'Talia_root', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like o;', 'hash': 'f2ee1126760517763f8d7f832ff848c5'}
		{'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}
		{'query_sql': 'select * from T_computer where a like abxjfmse;', '@timestamp': '2020-11-24T06:24:04.544331', 'query_time': 13.709106739168334, 'lock_time': 9.06695650999721, 'rows_sent': 14643, 'rows_examined': 22924, 'user': 'Talia_dev1', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where a like abxjfmse;', 'hash': '3f88af7b129859beacfe0e16c5e29075'}
				





	数据排序
		# 时间倒序
		search = search.sort('-@timestamp')
		
		# 时间顺序
		search = search.sort('@timestamp')
		
		# 多字段排序
		search = search.sort('-@timestamp', 'rows_examined')
		
		{'query_sql': 'select * from T_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', '@timestamp': '2020-11-10T23:48:24.570994', 'query_time': 13.557566507294522, 'lock_time': 19.97787920989867, 'rows_sent': 24586, 'rows_examined': 30521, 'user': 'Jameson_mysql', 'schema': 'Jameson', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c like xsu or e like fyoveur or c = l or d = iogmzpu;', 'hash': 'b91f9d94250747ab4907d59d896903d6'}
		{'query_sql': 'select * from T_bill where c like rythdonaj and b = adqjz;', '@timestamp': '2020-11-10T19:50:07.209914', 'query_time': 14.943350414676974, 'lock_time': 10.879396000451333, 'rows_sent': 20910, 'rows_examined': 39904, 'user': 'Guillermo_mysql', 'schema': 'Guillermo', 'host': '192.168.31.55', 'finger': 'select * from t_bill where c like rythdonaj and b = adqjz;', 'hash': '16430c5b25ec59743ac6b3ddae0b247f'}
		{'query_sql': 'select * from T_money where e like cmqavyue;', '@timestamp': '2020-11-10T19:24:33.701718', 'query_time': 16.844165268526105, 'lock_time': 11.761459849625247, 'rows_sent': 39763, 'rows_examined': 20071, 'user': 'Leon_dev3', 'schema': 'Leon', 'host': '192.168.31.55', 'finger': 'select * from t_money where e like cmqavyue;', 'hash': 'ada81ba1a268978364bbc9a230715364'}
		{'query_sql': 'select * from T_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', '@timestamp': '2020-11-10T17:43:44.662098', 'query_time': 19.516143900494534, 'lock_time': 19.769934421241025, 'rows_sent': 64289, 'rows_examined': 42634, 'user': 'Dallin_root', 'schema': 'Dallin', 'host': '192.168.31.55', 'finger': 'select * from t_bill where e like rxzbdcavwp or d like l and e like afdsuezq;', 'hash': '8912c82ae854b8d940544c12565ef54f'}
		{'query_sql': 'select * from T_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', '@timestamp': '2020-11-10T16:27:02.226322', 'query_time': 18.634818252440706, 'lock_time': 17.689638668934744, 'rows_sent': 90344, 'rows_examined': 55708, 'user': 'Ena_mysql', 'schema': 'Ena', 'host': '192.168.31.55', 'finger': 'select * from t_money where d = gqfeyhtnr or a = hryx or d like qtva or c = ca;', 'hash': '173688de13e88604ea67f3b4dbc13916'}
		{'query_sql': 'select * from T_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', '@timestamp': '2020-11-10T12:07:15.444544', 'query_time': 16.44919174069218, 'lock_time': 1.6498487003689624, 'rows_sent': 34711, 'rows_examined': 29723, 'user': 'Gage_dev3', 'schema': 'Gage', 'host': '192.168.31.55', 'finger': 'select * from t_computer where b = rguboy or e like fcvnh and e = a or c = yhuqwjzbn;', 'hash': '067a4fac523e0a93765d4529c4613916'}
		{'query_sql': 'select * from T_computer where c = jz;', '@timestamp': '2020-11-10T11:10:51.384579', 'query_time': 6.724714628910816, 'lock_time': 8.944487095158582, 'rows_sent': 67393, 'rows_examined': 54912, 'user': 'Luigi_dba', 'schema': 'Luigi', 'host': '192.168.31.55', 'finger': 'select * from t_computer where c = jz;', 'hash': '81c15a87d6b0d448e11ec00b95a2aa26'}
		{'query_sql': 'select * from T_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', '@timestamp': '2020-11-10T10:08:16.956766', 'query_time': 4.8248480174282, 'lock_time': 2.392421647722515, 'rows_sent': 2700, 'rows_examined': 75794, 'user': 'Talia_dev2', 'schema': 'Talia', 'host': '192.168.31.55', 'finger': 'select * from t_computer where e like r or a = wqcg and b = myfpxthr or e = vm;', 'hash': 'c6d6b77b9b77826b91eeef427a10caad'}

	
	
	
	聚合数据
		
		{'key_as_string': '2020-11-10T10:00:00.000Z', 'key': 1605002...}
		{'key_as_string': '2020-11-10T10:10:00.000Z', 'key': 1605003...}
		{'key_as_string': '2020-11-10T10:20:00.000Z', 'key': 1605003...}
		{'key_as_string': '2020-11-10T10:30:00.000Z', 'key': 1605004...}
		{'key_as_string': '2020-11-10T10:40:00.000Z', 'key': 1605004...}
		{'key_as_string': '2020-11-10T10:50:00.000Z', 'key': 1605005...}
		{'key_as_string': '2020-11-10T11:00:00.000Z', 'key': 1605006...}
		...............................................................
		{'key_as_string': '2020-11-10T12:50:00.000Z', 'key': 1605012...}
		{'key_as_string': '2020-11-10T13:00:00.000Z', 'key': 1605013...}
		{'key_as_string': '2020-11-10T13:10:00.000Z', 'key': 1605013...}
		{'key_as_string': '2020-11-10T13:20:00.000Z', 'key': 1605014...}
		...............................................................





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
	

未解决：
	
	1. 如何查询指定字段的值
	
	2. slowlog 是指哪个字段
		s = s.filter('match', slowlog_query='select').scan()
		-- slowlog_query 是1个字段名称
	
	
	3. text 、 keyword


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
  
  
	
多层（嵌套）聚合

	需求
		一段时间范围内，根据schema、指纹为维度每隔1个小时做分组
		先查询一段时间范围内的数据，每隔1个小时做一次分组：根据schema、指纹为维度
		aggregations：聚合
		buckets：桶
		
		
	查询语法
		GET mysql-slowsql-test-*/_search
		{
		  "query": {
			"bool": {
			  "filter": {
				"range": {
				  "@timestamp": {
					"gte": "2020-11-11T00:00:00.000Z",
					"lte": "2020-11-30T00:00:00.000Z"
				  }
				}
			  }
			}
		  }, 
		  "aggs": {
			  "date": {  -- 自定义的分组聚合名称
				  "date_histogram": {
					  "field": "@timestamp",
					  "calendar_interval": "hour"
				  },
				  "aggs": {
					  "schema": {   -- 以schema为单位做分组
						  "terms": {
							  "field": "schema.keyword"
						  },
						  "aggs": {
							  "hash": {
								  "terms": {
									  "field": "hash.keyword"
								  },
								  "aggs": {
									  "rowsExamineAvg": {
										"avg": {
										  "field": "rows_examined"
										}
									  },
									  "queryTimeAvg": {
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
			"date" : {       --桶的名称：date
			  "buckets" : [  --2020-11-11T00:00:00.000Z至2020-11-30T00:00:00.000Z的时间范围桶
				{
				  "key_as_string" : "2020-11-11T00:00:00.000Z",
				  "key" : 1605052800000,
				  "doc_count" : 1,
				  
				  "schema" : {  -- 桶的名称：schema
					"doc_count_error_upper_bound" : 0,
					"sum_other_doc_count" : 0,
					"buckets" : [
					  {
						"key" : "Zelda",      -- schema = "Zelda"
						"doc_count" : 1,
						"hash" : { -- 桶的名称：hash
						  "doc_count_error_upper_bound" : 0,
						  "sum_other_doc_count" : 0,
						  "buckets" : [
							{
							  "key" : "9fd220d6de79f9d280349263d0c1b0a2",   -- hash = "9fd220d6de79f9d280349263d0c1b0a2"
							  "doc_count" : 1,
							  "queryTimeAvg" : {     
								"value" : 17.712387084960938
							  },
							  "rowsExamineAvg" : {
								"value" : 78593.0
							  }
							}
						  ]
						}
					  }
					]
				  }
				},
				{
				  "key_as_string" : "2020-11-11T01:00:00.000Z",
				  "key" : 1605056400000,
				  "doc_count" : 0,
				  "schema" : {
					"doc_count_error_upper_bound" : 0,
					"sum_other_doc_count" : 0,
					"buckets" : [ ]
				  }
				},
				{
				  "key_as_string" : "2020-11-11T02:00:00.000Z",
				  "key" : 1605060000000,
				  "doc_count" : 0,
				  "schema" : {
					"doc_count_error_upper_bound" : 0,
					"sum_other_doc_count" : 0,
					"buckets" : [ ]
				  }
				},
				