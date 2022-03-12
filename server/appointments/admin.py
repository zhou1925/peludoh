from django.contrib import admin

from .models import Appointment

@admin.register(Appointment)
class AppointmentAdmin(admin.ModelAdmin):
    list_display = ['id','user', 'date', 'timeslot', 'status', 'created']
    list_filter = ['created', 'status']
    list_editable = ['timeslot', 'status']
