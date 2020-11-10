

E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server (master -> origin)
λ pip install pipenv
Collecting pipenv
  Using cached https://files.pythonhosted.org/packages/8b/02/cf3cb144314f56eaf388a83bcf481a3200c9df46ca6ceeecfb6eb4be155a/pipenv-2020.8.13-py2.py3-none-any.whl
Collecting virtualenv (from pipenv)
  Using cached https://files.pythonhosted.org/packages/97/f3/c064343ac58d1a54c393a3f66483a29500f644a5918deeb935d28673edd9/virtualenv-20.1.0-py2.py3-none-any.whl
Collecting pip>=18.0 (from pipenv)
  Downloading https://files.pythonhosted.org/packages/cb/28/91f26bd088ce8e22169032100d4260614fc3da435025ff389ef1d396a433/pip-20.2.4-py2.py3-none-any.whl (1.5MB)
    100% |████████████████████████████████| 1.5MB 73kB/s
Requirement already satisfied: setuptools>=36.2.1 in d:\py\lib\site-packages (from pipenv) (39.0.1)
Collecting virtualenv-clone>=0.2.5 (from pipenv)
  Using cached https://files.pythonhosted.org/packages/83/b8/cd931487d250565392c39409117436d910232c8a3ac09ea2fb62a6c47bff/virtualenv_clone-0.5.4-py2.py3-none-any.whl
Requirement already satisfied: certifi in d:\py\lib\site-packages (from pipenv) (2020.6.20)
Collecting importlib-resources>=1.0; python_version < "3.7" (from virtualenv->pipenv)
  Downloading https://files.pythonhosted.org/packages/24/05/d81725e24bf6028a5753d2eab67d4ee7d8a20a793125727bf87f85e8dffc/importlib_resources-3.2.0-py2.py3-none-any.whl
Requirement already satisfied: filelock<4,>=3.0.0 in d:\py\lib\site-packages (from virtualenv->pipenv) (3.0.12)
Collecting importlib-metadata<3,>=0.12; python_version < "3.8" (from virtualenv->pipenv)
  Downloading https://files.pythonhosted.org/packages/6d/6d/f4bb28424bc677bce1210bc19f69a43efe823e294325606ead595211f93e/importlib_metadata-2.0.0-py2.py3-none-any.whl
Collecting six<2,>=1.9.0 (from virtualenv->pipenv)
  Downloading https://files.pythonhosted.org/packages/ee/ff/48bde5c0f013094d729fe4b0316ba2a24774b3ff1c52d924a8a4cb04078a/six-1.15.0-py2.py3-none-any.whl
Collecting distlib<1,>=0.3.1 (from virtualenv->pipenv)
  Using cached https://files.pythonhosted.org/packages/f5/0a/490fa011d699bb5a5f3a0cf57de82237f52a6db9d40f33c53b2736c9a1f9/distlib-0.3.1-py2.py3-none-any.whl
Collecting appdirs<2,>=1.4.3 (from virtualenv->pipenv)
  Using cached https://files.pythonhosted.org/packages/3b/00/2344469e2084fb287c2e0b57b72910309874c3245463acd6cf5e3db69324/appdirs-1.4.4-py2.py3-none-any.whl
Collecting zipp>=0.4; python_version < "3.8" (from importlib-resources>=1.0; python_version < "3.7"->virtualenv->pipenv)
  Downloading https://files.pythonhosted.org/packages/41/ad/6a4f1a124b325618a7fb758b885b68ff7b058eec47d9220a12ab38d90b1f/zipp-3.4.0-py3-none-any.whl
Installing collected packages: zipp, importlib-resources, importlib-metadata, six, distlib, appdirs, virtualenv, pip, virtualenv-clone, pipenv
  The script virtualenv.exe is installed in 'd:\py\Scripts' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  Found existing installation: pip 10.0.1
    Uninstalling pip-10.0.1:
Could not install packages due to an EnvironmentError: [WinError 5] 拒绝访问。: 'd:\\py\\scripts\\pip.exe'
Consider using the `--user` option or check the permissions.

 --  解决办法：重新安装 pip
 

pip install pipenv -i https://pypi.tuna.tsinghua.edu.cn/simple


django-admin startproject zst_mysql_server

cd zst_mysql_server

pipenv --python 3.6


E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server (master -> origin)
λ pipenv shell
Launching subshell in virtual environment…

E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server (master -> origin)
(zst_mysql_server-7KHOPOWB) λ



pipenv install django 

  File "C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_server-7KHOPOWB\lib\site-packages\pip\_vendor\urllib3\response.py", line 442, in _error_catcher
    raise ReadTimeoutError(self._pool, None, "Read timed out.")
