python manage.py createsuperuser


E:\github\python_note\2020-08-01-Python-ZST-4200\2020-09-04-Django\messages (master -> origin)
λ python manage.py createsuperuser
System check identified some issues:

WARNINGS:
?: (urls.W005) URL namespace 'admin' isn t unique. You may not be able to reverse all URLs in this namespace
Username (leave blank to use 'administrator'): mysqlbin
Email address: 1224056230@qq.com
Password:
Password (again):
This password is too common.
Bypass password validation and create user anyway? [y/N]: y
Superuser created successfully.


password: 123456abc


INSERT INTO `auth_user` (
	`password`,
	`last_login`,
	`is_superuser`,
	`username`,
	`first_name`,
	`last_name`,
	`email`,
	`is_staff`,
	`is_active`,
	`date_joined`
)
VALUES
	(
		'pbkdf2_sha256$180000$CpBXpjE9mZ6w$Od9kuKEjZDVcPtuESxWyLfRZwKBd2+n3yJVD1nSabws=',
		NULL,
		1,
		'mysqlbin',
		'',
		'',
		'1224056230@qq.com',
		1,
		1,
		'2020-09-10 08:13:32.230384'
	)