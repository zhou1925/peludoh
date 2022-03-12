from rest_framework import serializers
from rest_framework.fields import Field, ListField, SerializerMethodField

from .models import Product, Tag


class TagSerializer(serializers.ModelSerializer):
    """
    Serialize Tag model
    """
    class Meta:
        model = Tag
        fields = ['title', 'slug', 'product']


class ProductSerializer(serializers.HyperlinkedModelSerializer):
    """
    Serialize Product mdoel with tag list
    """
    tag_list = TagSerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = ['id', 'photo', 'photo_url', 'title', 'slug', 
                'description', 'price', "tag_list"]

class NormalProductSerializer(serializers.ModelSerializer):
    """
    Normal Product Serializer
    """

    class Meta:
        model = Product
        fields = '__all__'


class CategorySerializer(serializers.ModelSerializer):
    """
    Serialize Category. Tag model 
    """
    
    product = NormalProductSerializer(
        many=True,
        read_only=True
    )
        
    class Meta:
        model = Tag
        exclude = ('timestamp', )