from django.shortcuts import render
from django.http import HttpResponse, Http404

from index.models import Users

import logging

logger = logging.getLogger('default')

# Create your views here.

def index(request):
    return HttpResponse("Hello world")

def create_user(request):
    """
    CREATE TABLE `index_users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `gmt_update` datetime(6) DEFAULT NULL,
    `gmt_create` datetime(6) DEFAULT NULL,
    `first_name` varchar(30) NOT NULL,
    `last_name` varchar(30) NOT NULL,
    `email` varchar(254) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    """
    sql_user = Users.objects.create(
        first_name = "lujianbin_01",
        last_name= "lujianbin_02",
        email = "122405623@qq.com"
    )
    
    logger.warning(sql_user.id)
    logger.warning(type(sql_user))
    return HttpResponse("create user succss")

def update_user(request):
    
    id = 200
    try:
        u = Users.objects.get(id=id)
    # except Users.DoesNotExist:
    except:
        # raise Http404
        error_info = 'users.id={} not exist'.format(id)
        logger.warning(error_info)
        return HttpResponse(error_info)

    u.email = '13202095158@163.com'
    u.save()

    return HttpResponse("update user success")

