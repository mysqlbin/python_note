from rest_framework import serializers
from .models import Host,MySQLSchema


class HostSerializer(serializers.Serializer):
    # 字段的声明类似于模型的声明，只返回这３个字段的数据
    name = serializers.CharField(max_length=30)
    memory = serializers.CharField(max_length=30)
    cpu = serializers.CharField(max_length=30)

    def create(self, validated_data):
        h = Host(**validated_data)
        h.save()
        return h

    def update(self, instance, validated_data):
        # validated_data.pop('name')
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        return instance


class MySQLSchemaSerializer(serializers.ModelSerializer):
    class Meta:
        model = MySQLSchema
        fields = '__all__'
