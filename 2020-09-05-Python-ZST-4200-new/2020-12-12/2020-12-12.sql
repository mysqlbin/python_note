


[2020-12-15T03:38:54,811][ERROR][o.e.b.Bootstrap          ] [localhost.localdomain] node validation exception
[3] bootstrap checks failed
[1]: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]
[2]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
[3]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured

ulimit -a

https://blog.csdn.net/qq_38636133/article/details/105621876

https://blog.csdn.net/tl1242616458/article/details/105602361/

[vagrant@localhost ~]$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 15090
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 65536
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 4096
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited


-------------------


filebeat所在机器：192.168.0.201 
ES 所在机器：     192.168.0.45

FATAL  Error: Port 5601 is already in use. Another instance of Kibana may be running!

[vagrant@localhost kibana-7.10.1-linux-x86_64]$ netstat -anltp|grep 5601
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp        0      0 192.168.0.45:5601       0.0.0.0:*               LISTEN      5112/./bin/../node/ 
tcp        0      0 192.168.0.45:5601       192.168.0.218:54108     ESTABLISHED 5112/./bin/../node/ 
tcp        0      0 192.168.0.45:5601       192.168.0.218:54070     ESTABLISHED 5112/./bin/../node/ 
tcp        0      0 192.168.0.45:5601       192.168.0.218:54106     ESTABLISHED 5112/./bin/../node/ 
tcp        0      0 192.168.0.45:5601       192.168.0.218:54064     ESTABLISHED 5112/./bin/../node/ 
[vagrant@localhost kibana-7.10.1-linux-x86_64]$ 






kibana      http://192.168.0.45:5601/
elasticsearch.hosts: ["http://192.168.0.45:9200"]

filebeat写入完日志到ES后，接下来通过kibana查看

使用logstash收集完日志后，接下来通过kibana查看


filebeat
es
logstash
kibana
kafka
	配置zookeeper
基于soar，用go获取指纹
python读取kafka


logstash、kibana的关系


es做全文搜索


安装 filebeat、es、kibana
	要用同一个版本
	
	
filebeat

	--安装好简单
	
	配置output、input


	# ============================== Filebeat inputs ===============================

	filebeat.inputs:

	
	- type: log

	  # Change to true to enable this input configuration.
	  enabled: true

	  # Paths that should be crawled and fetched. Glob based paths.
	  paths:
		- /home/mysql/3306/data/slow.log
		#- c:\programdata\elasticsearch\logs\*
		

	# ================================== Outputs ===================================

	# Configure what output to use when sending the data collected by the beat.

	# ---------------------------- Elasticsearch Output ----------------------------
	#output.elasticsearch:
	  # Array of hosts to connect to.
	  #hosts: ["192.168.0.45:9200"]

	output.console: 
	  pretty: true
	
	-- 启动 filebeat, 这时会把慢日志输出到 nohup.out 文件中
	nohup ./filebeat &
	-- 会生成文件： -rw-------.  1 root root  1181058 12月 14 01:10 nohup.out






制造慢查询语句
	set global long_query_time=0.1;
	show global variables like '%long_query_time%';
	select * from test_db.t_20201031;


https://www.elastic.co/cn/downloads/beats/filebeat
https://www.elastic.co/guide/en/beats/filebeat/1.0.1/configuration-output.html


https://www.jianshu.com/p/1adfde642cf2
https://www.elastic.co/cn/support/matrix#matrix_jvm  JDK对应关系

https://blog.csdn.net/loveshunyi/article/details/109785488   Centos7 安装 Elasticsearch7.10
https://cloud.tencent.com/developer/article/1349125  如何在CentOS 7上安装和配置Elasticsearch


