from django.contrib import admin

from .models import Pet

@admin.register(Pet)
class AdminPet(admin.ModelAdmin):
    list_display = ['id','name', 'age', 'race', 'gender']
    list_editable = ['name', 'age', 'race', 'gender']
    list_filter = ['name', 'age', 'race', 'gender']
