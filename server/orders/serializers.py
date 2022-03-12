from rest_framework import serializers
from rest_framework.fields import IntegerField

from cart.serializers import CartSerializer
from users.serializers import UserSerializer
from .models import Order


class OrderSerializer(serializers.ModelSerializer):
    """
    Serializer of Order model
    """
    class Meta:
        model = Order
        fields = [
            'id',
            'order_code',
            'name',
            'phone',
            'address_line_1',
            'address_line_2',
            'status',
            'timestamp',
            'shipping_total',
            'cart_total',
            'tax_total',
            'total'
        ]


class DetailedOrderSerializer(serializers.ModelSerializer):
    """
    Serializer of Order object
    """
    user = UserSerializer()
    cart = CartSerializer()

    class Meta:
        model = Order
        fields = [
            'id',
            'user',
            'name',
            'phone',
            'address_line_1',
            'address_line_2',
            'order_code',
            'cart',
            'status',
            'timestamp',
            'shipping_total',
            'cart_total',
            'tax_total',
            'total',
            'total_in_pen',
        ]

        total_in_pen = IntegerField(source='total_in_pen')


class OrderUpdateSerializer(serializers.ModelSerializer):
    """
    Serializer to update order status
    """
    class Meta:
        model = Order
        fields = ["status",]