安装elasticsearch

	yum install java-1.8.0-openjdk.x86_64

	[root@localhost src]# java -version
	openjdk version "1.8.0_272"
	OpenJDK Runtime Environment (build 1.8.0_272-b10)
	OpenJDK 64-Bit Server VM (build 25.272-b10, mixed mode)



	elasticsearch-7.10.1/logs/
	elasticsearch-7.10.1/plugins/
	tar: elasticsearch-7.10.1/jdk/legal/jdk.internal.le/LICENSE: Cannot create symlink to `../java.base/LICENSE': Protocol error
	tar: elasticsearch-7.10.1/jdk/legal/jdk.internal.le/ADDITIONAL_LICENSE_INFO: Cannot create symlink to `../java.base/ADDITIONAL_LICENSE_INFO': Protocol error
	tar: elasticsearch-7.10.1/jdk/legal/jdk.internal.le/ASSEMBLY_EXCEPTION: Cannot create symlink to `../java.base/ASSEMBLY_EXCEPTION': Protocol error
	tar: elasticsearch-7.10.1/jdk/legal/jdk.internal.ed/LICENSE: Cannot create symlink to `../java.base/LICENSE': Protocol error



	./bin/elasticsearch -d
	 
	 
	 
	[root@localhost src]# ps aux|grep elasticsearch
	vagrant  29159 42.0 71.8 1828916 452740 pts/1  Sl   10:17   0:03 /home/vagrant/src/elasticsearch-7.10.1/jdk/bin/java -Xshare:auto -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Djna.nosys=true -XX:-OmitStackTraceInFastThrow -XX:+ShowCodeDetailsInExceptionMessages -Dio.netty.noUnsafe=true -Dio.netty.noKeySetOptimization=true -Dio.netty.recycler.maxCapacityPerThread=0 -Dio.netty.allocator.numDirectArenas=0 -Dlog4j.shutdownHookEnabled=false -Dlog4j2.disable.jmx=true -Djava.locale.providers=SPI,COMPAT -Xms1g -Xmx1g -XX:+UseG1GC -XX:G1ReservePercent=25 -XX:InitiatingHeapOccupancyPercent=30 -Djava.io.tmpdir=/tmp/elasticsearch-8485025882123485039 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=data -XX:ErrorFile=logs/hs_err_pid%p.log -Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m -XX:MaxDirectMemorySize=536870912 -Des.path.home=/home/vagrant/src/elasticsearch-7.10.1 -Des.path.conf=/home/vagrant/src/elasticsearch-7.10.1/config -Des.distribution.flavor=default -Des.distribution.type=tar -Des.bundled_jdk=true -cp /home/vagrant/src/elasticsearc-7.10.1/lib/ org.elasticsearch.bootstrap.Elasticsearch -d
	root     29166  1.0  0.1 112648   960 pts/3    S+   10:17   0:00 grep --color=auto elasticsearch

	[vagrant@localhost elasticsearch-7.10.1]$ curl http://localhost:9200/
	{
	  "name" : "localhost.localdomain",
	  "cluster_name" : "elasticsearch",
	  "cluster_uuid" : "L6oTcu62RBq-5JriZWKr_g",
	  "version" : {
		"number" : "7.10.1",
		"build_flavor" : "default",
		"build_type" : "tar",
		"build_hash" : "1c34507e66d7db1211f66f3513706fdf548736aa",
		"build_date" : "2020-12-05T01:00:33.671820Z",
		"build_snapshot" : false,
		"lucene_version" : "8.7.0",
		"minimum_wire_compatibility_version" : "6.8.0",
		"minimum_index_compatibility_version" : "6.0.0-beta1"
	  },
	  "tagline" : "You Know, for Search"
	}
	
	 curl http://192.168.0.45:9200/
	


