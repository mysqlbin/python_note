
-------------------


filebeat 所在机器：192.168.0.201 
ES 所在机器：     192.168.0.45





kibana      http://192.168.0.45:5601/
elasticsearch.hosts: ["http://192.168.0.45:9200"]



filebeat
es
logstash
kibana
kafka
	配置zookeeper
基于soar，用go获取指纹
python读取kafka
logstash、kibana的关系
	filebeat写入完日志到ES后，接下来通过kibana查看
	使用logstash收集完日志后，接下来通过kibana查看
	
es做全文搜索


安装 filebeat、es、kibana
	要用同一个版本
	
	
1. filebeat
2. 安装elasticsearch
3. 安装kafka 
4. 安装和配置Logstash	
5. 问题和解决
6. 相关参考
7. 小结
8. 安装go
9. Linux安装soar
	

1. filebeat

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
	nohup ./filebeat 1>/dev/null 2>&1 &
	-- 会生成文件： -rw-------.  1 root root  1181058 12月 14 01:10 nohup.out


	
	# enable mysql模块
		./filebeat modules enable mysql
		
		[root@localhost filebeat-7.10.1-linux-x86_64]# ./filebeat modules enable mysql
		Enabled mysql


	# 设置mysql slow log的路径
		vim ./modules.d/mysql.yml
		slowlog:
		  enabled: true
		  var.paths: ['/home/mysql/3306/data/slow.log']




制造慢查询语句
	set global long_query_time=0.1;
	show global variables like '%long_query_time%';
	select * from test_db.t_20201031;


2. 安装elasticsearch

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
	


3. 安装kafka 
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
	
	
	[vagrant@localhost kafka_2.12-2.6.0]$ cat config/server.properties 
	############################# Socket Server Settings #############################

	listeners=PLAINTEXT://192.168.0.45:9092

	advertised.listeners=PLAINTEXT://192.168.0.45:9092

	pip install kafka-python
	
	
