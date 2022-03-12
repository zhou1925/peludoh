from django.contrib import admin
from .models import Cart, CartItem


class CartItemInline(admin.TabularInline):
    model = CartItem
    raw_id_fields = ['product']


@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ['id','user', 'timestamp', 'used', ]
    list_filter = ['user', 'timestamp','used']
    inlines = [CartItemInline]