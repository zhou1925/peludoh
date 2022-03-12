from rest_framework.serializers import (
    ModelSerializer,)

from .models import Appointment
from users.serializers import UserSerializer

class AppointmentDetailSerializer(ModelSerializer):
    """
    Serializer Detail of Appointment Model
    """
    user = UserSerializer()
    class Meta:
        model = Appointment
        fields = (
            'id',
            'user',
            'service',
            'date',
            'time',
            'status',
            'created',
            'updated_at',
        )

class AppointmentSerializer(ModelSerializer):
    """
    Serializer of Appointment Model
    """
    class Meta:
        model = Appointment
        fields = (
            'id',
            'service',
            'date',
            'time',
            'status',
            'created',
        )

class AppointmentUpdateSerializer(ModelSerializer):
    """
    Serializer to Update status field
    """
    class Meta:
        model = Appointment
        fields = ["status",]