4. 安装和配置Logstash	
	
	4.1 输入配置和输出配置
		[vagrant@localhost config]$ pwd
		/home/vagrant/src/logstash-7.10.1/config
		[vagrant@localhost config]$ cat mysql_slow.conf
		输入配置
		-- 从Filebeat中读取数据，需要声明监听的地址和端口，filebeat那边则需要修改output		
		input {
		  beats {
			port => 5044
			host => "192.168.0.45"
		  } 
		}
		输出配置
		-- kafka配置
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
		
	4.2 查看kafka消费慢查询日志的情况 
		
		./bin/kafka-console-consumer.sh --bootstrap-server 192.168.0.45:9092 --topic slow_query_log 
		{"ecs":{"version":"1.6.0"},"agent":{"hostname":"localhost.localdomain","ephemeral_id":"42e578f9-e2c6-42a8-825f-89bf2ea78360","type":"filebeat","name":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4","version":"7.10.1"},"tags":["beats_input_codec_plain_applied"],"@version":"1","@timestamp":"2020-12-15T10:27:35.068Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":2243},"input":{"type":"log"},"message":"# Time: 2020-12-15T10:27:33.810174Z","host":{"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"name":"localhost.localdomain","containerized":false,"id":"454d1892be164150bed44d3c246cd641","architecture":"x86_64","os":{"platform":"centos","name":"CentOS Linux","family":"redhat","kernel":"3.10.0-514.el7.x86_64","version":"7 (Core)","codename":"Core"}}}
		{"ecs":{"version":"1.6.0"},"agent":{"hostname":"localhost.localdomain","ephemeral_id":"42e578f9-e2c6-42a8-825f-89bf2ea78360","type":"filebeat","name":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4","version":"7.10.1"},"tags":["beats_input_codec_plain_applied"],"@version":"1","@timestamp":"2020-12-15T10:27:35.070Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":2279},"input":{"type":"log"},"message":"# User@Host: root[root] @ localhost []  Id:     4","host":{"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"name":"localhost.localdomain","containerized":false,"id":"454d1892be164150bed44d3c246cd641","architecture":"x86_64","os":{"platform":"centos","name":"CentOS Linux","kernel":"3.10.0-514.el7.x86_64","family":"redhat","version":"7 (Core)","codename":"Core"}}}
		{"ecs":{"version":"1.6.0"},"agent":{"ephemeral_id":"42e578f9-e2c6-42a8-825f-89bf2ea78360","hostname":"localhost.localdomain","type":"filebeat","name":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4","version":"7.10.1"},"tags":["beats_input_codec_plain_applied"],"@version":"1","@timestamp":"2020-12-15T10:27:35.071Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":2329},"input":{"type":"log"},"message":"# Query_time: 0.313522  Lock_time: 0.000073 Rows_sent: 4000  Rows_examined: 504000","host":{"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"name":"localhost.localdomain","containerized":false,"id":"454d1892be164150bed44d3c246cd641","architecture":"x86_64","os":{"platform":"centos","name":"CentOS Linux","kernel":"3.10.0-514.el7.x86_64","family":"redhat","version":"7 (Core)","codename":"Core"}}}
		{"ecs":{"version":"1.6.0"},"agent":{"hostname":"localhost.localdomain","ephemeral_id":"42e578f9-e2c6-42a8-825f-89bf2ea78360","type":"filebeat","name":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4","version":"7.10.1"},"tags":["beats_input_codec_plain_applied"],"@version":"1","@timestamp":"2020-12-15T10:27:35.071Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":2412},"input":{"type":"log"},"message":"SET timestamp=1608028053;","host":{"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"name":"localhost.localdomain","containerized":false,"id":"454d1892be164150bed44d3c246cd641","architecture":"x86_64","os":{"platform":"centos","name":"CentOS Linux","kernel":"3.10.0-514.el7.x86_64","family":"redhat","version":"7 (Core)","codename":"Core"}}}
		{"ecs":{"version":"1.6.0"},"agent":{"hostname":"localhost.localdomain","ephemeral_id":"42e578f9-e2c6-42a8-825f-89bf2ea78360","type":"filebeat","name":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4","version":"7.10.1"},"tags":["beats_input_codec_plain_applied"],"@version":"1","@timestamp":"2020-12-15T10:27:35.071Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":2438},"input":{"type":"log"},"message":"select * from test_db.t_20201031 order by ismale desc limit 4000;","host":{"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"name":"localhost.localdomain","containerized":false,"id":"454d1892be164150bed44d3c246cd641","architecture":"x86_64","os":{"platform":"centos","name":"CentOS Linux","family":"redhat","kernel":"3.10.0-514.el7.x86_64","version":"7 (Core)","codename":"Core"}}}
		{"fileset":{"name":"slowlog"},"tags":["beats_input_codec_plain_applied"],"service":{"type":"mysql"},"message":"# User@Host: root[root] @ localhost []  Id:     4\n# Query_time: 0.313522  Lock_time: 0.000073 Rows_sent: 4000  Rows_examined: 504000\nSET timestamp=1608028053;\nselect * from test_db.t_20201031 order by ismale desc limit 4000;","ecs":{"version":"1.5.0"},"agent":{"hostname":"localhost.localdomain","ephemeral_id":"42e578f9-e2c6-42a8-825f-89bf2ea78360","type":"filebeat","name":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4","version":"7.10.1"},"event":{"dataset":"mysql.slowlog","module":"mysql"},"@version":"1","@timestamp":"2020-12-15T10:27:35.092Z","log":{"flags":["multiline"],"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":2279},"input":{"type":"log"},"host":{"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"name":"localhost.localdomain","containerized":false,"id":"454d1892be164150bed44d3c246cd641","architecture":"x86_64","os":{"platform":"centos","name":"CentOS Linux","kernel":"3.10.0-514.el7.x86_64","family":"redhat","version":"7 (Core)","codename":"Core"}}}
		

		--对应的慢查询日志
		# Time: 2020-12-15T10:27:33.810174Z
		# User@Host: root[root] @ localhost []  Id:     4
		# Query_time: 0.313522  Lock_time: 0.000073 Rows_sent: 4000  Rows_examined: 504000
		SET timestamp=1608028053;
		select * from test_db.t_20201031 order by ismale desc limit 4000;
		
		
	4.3 Filter配置--grok
		
		http://doc.yonyoucloud.com/doc/logstash-best-practice-cn/filter/grok.html
		https://github.com/elastic/logstash/blob/v1.4.2/patterns/grok-patterns
		
		USERNAME [a-zA-Z0-9._-]+
		USER %{USERNAME}
		USER 是 USERNAME的1个别名，也就是grok预定义表达式的一个名称 
		
		示例
			sample data		
				# Time: 2020-12-15T10:27:33.810174Z
				# User1@Host: root1[root2] @ localhost []  Id:     4
				# Query_time: 0.313522  Lock_time: 0.000073 Rows_sent: 4000  Rows_examined: 504000
				SET timestamp=1608028053;
				select * from test_db.t_20201031 order by ismale desc limit 4000;
				
			Grok Pattern
				^# User1@Host: %{USER:slowlog1.user}

			Structured Data
				{
				  "slowlog1": {
					"user": "root"
				  }
				}
			
			Grok Pattern
				^# User1@Host: %{USERNAME:slowlog1.user}
			
			Structured Data
				{
				  "slowlog1": {
					"user": "root1"
				  }
				}			
			
			-------------------------------------	
			
			Grok Pattern	
				%{NUMBER:slowlog.query_time.sec}
				
			Structured Data
				{
				  "slowlog": {
					"query_time": {
					  "sec": "0.313522"
					}
				  }
				}
				
			-------------------------------------	
			Grok Pattern
				^# User1@Host: %{USER:slowlog1_user}

			Structured Data
				{
				  "slowlog1_user": "root1"
				}


^# User@Host: %{USER:slowlog.user}(\[[^\]]+\])? @ (%{HOSTNAME:slowlog.host})? \[%{IP:slowlog.ip}?\](\s*Id:\s* %{NUMBER:slowlog.id})?\n# Query_time: 
%{NUMBER:slowlog.query_time.sec}\s* Lock_time: %{NUMBER:slowlog.lock_time.sec}\s* Rows_sent: 
%{NUMBER:slowlog.rows_sent}\s* Rows_examined: %{NUMBER:slowlog.rows_examined}\n(SET 
timestamp=%{NUMBER:slowlog.timestamp};\n)?%{GREEDYMULTILINE:slowlog.query}

慢查询
# User@Host: root[root] @ localhost [192.168.0.218]  Id:     4
# Query_time: 0.313522  Lock_time: 0.000073 Rows_sent: 4000  Rows_examined: 504000
SET timestamp=1608028053;
select * from test_db.t_20201031 order by ismale desc limit 4000;

成功的filter grok：
^# User@Host: %{USER:slowlog.user}(\[[^\]]+\])? @ (%{HOSTNAME:slowlog.host})? \[%{IP:slowlog.ip}?\](\s*Id:\s* %{NUMBER:slowlog.id})

失败的filter grok：
^# User@Host: %{USER:slowlog.user}(\[[^\]]+\])? @ (%{HOSTNAME:slowlog.host})? \[%{IP:slowlog.ip}?\](\s*Id:\s* %{NUMBER:slowlog.id})?\n# Query_time: %{NUMBER:slowlog.query_time.sec}\s

				
5. 问题和解决

	1. 内存不足	
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


	2. 文件描述符大小不足

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

	3. Kibana 5601端口已经被占用
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



kibana

	nohup ./bin/kibana 1>/dev/null 2>&1 &



6. 相关参考 
	https://www.elastic.co/cn/downloads/beats/filebeat
	https://www.elastic.co/guide/en/beats/filebeat/1.0.1/configuration-output.html


	https://www.jianshu.com/p/1adfde642cf2
	https://www.elastic.co/cn/support/matrix#matrix_jvm  JDK对应关系

	https://blog.csdn.net/loveshunyi/article/details/109785488   Centos7 安装 Elasticsearch7.10
	https://cloud.tencent.com/developer/article/1349125  如何在CentOS 7上安装和配置Elasticsearch
	
	
	http://doc.yonyoucloud.com/doc/logstash-best-practice-cn/filter/grok.html
	https://github.com/elastic/logstash/blob/v1.4.2/patterns/grok-patterns
	
7. 小结
	启动 logstash 需要一定的时间，不要操之过急
	
	
8. 安装go

	tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz
	
	vim /etc/profile
	export GOROOT=/usr/local/go
	export GOPATH=/home/vagrant/src/go
	export PATH=$PATH:/usr/local/go/bin
	source /etc/profile
	
	[root@localhost soar]# go version
	go version go1.15.6 linux/amd64


	https://blog.csdn.net/qq_33398607/article/details/106099939  Goland使用Go Modules创建/管理项目
	
	/home/vagrant/src/go/my_test

9. Linux安装soar
	
	相关参考

		https://www.cnblogs.com/-pengfei/articles/11580315.html
		https://github.com/XiaoMi/soar/blob/master/doc/install.md
		https://www.cnblogs.com/brady-wang/p/12980463.html


	基本路径
		[vagrant@localhost src]$ echo $GOPATH
		/home/vagrant/src/go

			
		[vagrant@localhost src]$ pwd
		/home/vagrant/src/go/src


	生成二进制文件
		go get -d github.com/XiaoMi/soar

		cd ${GOPATH}/src/github.com/XiaoMi/soar && make

		[vagrant@localhost src]$ cd ${GOPATH}/src/github.com/XiaoMi/soar && make
		Go version check ...
		go version 1.12+ required, found: go version go1.11.11 linux/amd64
		make: *** [go_version_check] Error 1
		[vagrant@localhost soar]$ cd ${GOPATH}/src/github.com/XiaoMi/soar && make
		Go version check ...
		go version check pass
		Run gofmt on all source files ...
		gofmt -l -s -w ...
		/home/vagrant/src/go/src/github.com/XiaoMi/soar/ast/token_test.go
		Building ...
		build Success!

		
		------------------------------------------------------------------------

		[vagrant@localhost src]$ cd ${GOPATH}/src/github.com/XiaoMi/soar && make
		Go version check ...
		go version 1.12+ required, found: go version go1.11.11 linux/amd64
		make: *** [go_version_check] Error 1

	安装后的目录
	
		[vagrant@localhost bin]$ pwd
		/home/vagrant/src/go/src/github.com/XiaoMi/soar/bin

		

	创建软连接到/usr/local/bin/   目录
		[root@localhost soar]# ln -s /home/vagrant/src/go/src/github.com/XiaoMi/soar/bin/soar /usr/local/bin/soar
		[root@localhost soar]# soar
		Args format error, use --help see how to use it!
	
	验证soar是否可用
		[root@localhost soar]# echo 'select * from film' | soar
		# Query: 687D590364E29465

		★ ★ ★ ☆ ☆ 75分

		```sql

		SELECT  
		  * 
		FROM  
		  film
		```

		## 最外层 SELECT 未指定 WHERE 条件

		* **Item:**  CLA.001

		* **Severity:**  L4

		* **Content:**  SELECT 语句没有 WHERE 子句，可能检查比预期更多的行(全表扫描)。对于 SELECT COUNT(\*) 类型的请求如果不要求精度，建议使用 SHOW TABLE STATUS 或 EXPLAIN 替代。

		## 不建议使用 SELECT * 类型查询

		* **Item:**  COL.001

		* **Severity:**  L1

		* **Content:**  当表结构变更时，使用 \* 通配符选择所有列将导致查询的含义和行为会发生更改，可能导致查询返回更多的数据。




	golang启动一个简单的http服务
		[vagrant@localhost server]$ go run server.go 



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






Exiting: Failed to start crawler: creating module reloader failed: Can only start an input when all related states are finished:



{'@version': '1', 'agent': {'name': 'localhost.localdomain', 'id': '11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4', 'version': '7.10.1', 'type': 'filebeat', 'hostname': 'localhost.localdomain', 'ephemeral_id': 'a30e334a-03e0-4800-901d-c31f0e07ec3b'}, 'tags': ['beats_input_codec_plain_applied'], 'log': {'file': {'path': '/home/mysql/3306/data/slow.log'}, 'offset': 13794}, 'message': '# Time: 2021-01-08T06:52:42.466791Z', 'input': {'type': 'log'}, '@timestamp': '2021-01-08T06:52:46.258Z', 'ecs': {'version': '1.6.0'}, 'host': {'containerized': False, 'ip': ['192.168.0.201', 'fe80::a00:27ff:fe1b:f591'], 'os': {'kernel': '3.10.0-514.el7.x86_64', 'family': 'redhat', 'name': 'CentOS Linux', 'platform': 'centos', 'version': '7 (Core)', 'codename': 'Core'}, 'name': 'localhost.localdomain', 'mac': ['08:00:27:1b:f5:91'], 'id': '454d1892be164150bed44d3c246cd641', 'architecture': 'x86_64', 'hostname': 'localhost.localdomain'}}
Traceback (most recent call last):
  File "consumer_kafka.py", line 36, in <module>
    "sql": slow_log['slowlog.query']
KeyError: 'slowlog.query'




读取配置文件错误
	[vagrant@localhost logstash-7.10.1]$ ./bin/logstash -f ./config/mysql.conf^C
	[vagrant@localhost logstash-7.10.1]$ ps aux|grep logstash
	vagrant  20919  0.0  0.0 112648   956 pts/9    S+   08:33   0:00 grep --color=auto logstash
	[vagrant@localhost logstash-7.10.1]$ ./bin/logstash -f ./config/mysql.conf
	Using bundled JDK: /home/vagrant/src/logstash-7.10.1/jdk
	OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.



	WARNING: An illegal reflective access operation has occurred
	WARNING: Illegal reflective access by org.jruby.ext.openssl.SecurityHelper (file:/tmp/jruby-20920/jruby11600420282765220637jopenssl.jar) to field java.security.MessageDigest.provider
	WARNING: Please consider reporting this to the maintainers of org.jruby.ext.openssl.SecurityHelper
	WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
	WARNING: All illegal access operations will be denied in a future release








	Sending Logstash logs to /home/vagrant/src/logstash-7.10.1/logs which is now configured via log4j2.properties
	[2021-01-08T08:36:23,823][INFO ][logstash.runner          ] Starting Logstash {"logstash.version"=>"7.10.1", "jruby.version"=>"jruby 9.2.13.0 (2.5.7) 2020-08-03 9a89c94bcc OpenJDK 64-Bit Server VM 11.0.8+10 on 11.0.8+10 +indy +jit [linux-x86_64]"}
	[2021-01-08T08:36:29,536][WARN ][logstash.config.source.multilocal] Ignoring the 'pipelines.yml' file because modules or command line options are specified
	[2021-01-08T08:36:30,421][INFO ][logstash.config.source.local.configpathloader] No config files found in path {:path=>"/home/vagrant/src/logstash-7.10.1/config/mysql.conf"}
	[2021-01-08T08:36:30,460][ERROR][logstash.config.sourceloader] No configuration found in the configured sources.
	[2021-01-08T08:36:33,566][INFO ][logstash.agent           ] Successfully started Logstash API endpoint {:port=>9600}
	[2021-01-08T08:36:35,705][INFO ][logstash.runner          ] Logstash shut down.
	[2021-01-08T08:36:35,746][ERROR][org.logstash.Logstash    ] java.lang.IllegalStateException: Logstash stopped processing because of an error: (SystemExit) exit

select * from t_20201030 limit 28500;

[vagrant@localhost kafka_2.12-2.6.0]$ ./bin/kafka-console-consumer.sh --bootstrap-server 192.168.0.45:9092 --topic slow_query_log

	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":8943},"@timestamp":"2021-01-08T09:15:19.993Z","input":{"type":"log"},"message":"# Time: 2021-01-08T09:15:17.720854Z","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":8979},"@timestamp":"2021-01-08T09:15:20.001Z","input":{"type":"log"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"architecture":"x86_64","os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"containerized":false,"mac":["08:00:27:1b:f5:91"],"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9033},"@timestamp":"2021-01-08T09:15:20.001Z","input":{"type":"log"},"message":"# Query_time: 0.366003  Lock_time: 0.000069 Rows_sent: 28500  Rows_examined: 28500","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","architecture":"x86_64","os":{"name":"CentOS Linux","family":"redhat","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"containerized":false,"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9116},"@timestamp":"2021-01-08T09:15:20.001Z","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"message":"SET timestamp=1610097317;","@version":"1","input":{"type":"log"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"architecture":"x86_64","os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"containerized":false,"mac":["08:00:27:1b:f5:91"],"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9142},"@timestamp":"2021-01-08T09:15:20.001Z","input":{"type":"log"},"message":"select * from t_20201030 limit 28500;","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"os":{"name":"CentOS Linux","family":"redhat","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9180},"@timestamp":"2021-01-08T09:15:20.001Z","input":{"type":"log"},"message":"# Time: 2021-01-08T09:15:17.735647Z","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","architecture":"x86_64","os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"containerized":false,"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9216},"@timestamp":"2021-01-08T09:15:20.001Z","input":{"type":"log"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9270},"@timestamp":"2021-01-08T09:15:20.001Z","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"message":"# Query_time: 0.001142  Lock_time: 0.000107 Rows_sent: 15  Rows_examined: 318","@version":"1","input":{"type":"log"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"architecture":"x86_64","os":{"name":"CentOS Linux","family":"redhat","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"containerized":false,"mac":["08:00:27:1b:f5:91"],"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9348},"@timestamp":"2021-01-08T09:15:20.001Z","input":{"type":"log"},"message":"SET timestamp=1610097317;","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"architecture":"x86_64","os":{"name":"CentOS Linux","family":"redhat","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"containerized":false,"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9374},"@timestamp":"2021-01-08T09:15:20.002Z","input":{"type":"log"},"message":"SELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID;","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9474},"@timestamp":"2021-01-08T09:15:20.002Z","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"message":"# Time: 2021-01-08T09:15:17.736917Z","@version":"1","input":{"type":"log"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","architecture":"x86_64","os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"containerized":false,"mac":["08:00:27:1b:f5:91"],"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9510},"@timestamp":"2021-01-08T09:15:20.002Z","input":{"type":"log"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9564},"@timestamp":"2021-01-08T09:15:20.002Z","input":{"type":"log"},"message":"# Query_time: 0.000970  Lock_time: 0.000135 Rows_sent: 16  Rows_examined: 316","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9642},"@timestamp":"2021-01-08T09:15:20.002Z","input":{"type":"log"},"message":"SET timestamp=1610097317;","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","architecture":"x86_64","os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"containerized":false,"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9668},"@timestamp":"2021-01-08T09:15:20.002Z","input":{"type":"log"},"message":"SELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/0.366144*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=66 GROUP BY STATE ORDER BY SEQ;","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","id":"454d1892be164150bed44d3c246cd641"},"fileset":{"name":"slowlog"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":8979,"flags":["multiline"]},"input":{"type":"log"},"agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7\n# Query_time: 0.366003  Lock_time: 0.000069 Rows_sent: 28500  Rows_examined: 28500\nSET timestamp=1610097317;\nselect * from t_20201030 limit 28500;","@version":"1","ecs":{"version":"1.5.0"},"service":{"type":"mysql"},"@timestamp":"2021-01-08T09:15:20.014Z","event":{"dataset":"mysql.slowlog","module":"mysql"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"fileset":{"name":"slowlog"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9216,"flags":["multiline"]},"input":{"type":"log"},"agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7\n# Query_time: 0.001142  Lock_time: 0.000107 Rows_sent: 15  Rows_examined: 318\nSET timestamp=1610097317;\nSELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID;","@version":"1","ecs":{"version":"1.5.0"},"service":{"type":"mysql"},"@timestamp":"2021-01-08T09:15:20.015Z","event":{"dataset":"mysql.slowlog","module":"mysql"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}
	{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"fileset":{"name":"slowlog"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":9510,"flags":["multiline"]},"input":{"type":"log"},"agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7\n# Query_time: 0.000970  Lock_time: 0.000135 Rows_sent: 16  Rows_examined: 316\nSET timestamp=1610097317;\nSELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/0.366144*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=66 GROUP BY STATE ORDER BY SEQ;","@version":"1","ecs":{"version":"1.5.0"},"service":{"type":"mysql"},"@timestamp":"2021-01-08T09:15:20.015Z","event":{"dataset":"mysql.slowlog","module":"mysql"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}


(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ python consumer_kafka.py 
got a message b'{"host":{"name":"localhost.localdomain","ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"hostname":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"os":{"family":"redhat","name":"CentOS Linux","platform":"centos","codename":"Core","version":"7 (Core)","kernel":"3.10.0-514.el7.x86_64"},"id":"454d1892be164150bed44d3c246cd641"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":8943},"@timestamp":"2021-01-08T09:15:19.993Z","input":{"type":"log"},"message":"# Time: 2021-01-08T09:15:17.720854Z","@version":"1","agent":{"name":"localhost.localdomain","hostname":"localhost.localdomain","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","type":"filebeat","version":"7.10.1","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"ecs":{"version":"1.6.0"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"]}'
{'host': {'name': 'localhost.localdomain', 'ip': ['192.168.0.201', 'fe80::a00:27ff:fe1b:f591'], 'hostname': 'localhost.localdomain', 'containerized': False, 'architecture': 'x86_64', 'mac': ['08:00:27:1b:f5:91'], 'os': {'family': 'redhat', 'name': 'CentOS Linux', 'platform': 'centos', 'codename': 'Core', 'version': '7 (Core)', 'kernel': '3.10.0-514.el7.x86_64'}, 'id': '454d1892be164150bed44d3c246cd641'}, 'log': {'file': {'path': '/home/mysql/3306/data/slow.log'}, 'offset': 8943}, '@timestamp': '2021-01-08T09:15:19.993Z', 'input': {'type': 'log'}, 'message': '# Time: 2021-01-08T09:15:17.720854Z', '@version': '1', 'agent': {'name': 'localhost.localdomain', 'hostname': 'localhost.localdomain', 'ephemeral_id': '7eeffb74-c498-484e-91ee-4881f73e340d', 'type': 'filebeat', 'version': '7.10.1', 'id': '11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4'}, 'ecs': {'version': '1.6.0'}, 'tags': ['beats_input_codec_plain_applied', '_grokparsefailure']}
Traceback (most recent call last):
  File "consumer_kafka.py", line 37, in <module>
    "sql": slow_log['slowlog.query']
KeyError: 'slowlog.query'





{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":13640},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","platform":"centos","name":"CentOS Linux","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":13777,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","platform":"centos","name":"CentOS Linux","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"SET timestamp=1610099485;","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":13841},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# Time: 2021-01-08T09:51:25.337452Z","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":13877,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","platform":"centos","name":"CentOS Linux","codename":"Core","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":13931},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","platform":"centos","name":"CentOS Linux","codename":"Core","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# Query_time: 0.001384  Lock_time: 0.000111 Rows_sent: 15  Rows_examined: 318","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":14009,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"SET timestamp=1610099485;","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":13604,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# Time: 2021-01-08T09:51:25.322919Z","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":13694},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","platform":"centos","name":"CentOS Linux","codename":"Core","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# Query_time: 0.298154  Lock_time: 0.000084 Rows_sent: 26300  Rows_examined: 26300","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":13803,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","platform":"centos","name":"CentOS Linux","codename":"Core","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"select * from t_20201030 limit 26300;","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":14035,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","family":"redhat","version":"7 (Core)"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"SELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID;","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":14135},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# Time: 2021-01-08T09:51:25.338784Z","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":14171,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","family":"redhat","version":"7 (Core)"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":14225,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","platform":"centos","name":"CentOS Linux","codename":"Core","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# Query_time: 0.000940  Lock_time: 0.000127 Rows_sent: 16  Rows_examined: 316","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":14303},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","family":"redhat","version":"7 (Core)"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"SET timestamp=1610099485;","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"offset":14329,"file":{"path":"/home/mysql/3306/data/slow.log"}},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","name":"CentOS Linux","platform":"centos","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"SELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/0.298208*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=111 GROUP BY STATE ORDER BY SEQ;","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.153Z","fileset":{"name":"slowlog"},"event":{"dataset":"mysql.slowlog","module":"mysql"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7\n# Query_time: 0.298154  Lock_time: 0.000084 Rows_sent: 26300  Rows_examined: 26300\nSET timestamp=1610099485;\nselect * from t_20201030 limit 26300;","ecs":{"version":"1.5.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"flags":["multiline"],"offset":13640},"host":{"os":{"codename":"Core","platform":"centos","name":"CentOS Linux","kernel":"3.10.0-514.el7.x86_64","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"service":{"type":"mysql"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.153Z","fileset":{"name":"slowlog"},"event":{"dataset":"mysql.slowlog","module":"mysql"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7\n# Query_time: 0.001384  Lock_time: 0.000111 Rows_sent: 15  Rows_examined: 318\nSET timestamp=1610099485;\nSELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID;","ecs":{"version":"1.5.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"flags":["multiline"],"offset":13877},"host":{"os":{"codename":"Core","platform":"centos","name":"CentOS Linux","kernel":"3.10.0-514.el7.x86_64","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"architecture":"x86_64","mac":["08:00:27:1b:f5:91"],"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"service":{"type":"mysql"}}
{"@version":"1","@timestamp":"2021-01-08T09:51:30.153Z","fileset":{"name":"slowlog"},"event":{"dataset":"mysql.slowlog","module":"mysql"},"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7\n# Query_time: 0.000940  Lock_time: 0.000127 Rows_sent: 16  Rows_examined: 316\nSET timestamp=1610099485;\nSELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/0.298208*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=111 GROUP BY STATE ORDER BY SEQ;","ecs":{"version":"1.5.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"},"log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"flags":["multiline"],"offset":14171},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","platform":"centos","name":"CentOS Linux","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","containerized":false,"mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"service":{"type":"mysql"}}


got a message b'{"@version":"1","@timestamp":"2021-01-08T09:51:30.123Z","log":{"file":{"path":"/home/mysql/3306/data/slow.log"},"offset":13640},"host":{"os":{"kernel":"3.10.0-514.el7.x86_64","codename":"Core","platform":"centos","name":"CentOS Linux","version":"7 (Core)","family":"redhat"},"ip":["192.168.0.201","fe80::a00:27ff:fe1b:f591"],"name":"localhost.localdomain","mac":["08:00:27:1b:f5:91"],"architecture":"x86_64","containerized":false,"hostname":"localhost.localdomain","id":"454d1892be164150bed44d3c246cd641"},"input":{"type":"log"},"tags":["beats_input_codec_plain_applied","_grokparsefailure"],"message":"# User@Host: root[root] @  [192.168.0.220]  Id:     7","ecs":{"version":"1.6.0"},"agent":{"type":"filebeat","name":"localhost.localdomain","version":"7.10.1","ephemeral_id":"7eeffb74-c498-484e-91ee-4881f73e340d","hostname":"localhost.localdomain","id":"11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4"}}'
{'@version': '1', '@timestamp': '2021-01-08T09:51:30.123Z', 'log': {'file': {'path': '/home/mysql/3306/data/slow.log'}, 'offset': 13640}, 'host': {'os': {'kernel': '3.10.0-514.el7.x86_64', 'codename': 'Core', 'platform': 'centos', 'name': 'CentOS Linux', 'version': '7 (Core)', 'family': 'redhat'}, 'ip': ['192.168.0.201', 'fe80::a00:27ff:fe1b:f591'], 'name': 'localhost.localdomain', 'mac': ['08:00:27:1b:f5:91'], 'architecture': 'x86_64', 'containerized': False, 'hostname': 'localhost.localdomain', 'id': '454d1892be164150bed44d3c246cd641'}, 'input': {'type': 'log'}, 'tags': ['beats_input_codec_plain_applied', '_grokparsefailure'], 'message': '# User@Host: root[root] @  [192.168.0.220]  Id:     7', 'ecs': {'version': '1.6.0'}, 'agent': {'type': 'filebeat', 'name': 'localhost.localdomain', 'version': '7.10.1', 'ephemeral_id': '7eeffb74-c498-484e-91ee-4881f73e340d', 'hostname': 'localhost.localdomain', 'id': '11cfd0c3-ef60-4be0-815c-5bbbd9bb3de4'}}
Traceback (most recent call last):
  File "consumer_kafka.py", line 37, in <module>
    "sql": slow_log['slowlog.query']
	
	
	[2021-01-09T02:07:32,445][ERROR][logstash.agent           ] Failed to execute action {:action=>LogStash::PipelineAction::Create/pipeline_id:main, :exception=>"LogStash::ConfigurationError", :message=>"Expected one of [ \\t\\r\\n], \"#\", \"=>\" at line 28, column 9 (byte 836) after filter {\r\n\tgrok {\r\n\t\tmatch => { \"message\" => [\"^# User@Host: %{USER:slowlog.user}(\\[[^\\]]+\\])? @ \r\n\t\t(%{HOSTNAME:slowlog.host})? \\[%{IP:slowlog.ip}?\\](\\s*Id:\\s* %{NUMBER:slowlog.id})?\\n# Query_time: \r\n\t\t%{NUMBER:slowlog.query_time.sec}\\s* Lock_time: %{NUMBER:slowlog.lock_time.sec}\\s* Rows_sent: \r\n\t\t%{NUMBER:slowlog.rows_sent}\\s* Rows_examined: %{NUMBER:slowlog.rows_examined}\\n(SET \r\n\t\ttimestamp=%{NUMBER:slowlog.timestamp};\\n)?%{GREEDYMULTILINE:slowlog.query}\"]}\r\n\t\tpattern_definitions => {\r\n\t\t\t\"GREEDYMULTILINE\" => \"(.|\\n)*\"\r\n\t\t}\r\n\t\tremove_field => \"message\"\r\n\t}\r\n\tdate {\r\n\t\tmatch => [ \"slowlog.timestamp\", \"UNIX\" ]\r\n\t}\r\n\tmutate {\r\n\t\tgsub => [\"slowlog.query\", \"\\n# Time: [0-9]+ [0-9][0-9]:[0-9][0-9]:[0-9][0-9](\\\\.[0-9]+)?$\", \"\"]\r\n}\r\n\r\noutput {\r\n  kafka ", :backtrace=>["/home/vagrant/src/logstash-7.10.1/logstash-core/lib/logstash/compiler.rb:32:in `compile_imperative'", "org/logstash/execution/AbstractPipelineExt.java:184:in `initialize'", "org/logstash/execution/JavaBasePipelineExt.java:69:in `initialize'", "/home/vagrant/src/logstash-7.10.1/logstash-core/lib/logstash/java_pipeline.rb:47:in `initialize'", "/home/vagrant/src/logstash-7.10.1/logstash-core/lib/logstash/pipeline_action/create.rb:52:in `execute'", "/home/vagrant/src/logstash-7.10.1/logstash-core/lib/logstash/agent.rb:365:in `block in converge_state'"]}



# Time: 2021-01-11T16:19:16.635657+08:00
# User@Host: root[root] @  [192.168.0.202]  Id:    10
# Query_time: 0.358495  Lock_time: 0.120588 Rows_sent: 1  Rows_examined: 500000
SET timestamp=1610353156;
select count(*) from t_20210111;

^# User@Host: %{USER:slowlog.user}(\[[^\]]+\])? @ (%{HOSTNAME:slowlog.host})? \[%{IP:slowlog.ip}?\]


{
  "slowlog": {
    "user": "root",
    "ip": "192.168.0.202"
  }
}

--------------------------------------------------------------------------------------------------------
# Time: 2021-01-11T16:23:52.860888+08:00
# User@Host: root[root] @ localhost []  Id:    11
# Query_time: 0.174356  Lock_time: 0.000107 Rows_sent: 1  Rows_examined: 500000
SET timestamp=1610353432;

^# User@Host: %{USER:slowlog.user}(\[[^\]]+\])? @ (%{HOSTNAME:slowlog.host})? \[%{IP:slowlog.ip}?\]

select count(*) from t_20210111;
{
  "slowlog": {
    "host": "localhost",
    "user": "root"
  }
}