kafka 
	kafka 是一个消息队列
	./bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
		-- ps aux|grep  zookeeper
	./bin/kafka-server-start.sh -daemon ./config/server.properties
	
	./bin/kafka-console-producer.sh --broker-list 192.168.0.45:9092 --topic test
		--生产端：从终端输入数据
		--broker-list参数指定了所使用的broker
	
	./bin/kafka-console-consumer.sh --bootstrap-server 192.168.0.45:9092 --topic test
	
	
	./bin/kafka-console-producer.sh --broker-list 127.0.0.1:9092 --topic test
	./bin/kafka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic test
	
	
	./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
	./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test
	
	
	netstat -anltp|grep 9092
	
		[vagrant@localhost config]$ netstat -anltp|grep 9092
		(Not all processes could be identified, non-owned process info
		 will not be shown, you would have to be root to see it all.)
		tcp6       0      0 :::9092                 :::*                    LISTEN      6086/java           
		tcp6       0      0 127.0.0.1:9092          127.0.0.1:42694         ESTABLISHED 6086/java           
		tcp6       0      0 127.0.0.1:42694         127.0.0.1:9092          ESTABLISHED 10274/java          
		tcp6       0      0 127.0.0.1:42695         127.0.0.1:9092          ESTABLISHED 9937/java           
		tcp6       0      0 127.0.0.1:9092          127.0.0.1:42695         ESTABLISHED 6086/java           
		tcp6       0      0 127.0.0.1:9092          127.0.0.1:42690         ESTABLISHED 6086/java           
		tcp6       1      0 127.0.0.1:42632         127.0.0.1:9092          CLOSE_WAIT  6086/java           
		tcp6       0      0 127.0.0.1:42690         127.0.0.1:9092          ESTABLISHED 9937/java 

	
	下面的配置是写在哪里	
		output {
		  kafka {
			bootstrap_servers => '192.168.0.45:9092'
			topic_id => 'slow_query_log'
			codec => json
		  }
		  stdout {}
		}	
		
		[vagrant@localhost config]$ pwd
		/home/vagrant/src/logstash-7.10.1/config

		[vagrant@localhost config]$ cat mysql_slow.conf 
		input {
		  beats {
			port => 5044
			host => "192.168.0.45"
		  } 
		}
		output {
		  kafka {
			bootstrap_servers => '192.168.0.45:9092'
			topic_id => 'slow_query_log'
			codec => json
		  }
		  stdout {}
		}
			
		
		 ./bin/logstash -f ./config/mysql_slow.conf
		 -- 启动 logstash 需要一定的时间
			-- 不是指定mysql.conf
			[vagrant@localhost logstash-7.10.1]$ ./bin/logstash -f ./config/mysql.conf
			Using bundled JDK: /home/vagrant/src/logstash-7.10.1/jdk
			OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.


			WARNING: An illegal reflective access operation has occurred
			WARNING: Illegal reflective access by org.jruby.ext.openssl.SecurityHelper (file:/tmp/jruby-12895/jruby4345788481473972456jopenssl.jar) to field java.security.MessageDigest.provider
			WARNING: Please consider reporting this to the maintainers of org.jruby.ext.openssl.SecurityHelper
			WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
			WARNING: All illegal access operations will be denied in a future release
			Sending Logstash logs to /home/vagrant/src/logstash-7.10.1/logs which is now configured via log4j2.properties
			[2020-12-15T14:13:03,521][INFO ][logstash.runner          ] Starting Logstash {"logstash.version"=>"7.10.1", "jruby.version"=>"jruby 9.2.13.0 (2.5.7) 2020-08-03 9a89c94bcc OpenJDK 64-Bit Server VM 11.0.8+10 on 11.0.8+10 +indy +jit [linux-x86_64]"}
			[2020-12-15T14:13:03,880][INFO ][logstash.setting.writabledirectory] Creating directory {:setting=>"path.queue", :path=>"/home/vagrant/src/logstash-7.10.1/data/queue"}
			[2020-12-15T14:13:03,924][INFO ][logstash.setting.writabledirectory] Creating directory {:setting=>"path.dead_letter_queue", :path=>"/home/vagrant/src/logstash-7.10.1/data/dead_letter_queue"}
			[2020-12-15T14:13:09,170][WARN ][logstash.config.source.multilocal] Ignoring the 'pipelines.yml' file because modules or command line options are specified
			[2020-12-15T14:13:09,232][INFO ][logstash.agent           ] No persistent UUID file found. Generating new UUID {:uuid=>"ea1278a7-806b-441e-9dd2-0f5c15cf753d", :path=>"/home/vagrant/src/logstash-7.10.1/data/uuid"}
			[2020-12-15T14:13:10,201][INFO ][logstash.config.source.local.configpathloader] No config files found in path {:path=>"/home/vagrant/src/logstash-7.10.1/config/mysql.conf"}
			[2020-12-15T14:13:10,271][ERROR][logstash.config.sourceloader] No configuration found in the configured sources.
			[2020-12-15T14:13:13,120][INFO ][logstash.agent           ] Successfully started Logstash API endpoint {:port=>9600}
			[2020-12-15T14:13:15,444][INFO ][logstash.runner          ] Logstash shut down.
			[2020-12-15T14:13:15,499][ERROR][org.logstash.Logstash    ] java.lang.IllegalStateException: Logstash stopped processing because of an error: (SystemExit) exit
		

	./bin/kafka-console-consumer.sh --bootstrap-server 192.168.0.45:9092 --topic slow_query_log 

	
# enable mysql模块
	./filebeat modules enable mysql
	
	[root@localhost filebeat-7.10.1-linux-x86_64]# ./filebeat modules enable mysql
	Enabled mysql


# 设置mysql slow log的路径
	vim ./modules.d/mysql.yml
	slowlog:
	  enabled: true
	  var.paths: ['/home/mysql/3306/data/slow.log']



