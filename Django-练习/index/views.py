from django.shortcuts import render
from django.http import HttpResponse, Http404

from index.models import Users

import logging

logger = logging.getLogger('default')


# Create your views here.

def index(request):
    return HttpResponse("Hello world")

