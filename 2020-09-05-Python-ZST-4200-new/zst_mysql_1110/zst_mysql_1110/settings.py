"""
Django settings for zst_mysql_1110 project.

Generated by 'django-admin startproject' using Django 3.0.6.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.0/ref/settings/
"""

import os
from elasticsearch_dsl import connections

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'f-m5=u@hh0l@w&2ki&ni0u*y4wh^$#k3ta4q!w-kwj0z4v=0rb'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['192.168.0.45', '127.0.0.1', 'localhost']


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'meta_manage.apps.MetaManageConfig',
    'user.apps.UserConfig',
    'check.apps.CheckConfig',
    'slowsql.apps.SlowsqlConfig',
    'slowquery.apps.SlowqueryConfig',
    'alertinfo.apps.AlertinfoConfig',
    'django_filters',
    # 'corsheaders',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    # 'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'zst_mysql_1110.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'zst_mysql_1110.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
#     }
# }

DATABASES = {
    'default': {
    'ENGINE': 'django.db.backends.mysql',  # 数据库引擎
    'NAME': 'zst_mysql_1110',  # 数据库名，先前创建的
    'USER': 'root',  # 用户名，可以自己创建用户
    'PASSWORD': '123456abc',  # 密码
    # 'HOST': '192.168.1.27',  # mysql服务所在的主机ip
    'HOST': '192.168.0.201',  # mysql服务所在的主机ip
    'PORT': '3306',  # mysql服务端口
    }
}


# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'Asia/Shanghai'
# TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

# USE_TZ = True
USE_TZ = False


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = '/static/'
#
# AUTHENTICATION_BACKENDS = ["user.ldap_backends.LdapBackend"]
#
# ZST_LDAP_HOST = 'ldap://127.0.0.1:10389'
# ZST_LDAP_ADMIN_BIND_DN = 'uid=admin,ou=system'
# ZST_LDAP_ADMIN_PASSWD = 'secret'


REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        # 'rest_framework.authentication.TokenAuthentication',
        'zst_mysql_1110.auth.CsrfExemptSessionAuthentication',
    ],

    'EXCEPTION_HANDLER': 'zst_mysql_1110.response.my_api_exception_handler'
}

# CORS_ALLOWED_ORIGINS = [
#     "http://localhost:8080"
# ]


# CORS_ORIGIN_ALLOW_ALL = True



CELERY_BROKER_URL = 'redis://:aiuaiu_rds@192.168.0.252:6379/9'      # Broker配置，使用Redis作为消息中间件
CELERY_RESULT_BACKEND = 'redis://:aiuaiu_rds@192.168.0.252:6379/9'  # BACKEND配置，这里使用redis，改为MySQL，更方便查询
CELERY_ACCEPT_CONTENT = ['application/json']
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'   # 结果序列化方案
CELERY_TIMEZONE = "Asia/Shanghai"
CELERY_TASK_TIME_LIMIT = 30 * 60


connections.create_connection(hosts=['192.168.0.45:9200'], timeout=60)


# LOG配置
BASE_LOG_DIR = os.path.join(BASE_DIR, "log")
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    # 日志文件的格式
    'formatters': {
        # 详细的日志格式
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
        # 简单的日志格式
        'simple': {
            'format': '%(levelname)s %(asctime)s %(module)s %(message)s'
        },
    },
    # 处理器
	# 日志输出方式;共3种, logging.StreamHandler终端输出， logging.handlers.TimedRotatingFileHandler 时间格式文件记录（分割），
	# logging.handlers.RotatingFileHandler 文件大小格式记录（分割）

    'handlers': {
        #打印SQL语句，方便开发
        'sql': {
            'level': 'DEBUG',
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'filename': os.path.join(BASE_LOG_DIR, "sql_info.log"),
            'when': 'midnight',              # 按天分割日志文件
			'interval': 1,
            'backupCount': 7,
            'formatter': 'verbose',
        },
        #在终端打印
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
        },
        # 默认的
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'filename': os.path.join(BASE_LOG_DIR, "record_info.log"),
            'when': 'midnight',              # 按天分割日志文件
			'interval': 1,
            'backupCount': 7,
            'formatter': 'verbose',
        },
    },

    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': 'INFO',
			'propagate': True,
        },
        # 打印SQL语句
        'django.db.backends': {
            'handlers': ['sql'],
            'level': 'DEBUG',
            'propagate': True,

        },
    }
}

