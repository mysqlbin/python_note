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



https://blog.csdn.net/weixin_43835659/article/details/105440199



celery -A zst_mysql_1110 beat -l INFO   问题记录——celery的beat报错：UnpicklingError





https://github.com/pydanny/cookiecutter-django/issues/1793

https://www.pythonheidong.com/blog/article/444259/a829bdaecbbb42ebba1a/


https://www.pythonheidong.com/blog/article/444259/a829bdaecbbb42ebba1a/

https://github.com/pydanny/cookiecutter-django/issues/1793

(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ celery -A zst_mysql_1110 beat
celery beat v5.0.3 (singularity) is starting.
__    -    ... __   -        _
LocalTime -> 2021-01-22 17:42:02
Configuration ->
    . broker -> redis://:**@192.168.0.252:6379/8
    . loader -> celery.loaders.app.AppLoader
    . scheduler -> celery.beat.PersistentScheduler
    . db -> celerybeat-schedule
    . logfile -> [stderr]@%WARNING
    . maxinterval -> 5.00 minutes (300s)
[2021-01-22 17:42:02,813: ERROR/MainProcess] Removing corrupted schedule file 'celerybeat-schedule': error(22, 'Invalid argument')
											 -- 删除损坏的计划文件“ celerybeat-schedule”：错误（22，“无效参数”）
Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/kombu/utils/objects.py", line 41, in __get__
    return obj.__dict__[self.__name__]
KeyError: 'scheduler'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 515, in setup_schedule
    self._store = self._open_schedule()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 505, in _open_schedule
    return self.persistence.open(self.schedule_filename, writeback=True)
  File "/usr/local/lib/python3.6/shelve.py", line 243, in open
    return DbfilenameShelf(filename, flag, protocol, writeback)
  File "/usr/local/lib/python3.6/shelve.py", line 227, in __init__
    Shelf.__init__(self, dbm.open(filename, flag), protocol, writeback)
  File "/usr/local/lib/python3.6/dbm/__init__.py", line 94, in open
    return mod.open(file, flag, mode)
_gdbm.error: [Errno 22] Invalid argument
[2021-01-22 17:42:02,819: CRITICAL/MainProcess] beat raised exception <class '_gdbm.error'>: error(22, 'Invalid argument')
Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/kombu/utils/objects.py", line 41, in __get__
    return obj.__dict__[self.__name__]
KeyError: 'scheduler'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 515, in setup_schedule
    self._store = self._open_schedule()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 505, in _open_schedule
    return self.persistence.open(self.schedule_filename, writeback=True)
  File "/usr/local/lib/python3.6/shelve.py", line 243, in open
    return DbfilenameShelf(filename, flag, protocol, writeback)
  File "/usr/local/lib/python3.6/shelve.py", line 227, in __init__
    Shelf.__init__(self, dbm.open(filename, flag), protocol, writeback)
  File "/usr/local/lib/python3.6/dbm/__init__.py", line 94, in open
    return mod.open(file, flag, mode)
_gdbm.error: [Errno 22] Invalid argument

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/apps/beat.py", line 105, in start_scheduler
    service.start()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 618, in start
    humanize_seconds(self.scheduler.max_interval))
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/kombu/utils/objects.py", line 43, in __get__
    value = obj.__dict__[self.__name__] = self.__get(obj)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 662, in scheduler
    return self.get_scheduler()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 657, in get_scheduler
    lazy=lazy,
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 497, in __init__
    Scheduler.__init__(self, *args, **kwargs)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 253, in __init__
    self.setup_schedule()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 523, in setup_schedule
    self._store = self._destroy_open_corrupted_schedule(exc)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 511, in _destroy_open_corrupted_schedule
    return self._open_schedule()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/celery/beat.py", line 505, in _open_schedule
    return self.persistence.open(self.schedule_filename, writeback=True)
  File "/usr/local/lib/python3.6/shelve.py", line 243, in open
    return DbfilenameShelf(filename, flag, protocol, writeback)
  File "/usr/local/lib/python3.6/shelve.py", line 227, in __init__
    Shelf.__init__(self, dbm.open(filename, flag), protocol, writeback)
  File "/usr/local/lib/python3.6/dbm/__init__.py", line 94, in open
    return mod.open(file, flag, mode)
_gdbm.error: [Errno 22] Invalid argument


pipenv install python3.6-gdbm




(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ pipenv uninstall celery
Uninstalling celery...
No package celery to remove from Pipfile.
Locking [dev-packages] dependencies...
Locking [packages] dependencies...
✔ Success! 
Updated Pipfile.lock (043893)!
(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ pipenv install celery==5.0.3
Installing celery==5.0.3...
✔ Installation Succeeded 
Pipfile.lock (043893) out of date, updating to (b38c15)...
Locking [dev-packages] dependencies...
Locking [packages] dependencies...
✔ Success! 
Updated Pipfile.lock (b38c15)!
Installing dependencies from Pipfile.lock (b38c15)...
  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 1/1 — 00:
  
  