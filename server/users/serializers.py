from rest_framework import serializers
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model


User = get_user_model()

class ChangePasswordSerializer(serializers.Serializer):
    """
    Serializer to update password
    """
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer of User model
    """

    class Meta:
        model = User
        fields = ('id', 'username', 'password')
        extra_kwargs = {'password': { 'write_only': True, 'required': False}}
    
    def create(self, validated_data):
        """ return user with token """
        user = User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        user.set_password(validated_data['password'])
        user.save()
        return user