


filebeat
logstash
kafka
	zookeeper
基于soar，用go获取指纹
python读取kafka
es




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
	
	
	

