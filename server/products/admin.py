from django.contrib import admin

from .models import Product, Tag

class ProductAdmin(admin.ModelAdmin):
    list_display = ['__str__', 'slug', 'price', 'active']
    search_fields = ['title']
    prepopulated_fields = {'slug': ('title',)}
    list_editable = ['price', 'active']
    class meta:
        model = Product

admin.site.register(Product, ProductAdmin)


@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ['title', 'slug', 'active', 'timestamp']
    list_editable = ['active']
    list_filter = ['active']
    prepopulated_fields = {'slug': ('title',)}