内存不足	
	[vagrant@localhost elasticsearch-7.10.1]$ curl http://localhost:9200/
	OpenJDK 64-Bit Server VM warning: INFO: os::commit_memory(0x00007f1370930000, 262144, 0) failed; error='Not enough space' (errno=12)
	#
	# There is insufficient memory for the Java Runtime Environment to continue.
	# Native memory allocation (mmap) failed to map 262144 bytes for committing reserved memory.
	# An error report file with more information is saved as:
	# logs/hs_err_pid10966.log
	[144.859s][warning][os,thread] Failed to start thread - pthread_create failed (EAGAIN) for attributes: stacksize: 1024k, guardsize: 0k, detached.
	curl: (7) Failed connect to localhost:9200; Connection refused


	[root@localhost elasticsearch-7.10.1]# free -h
				  total        used        free      shared  buff/cache   available
	Mem:           615M         65M        495M        744K         53M        476M
	Swap:          999M        201M        798M


	curl: (7) Failed connect to localhost:9200; Connection refused
	[vagrant@localhost elasticsearch-7.10.1]$ su root
	Password: 
	[root@localhost elasticsearch-7.10.1]#  dd  if=/dev/zero  of=swapfile  bs=1024  count=500000  
	500000+0 records in
	500000+0 records out
	512000000 bytes (512 MB) copied, 44.0432 s, 11.6 MB/s
	[root@localhost elasticsearch-7.10.1]# mkswap swapfile
	Setting up swapspace version 1, size = 499996 KiB
	no label, UUID=9ec41d63-bf97-4896-9309-e299110c5d4d
	[root@localhost elasticsearch-7.10.1]# swapon  swapfile 
	swapon: /home/vagrant/src/elasticsearch-7.10.1/swapfile: insecure permissions 0777, 0600 suggested.
	swapon: /home/vagrant/src/elasticsearch-7.10.1/swapfile: insecure file owner 1000, 0 (root) suggested.
	swapon: swapfile: swapon failed: Invalid argument

	[root@localhost elasticsearch-7.10.1]# free -h
				  total        used        free      shared  buff/cache   available
	Mem:           615M        181M        375M        904K         57M        358M
	Swap:          999M        136M        863M



GET zst_test_20201215/_search
{
  "query": {
    "match_all": {}
  },
  "sort": [
    {
      "@timestamp": {
        "order": "desc"
      }
    }
  ]
}