pip._vendor.urllib3.exceptions.ReadTimeoutError: HTTPSConnectionPool(host='pypi.tuna.tsinghua.edu.cn', port=443): Read timed out.
[====]
Installation Failed

	-- url = "https://pypi.douban.com/simple"
	

pipenv install mysqlclient

(zst_mysql_server-7KHOPOWB) λ  python run manager.py
python: can t open file 'run': [Errno 2] No such file or directory


python manage.py runserver



(zst_mysql_server-7KHOPOWB) λ django-admin startapp meta_manage



create  database zst_server DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;


python manage.py makemigrations
python manage.py migrate

python manager.py shell


ManyToOne


--子表插入1行数据

	from meta_manage.models import Host, MySQLSchema
	h = Host.objects.create(name='192.168.0.201', memory='4', cpu='32')
	m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test_db', role='master')


		INSERT INTO `meta_manage_host` (`name`, `memory`, `cpu`) VALUES ('192.168.0.201', '4', 32)
		SELECT * FROM `meta_manage_host` LIMIT 0, 1000
		SHOW COLUMNS FROM `zst_server`.`meta_manage_host`
		INSERT INTO `meta_manage_mysqlschema` (`gmt_update`, `gmt_create`, `host_ip_id`, `port`, `schema`, `role`, `status`) VALUES ('2020-10-26 07:41:28.869438', '2020-10-26 07:41:28.869438', 3, 3306, 'test_db', 'master', 'online')



	-- 查询数据
		
		mysql> select * from meta_manage_host;
		+----+---------------+--------+-----+
		| id | name          | memory | cpu |
		+----+---------------+--------+-----+
		|  3 | 192.168.0.201 | 4      |  32 |
		+----+---------------+--------+-----+
		1 row in set (0.00 sec)

		mysql> select * from meta_manage_mysqlschema;
		+----------------------------+----------------------------+----+------+---------+--------+--------+------------+
		| gmt_update                 | gmt_create                 | id | port | schema  | role   | status | host_ip_id |
		+----------------------------+----------------------------+----+------+---------+--------+--------+------------+
		| 2020-10-26 07:41:28.869438 | 2020-10-26 07:41:28.869438 |  1 | 3306 | test_db | master | online |          3 |
		+----------------------------+----------------------------+----+------+---------+--------+--------+------------+
		1 row in set (0.00 sec)

		
		--正向查询 
			from meta_manage.models import Host, MySQLSchema
			MySQLSchema.objects.filter(host_ip__id=3)
			
			SELECT `meta_manage_mysqlschema`.`gmt_update`, `meta_manage_mysqlschema`.`gmt_create`, `meta_manage_mysqlschema`.`id`, `meta_manage_mysqlschema`.`host_ip_id`, `meta_manage_mysqlschema`.`port`, `meta_manage_mysqlschema`.`schema`, `meta_manage_mysqlschema`.`role`, `meta_manage_mysqlschema`.`status` FROM `meta_manage_mysqlschema` WHERE `meta_manage_mysqlschema`.`host_ip_id` = 3 LIMIT 21
		
		--反向查询 
			--拆分成两个SQL来查询 
			
			from meta_manage.models import Host, MySQLSchema
			h = Host.objects.get(id=3)
			h.mysqlschema_set.all()

			SELECT `meta_manage_host`.`id`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` FROM `meta_manage_host` WHERE `meta_manage_host`.`id` = 3 LIMIT 21
			SELECT `meta_manage_mysqlschema`.`gmt_update`, `meta_manage_mysqlschema`.`gmt_create`, `meta_manage_mysqlschema`.`id`, `meta_manage_mysqlschema`.`host_ip_id`, `meta_manage_mysqlschema`.`port`, `meta_manage_mysqlschema`.`schema`, `meta_manage_mysqlschema`.`role`, `meta_manage_mysqlschema`.`status` FROM `meta_manage_mysqlschema` WHERE `meta_manage_mysqlschema`.`host_ip_id` = 3 LIMIT 21


--子表插入2行数据


	from meta_manage.models import Host, MySQLSchema
	h = Host.objects.create(name='192.168.0.208', memory='4', cpu='32')
	m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test_db', role='master')
	m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test02_db', role='master')

		INSERT INTO `meta_manage_host` (`name`, `memory`, `cpu`) VALUES ('192.168.0.208', '4', 32)
		INSERT INTO `meta_manage_mysqlschema` (`gmt_update`, `gmt_create`, `host_ip_id`, `port`, `schema`, `role`, `status`) VALUES ('2020-10-26 07:56:38.484189', '2020-10-26 07:56:38.484189', 4, 3306, 'test_db', 'master', 'online')
		INSERT INTO `meta_manage_mysqlschema` (`gmt_update`, `gmt_create`, `host_ip_id`, `port`, `schema`, `role`, `status`) VALUES ('2020-10-26 07:56:39.117700', '2020-10-26 07:56:39.117700', 4, 3306, 'test02_db', 'master', 'online')

	select * from meta_manage_host where id=4;
	select * from meta_manage_mysqlschema where host_ip_id=4;

		mysql> select * from meta_manage_host where id=4;
		+----+---------------+--------+-----+
		| id | name          | memory | cpu |
		+----+---------------+--------+-----+
		|  4 | 192.168.0.208 | 4      |  32 |
		+----+---------------+--------+-----+
		1 row in set (0.00 sec)

		mysql> select * from meta_manage_mysqlschema where host_ip_id=4;
		+----------------------------+----------------------------+----+------+-----------+--------+--------+------------+
		| gmt_update                 | gmt_create                 | id | port | schema    | role   | status | host_ip_id |
		+----------------------------+----------------------------+----+------+-----------+--------+--------+------------+
		| 2020-10-26 07:56:38.484189 | 2020-10-26 07:56:38.484189 |  2 | 3306 | test_db   | master | online |          4 |
		| 2020-10-26 07:56:39.117700 | 2020-10-26 07:56:39.117700 |  3 | 3306 | test02_db | master | online |          4 |
		+----------------------------+----------------------------+----+------+-----------+--------+--------+------------+
		2 rows in set (0.00 sec)


	from meta_manage.models import Host, MySQLSchema
	MySQLSchema.objects.filter(host_ip__id=4)

		>>> from meta_manage.models import Host, MySQLSchema
		>>> MySQLSchema.objects.filter(host_ip__id=4)
		<QuerySet [<MySQLSchema: MySQLSchema object (2)>, <MySQLSchema: MySQLSchema object (3)>]>


		SELECT `meta_manage_mysqlschema`.`gmt_update`, `meta_manage_mysqlschema`.`gmt_create`, `meta_manage_mysqlschema`.`id`, `meta_manage_mysqlschema`.`host_ip_id`, `meta_manage_mysqlschema`.`port`, `meta_manage_mysqlschema`.`schema`, `meta_manage_mysqlschema`.`role`, `meta_manage_mysqlschema`.`status` FROM `meta_manage_mysqlschema` WHERE `meta_manage_mysqlschema`.`host_ip_id` = 4 LIMIT 21
		
		SELECT
			`meta_manage_mysqlschema`.`gmt_update`,
			`meta_manage_mysqlschema`.`gmt_create`,
			`meta_manage_mysqlschema`.`id`,
			`meta_manage_mysqlschema`.`host_ip_id`,
			`meta_manage_mysqlschema`.`port`,
			`meta_manage_mysqlschema`.`schema`,
			`meta_manage_mysqlschema`.`role`,
			`meta_manage_mysqlschema`.`status`
		FROM
			`meta_manage_mysqlschema`
		WHERE
			`meta_manage_mysqlschema`.`host_ip_id` = 4
		LIMIT 21

	from meta_manage.models import Host, MySQLSchema
	h = Host.objects.get(id=4)
	h.mysqlschema_set.all()


		>>> from meta_manage.models import Host, MySQLSchema
		>>> h = Host.objects.get(id=4)
		>>> h.mysqlschema_set.all()
		<QuerySet [<MySQLSchema: MySQLSchema object (2)>, <MySQLSchema: MySQLSchema object (3)>]>


		SELECT `meta_manage_host`.`id`, `meta_manage_host`.`name`, `meta_manage_host`.`memory`, `meta_manage_host`.`cpu` FROM `meta_manage_host` WHERE `meta_manage_host`.`id` = 4 LIMIT 21
		SELECT `meta_manage_mysqlschema`.`gmt_update`, `meta_manage_mysqlschema`.`gmt_create`, `meta_manage_mysqlschema`.`id`, `meta_manage_mysqlschema`.`host_ip_id`, `meta_manage_mysqlschema`.`port`, `meta_manage_mysqlschema`.`schema`, `meta_manage_mysqlschema`.`role`, `meta_manage_mysqlschema`.`status` FROM `meta_manage_mysqlschema` WHERE `meta_manage_mysqlschema`.`host_ip_id` = 4 LIMIT 21


	思考：如何改为 join 查询 
	


-- 删除数据
	from meta_manage.models import Host, MySQLSchema
	Host.objects.filter(id=3).delete()
	
		>>> Host.objects.filter(id=3).delete()
		(2, {'meta_manage.MySQLSchema': 1, 'meta_manage.Host': 1})
		
		DELETE FROM `meta_manage_mysqlschema` WHERE `meta_manage_mysqlschema`.`host_ip_id` IN (3)
		DELETE FROM `meta_manage_host` WHERE `meta_manage_host`.`id` IN (3)

		
---------------------------------------------------------------

改写save()方法

方式1
    def save(self, *args, **kwargs):
        exist = MySQLSchema.objects.filter(host_ip=self.host_ip, port=self.port, schema=self.schema, role=self.role).exists()
        if exist:
            raise ValidationError("repeat data　－" + str(self))
        super().save(self, *args, **kwargs)
		
		
	from meta_manage.models import Host, MySQLSchema
	h = Host.objects.create(name='192.168.0.203', memory='4', cpu='32')
	m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test_db', role='master')

	>>> from meta_manage.models import Host, MySQLSchema
	>>> h = Host.objects.create(name='192.168.0.203', memory='4', cpu='32')
	>>> m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test_db', role='master')
	Traceback (most recent call last):
	  File "<console>", line 1, in <module>
	  File "C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_server-7KHOPOWB\lib\site-packages\django\db\models\manager.py", line 85, in manager_method
		return getattr(self.get_queryset(), name)(*args, **kwargs)
	  File "C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_server-7KHOPOWB\lib\site-packages\django\db\models\query.py", line 447, in create
		obj.save(force_insert=True, using=self.db)
	  File "E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server\meta_manage\models.py", line 42, in save
		super().save(self, *args, **kwargs)
	TypeError: save() got multiple values for argument 'force_insert'
	
	-- 这种方式不行

方式2
    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        exists = MySQLSchema.objects.filter(
            host_ip=self.host_ip,
            port=self.port,
            schema=self.schema,
            role=self.role).exists() # objects是一个模型管理器，默认的模型管理
        if exists:
            raise ValidationError("repeat data for " + str(self))

        super().save(force_insert=force_insert, force_update=force_update, using=using,update_fields=update_fields)


	>>> from meta_manage.models import Host, MySQLSchema
	>>> h = Host.objects.create(name='192.168.0.204', memory='4', cpu='32')
	>>> m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test_db', role='master')
	>>> m = MySQLSchema.objects.create(host_ip=h, port=int(3306), schema='test_db', role='master')
	Traceback (most recent call last):
	  File "<console>", line 1, in <module>
	  File "C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_server-7KHOPOWB\lib\site-packages\django\db\models\manager.py", line 85, in manager_method
		return getattr(self.get_queryset(), name)(*args, **kwargs)
	  File "C:\Users\Administrator.SC-202007271117\.virtualenvs\zst_mysql_server-7KHOPOWB\lib\site-packages\django\db\models\query.py", line 447, in create
		obj.save(force_insert=True, using=self.db)
	  File "E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server\meta_manage\models.py", line 53, in save
		raise ValidationError("repeat data for " + str(self))
	django.core.exceptions.ValidationError: ['repeat data for MySQLSchema-Host object (8)-3306-test_db-master']
	
	
	INSERT INTO `meta_manage_host` (`name`, `memory`, `cpu`) VALUES ('192.168.0.204', '4', 32)
	SELECT (1) AS `a` FROM `meta_manage_mysqlschema` WHERE (`meta_manage_mysqlschema`.`host_ip_id` = 8 AND `meta_manage_mysqlschema`.`port` = 3306 AND `meta_manage_mysqlschema`.`role` = 'master' AND `meta_manage_mysqlschema`.`schema` = 'test_db') LIMIT 1
	INSERT INTO `meta_manage_mysqlschema` (`gmt_update`, `gmt_create`, `host_ip_id`, `port`, `schema`, `role`, `status`) VALUES ('2020-10-26 08:30:17.841749', '2020-10-26 08:30:17.841749', 8, 3306, 'test_db', 'master', 'online')




第二次实践、学习、听课，对Django的知识会比之前理解得更好。


E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server (master -> origin)
(zst_mysql_server-7KHOPOWB) λ python manage.py createsuperuser
Username (leave blank to use 'administrator'):
Email address:
Operation cancelled.

E:\github\python_note\2020-09-05-Python-ZST-4200-new\zst_mysql_server (master -> origin)
(zst_mysql_server-7KHOPOWB) λ python manage.py createsuperuser
Username (leave blank to use 'administrator'): admin
Email address: 1224056230@qq.com
Password:
Password (again):
This password is too common.
Bypass password validation and create user anyway? [y/N]: y
Superuser created successfully.



