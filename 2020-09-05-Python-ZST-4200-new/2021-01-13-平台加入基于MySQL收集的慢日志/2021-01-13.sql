


django-admin startapp slowquery

python manage.py makemigrations
python manage.py migrate


(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ python manage.py makemigrations
Migrations for 'slowquery':
  slowquery/migrations/0001_initial.py
    - Create model SlowQuery
    - Create model SlowQueryHistory
	
(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, check, contenttypes, meta_manage, sessions, slowquery
Running migrations:
  Applying slowquery.0001_initial... OK


INSERT INTO `django_content_type` (`app_label`, `model`) VALUES ('slowquery', 'slowquery'), ('slowquery', 'slowqueryhistory')

INSERT INTO `auth_permission` (`name`, `content_type_id`, `codename`) VALUES ('Can add 慢日志统计', 13, 'add_slowquery'), 
('Can change 慢日志统计', 13, 'change_slowquery'), ('Can delete 慢日志统计', 13, 'delete_slowquery'), 
('Can view 慢日志统计', 13, 'view_slowquery'), ('Can add 慢日志明细', 14, 'add_slowqueryhistory'), 
('Can change 慢日志明细', 14, 'change_slowqueryhistory'), ('Can delete 慢日志明细', 14, 'delete_slowqueryhistory'), 
('Can view 慢日志明细', 14, 'view_slowqueryhistory')


https://blog.csdn.net/weixin_44685869/article/details/102690814


https://blog.csdn.net/qq_44955537/article/details/103279928


https://www.656463.com/wenda/zDjangoRESTkjzxlhyddgx_529

http://ask.sov5.cn/q/MWtEJzdkVD



/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/rest_framework/pagination.py:200: UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list: <class 'slowquery.models.SlowQueryHistory'> QuerySet.
  paginator = self.django_paginator_class(queryset, page_size)
  