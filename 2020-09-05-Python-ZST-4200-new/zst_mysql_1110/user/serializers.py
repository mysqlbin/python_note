
from rest_framework import serializers
from rest_framework.exceptions import ValidationError

def max_length(value):
    if not isinstance(value, str):
        raise ValidationError('value is not a string')

    if len(value) > 10:
        raise ValidationError('value length is greater than 10')

    return True

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(required=True, max_length=60, min_length=2, validators=[max_length])
    password = serializers.CharField(required=True, max_length=60, min_length=6)


