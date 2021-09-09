from rest_framework import serializers
from .models import SlowQuery, SlowQueryHistory

class SlowQuerySerializer(serializers.ModelSerializer):

    # checksum = serializers.CharField(source='mysql_slow_query_review_history.CHECKSUM')

    # ForeignKey字段
    # teacher = serializers.CharField(source='teacher.name')

    class Meta:
        model = SlowQuery
        fields = '__all__'


class SlowQueryHistorySerializer(serializers.ModelSerializer):

    # SlowQueryHistory = serializers.CharField(source='mysql_slow_query_review_history.CHECKSUM')
    # checksum = SlowQuerySerializer(read_only=True)
    # ForeignKey字段
    # checksum = serializers.CharField(source='mysql_slow_query_review.CHECKSUM')

    class Meta:
        model = SlowQueryHistory
        # fields = '__all__'
        fields = ['checksum', 'ts_cnt', 'rows_examined_sum']