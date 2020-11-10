from rest_framework import serializers
from .models import Host


class HostSerializer(serializers.Serializer):
    name = serializers.CharField(max_length=30)
    memory = serializers.CharField(max_length=30)
    cpu = serializers.CharField(max_length=30)