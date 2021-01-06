

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


topsql10
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

GET mysql-slowsql-test-2021-01-05/_search	
{
    "query": {
        "terms" : { "schema" : ["Ana", "Bna"]}
    }
}
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
		  "value" : 0,
		  "relation" : "eq"
		},
		"max_score" : null,
		"hits" : [ ]
	  }
	}


GET mysql-slowsql-test-2021-01-05/_search	
{
    "query":{
        "terms":{
            "schema":["Bna"]
        }
    }
}

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
		  "value" : 0,
		  "relation" : "eq"
		},
		"max_score" : null,
		"hits" : [ ]
	  }
	}
	
	
GET mysql-slowsql-test-2021-01-05/_search
{
  
	"query": {
	  "term": {
		  "schema": "Ana"
	  }
  }
}


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
		  "value" : 0,
		  "relation" : "eq"
		},
		"max_score" : null,
		"hits" : [ ]
	  }
	}
