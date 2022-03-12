from rest_framework import serializers
from .models import Notification

class NotificationSerializer(serializers.ModelSerializer):
    """
    Notification Serializer
    """
    class Meta:
        model = Notification
        fields = ["title", "body"]


class NotificationMiniSerializer(serializers.ModelSerializer):
    """
    Notification mini Serializer
    """
    class Meta:
        model = Notification
        fields = ["id", "user", "title", "body", "status"]