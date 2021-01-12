(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ celery -A zst_mysql_1110 worker -l INFO

 
 -------------- celery@localhost.localdomain v5.0.3 (singularity)
--- ***** ----- 
-- ******* ---- Linux-3.10.0-327.4.5.el7.x86_64-x86_64-with-centos-7.2.1511-Core 2020-12-10 06:56:23
- *** --- * --- 
- ** ---------- [config]
- ** ---------- .> app:         zst_mysql_1110:0x7f00ebb0c0b8
- ** ---------- .> transport:   redis://:**@192.168.0.252:6379/8
- ** ---------- .> results:     redis://:**@192.168.0.252:6379/8
- *** --- * --- .> concurrency: 2 (prefork)
-- ******* ---- .> task events: OFF (enable -E to monitor tasks in this worker)
--- ***** ----- 
 -------------- [queues]
                .> celery           exchange=celery(direct) key=celery
                

[tasks]
  . meta_manage.tasks.add
  . zst_mysql_1110.celery.debug_task

[2020-12-10 06:56:23,546: INFO/MainProcess] Connected to redis://:**@192.168.0.252:6379/8
[2020-12-10 06:56:23,570: INFO/MainProcess] mingle: searching for neighbors


[2020-12-10 06:56:24,625: INFO/MainProcess] mingle: all alone
[2020-12-10 06:56:24,663: WARNING/MainProcess] /home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/fixups/django.py:204: UserWarning: Using settings.DEBUG leads to a memory
            leak, never use this setting in production environments!
  leak, never use this setting in production environments!'')

[2020-12-10 06:56:24,663: INFO/MainProcess] celery@localhost.localdomain ready.


[2020-12-10 06:56:49,507: INFO/MainProcess] Received task: meta_manage.tasks.add[afb720ba-1147-464a-ae69-0af6ced80ad8]  
[2020-12-10 06:56:49,541: INFO/ForkPoolWorker-1] Task meta_manage.tasks.add[afb720ba-1147-464a-ae69-0af6ced80ad8] succeeded in 0.013944395001090015s: 4



celery multi stop w1 -A proj -l info
celery multi stop -A zst_mysql_1110 worker -l INFO

delay()
	调用任务 
	
AsyncResult()
	获取执行结果，不需要等到任务执行完成才能获取结果，因为需要查看任务的状态
	
	
group()
	一个 group 并行调用任务列表，返回一个特殊的结果实例，可以将结果作为一个列表进行查看，并且通过索引进去获取返回值。
	
	多个任务的并行调用;
	通过group()先把多个任务创建好，然后再调用delay()调用任务
	
chain()
	任务是串行执行的，前一个任务执行完成，后一个任务才能执行;
		

函数签名
	https://www.celerycn.io/yong-hu-zhi-nan/canvas-she-ji-gong-zuo-liu-cheng-canvas-designing-workflows/qian-ming-signatures

