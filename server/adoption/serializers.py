from rest_framework import serializers

from .models import Pet

class PetSerializer(serializers.ModelSerializer):
    """
    Serializer of Pet Model
    """
    class Meta:
        model = Pet
        fields = ['id', 'photo', 'photo_url',
                'name', 'age', 'race', 'gender']