result:   --非结构化的数据

	{
	  "took" : 2,
	  "timed_out" : false,
	  "_shards" : {
		"total" : 1,
		"successful" : 1,
		"skipped" : 0,
		"failed" : 0
	  },
	  "hits" : {
		"total" : {
		  "value" : 128,
		  "relation" : "eq"
		},
		"max_score" : null,
		"hits" : [
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "Ol8IZXYBzJofIXW6HcVC",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T15:03:56.098Z",
			  "log" : {
				"offset" : 436,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  },
			  "message" : "# User@Host: root[root] @ localhost []  Id:     4",
			  "input" : {
				"type" : "log"
			  },
			  "host" : {
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"name" : "localhost.localdomain",
				"os" : {
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat",
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				]
			  },
			  "agent" : {
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat",
				"version" : "7.10.1"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  }
			},
			"sort" : [
			  1607958236098
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "O18IZXYBzJofIXW6HcVC",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T15:03:56.098Z",
			  "agent" : {
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat"
			  },
			  "log" : {
				"offset" : 486,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  },
			  "message" : "# Query_time: 12.950610  Lock_time: 0.000113 Rows_sent: 10000  Rows_examined: 510000",
			  "input" : {
				"type" : "log"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "host" : {
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat",
				  "name" : "CentOS Linux"
				},
				"name" : "localhost.localdomain"
			  }
			},
			"sort" : [
			  1607958236098
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "PF8IZXYBzJofIXW6HcVC",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T15:03:56.098Z",
			  "host" : {
				"architecture" : "x86_64",
				"name" : "localhost.localdomain",
				"os" : {
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat",
				  "name" : "CentOS Linux"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain"
			  },
			  "agent" : {
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain"
			  },
			  "log" : {
				"offset" : 571,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  },
			  "message" : "use test_db;",
			  "input" : {
				"type" : "log"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  }
			},
			"sort" : [
			  1607958236098
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "PV8IZXYBzJofIXW6HcVC",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T15:03:56.098Z",
			  "log" : {
				"offset" : 584,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  },
			  "message" : "SET timestamp=1607958233;",
			  "input" : {
				"type" : "log"
			  },
			  "agent" : {
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "host" : {
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"name" : "localhost.localdomain",
				"os" : {
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat",
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false
			  }
			},
			"sort" : [
			  1607958236098
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "Pl8IZXYBzJofIXW6HcVC",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T15:03:56.098Z",
			  "log" : {
				"offset" : 610,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  },
			  "message" : "select * from test_db.t_20201031 order by ismale desc limit 10000;",
			  "input" : {
				"type" : "log"
			  },
			  "agent" : {
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "host" : {
				"name" : "localhost.localdomain",
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false
			  }
			},
			"sort" : [
			  1607958236098
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "OV8IZXYBzJofIXW6HcVC",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T15:03:55.986Z",
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "host" : {
				"id" : "454d1892be164150bed44d3c246cd641",
				"name" : "localhost.localdomain",
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "version" : "7 (Core)",
				  "family" : "redhat",
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos"
				}
			  },
			  "agent" : {
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2"
			  },
			  "log" : {
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				},
				"offset" : 400
			  },
			  "message" : "# Time: 2020-12-14T15:03:53.564477Z",
			  "input" : {
				"type" : "log"
			  }
			},
			"sort" : [
			  1607958235986
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "OF-qZHYBzJofIXW6fMWg",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T13:21:40.084Z",
			  "message" : "Time                 Id Command    Argument",
			  "input" : {
				"type" : "log"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "host" : {
				"hostname" : "localhost.localdomain",
				"name" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "family" : "redhat",
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				]
			  },
			  "agent" : {
				"name" : "localhost.localdomain",
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"
			  },
			  "log" : {
				"offset" : 356,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  }
			},
			"sort" : [
			  1607952100084
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "N1-qZHYBzJofIXW6fMWg",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T13:21:40.082Z",
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "host" : {
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"name" : "localhost.localdomain",
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat",
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core"
				},
				"id" : "454d1892be164150bed44d3c246cd641"
			  },
			  "agent" : {
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat"
			  },
			  "message" : "Tcp port: 3306  Unix socket: /home/mysql/3306/data/3306.sock",
			  "log" : {
				"offset" : 295,
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				}
			  },
			  "input" : {
				"type" : "log"
			  }
			},
			"sort" : [
			  1607952100082
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "Nl-qZHYBzJofIXW6fMWg",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T13:21:39.623Z",
			  "host" : {
				"mac" : [
				  "08:00:27:1b:f5:91"
				],
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)",
				  "family" : "redhat"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"name" : "localhost.localdomain",
				"containerized" : false,
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				]
			  },
			  "agent" : {
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2",
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain"
			  },
			  "message" : "/usr/local/mysql/bin/mysqld, Version: 5.7.22-log (MySQL Community Server (GPL)). started with:",
			  "log" : {
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				},
				"offset" : 200
			  },
			  "input" : {
				"type" : "log"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  }
			},
			"sort" : [
			  1607952099623
			]
		  },
		  {
			"_index" : "zst_test_20201215",
			"_type" : "_doc",
			"_id" : "NF-pZHYBzJofIXW6jcUn",
			"_score" : null,
			"_source" : {
			  "@timestamp" : "2020-12-14T13:20:38.863Z",
			  "log" : {
				"file" : {
				  "path" : "/home/mysql/3306/data/slow.log"
				},
				"offset" : 95
			  },
			  "input" : {
				"type" : "log"
			  },
			  "host" : {
				"hostname" : "localhost.localdomain",
				"architecture" : "x86_64",
				"os" : {
				  "family" : "redhat",
				  "name" : "CentOS Linux",
				  "kernel" : "3.10.0-514.el7.x86_64",
				  "codename" : "Core",
				  "platform" : "centos",
				  "version" : "7 (Core)"
				},
				"id" : "454d1892be164150bed44d3c246cd641",
				"containerized" : false,
				"name" : "localhost.localdomain",
				"ip" : [
				  "192.168.0.201",
				  "fe80::a00:27ff:fe1b:f591"
				],
				"mac" : [
				  "08:00:27:1b:f5:91"
				]
			  },
			  "agent" : {
				"id" : "11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4",
				"name" : "localhost.localdomain",
				"type" : "filebeat",
				"version" : "7.10.1",
				"hostname" : "localhost.localdomain",
				"ephemeral_id" : "bb334c94-b349-4bf9-b3b2-c99540cff7f2"
			  },
			  "ecs" : {
				"version" : "1.6.0"
			  },
			  "message" : "Tcp port: 3306  Unix socket: /home/mysql/3306/data/3306.sock"
			},
			"sort" : [
			  1607952038863
			]
		  }
		]
	  }
	}


[root@localhost data]# tail -f slow.log 
Time                 Id Command    Argument
/usr/local/mysql/bin/mysqld, Version: 5.7.22-log (MySQL Community Server (GPL)). started with:
Tcp port: 3306  Unix socket: /home/mysql/3306/data/3306.sock
Time                 Id Command    Argument
# Time: 2020-12-14T15:03:53.564477Z
# User@Host: root[root] @ localhost []  Id:     4
# Query_time: 12.950610  Lock_time: 0.000113 Rows_sent: 10000  Rows_examined: 510000
use test_db;
SET timestamp=1607958233;
select * from test_db.t_20201031 order by ismale desc limit 10000;




