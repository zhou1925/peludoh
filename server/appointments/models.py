from django.db import models

from users.models import User
from .utils import TIMESLOT_LIST, SERVICES, STATUSES

class Appointment(models.Model):
    user = models.ForeignKey(
        User, related_name="appointments", on_delete=models.CASCADE
    )
    service = models.CharField(max_length=32, choices=SERVICES)
    date = models.DateField()
    timeslot = models.IntegerField(choices=TIMESLOT_LIST)
    status = models.CharField(choices=STATUSES, default='creado', max_length=15)
    created = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return '{} {} {} {} {}'.format(self.user, self.time, self.date, self.service, self.timeslot)
    
    class Meta:
        ordering = ('-created',)
        verbose_name = 'Cita'
        verbose_name_plural = 'Citas'

    @property
    def time(self):
        """Extracting the string from the list"""
        return self.TIMESLOT_LIST[self.timeslot][1]