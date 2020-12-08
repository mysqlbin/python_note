"""
Django settings for zst_mysql_1110 project.

Generated by 'django-admin startproject' using Django 3.0.6.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.0/ref/settings/
"""

import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'f-m5=u@hh0l@w&2ki&ni0u*y4wh^$#k3ta4q!w-kwj0z4v=0rb'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['192.168.0.51', '127.0.0.1']


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
<<<<<<< HEAD
    'HOST': '192.168.1.201',  # mysql服务所在的主机ip
=======
    'HOST': '192.168.0.201',  # mysql服务所在的主机ip
>>>>>>> 03647656bc28100385ce82c7c38b95da8cec0767
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

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


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



CELERY_BROKER_URL = 'redis://:niuniu_redis@192.168.0.252:6379/8' # Broker配置，使用Redis作为消息中间件

CELERY_RESULT_BACKEND = 'redis://:niuniu_redis@192.168.0.252:6379/8'  # BACKEND配置，这里使用redis

CELERY_RESULT_SERIALIZER = 'json'  # 结果序列化方案

