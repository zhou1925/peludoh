from django.db import models

from core.models import TimeStampedModel
from django.contrib.auth import get_user_model


User = get_user_model()


class Notification(TimeStampedModel):
    """ Notification model """
    MARKED_READ = "r"
    MARKED_UNREAD = "u"

    CHOICES = ((MARKED_READ, "read"), (MARKED_UNREAD, "unread"))

    user = models.ForeignKey(
        User, related_name="notifications", on_delete=models.CASCADE
    )
    title = models.CharField(max_length=250, blank=True, null=True)
    body = models.TextField(blank=True, null=True)
    status = models.CharField(choices=CHOICES, default=MARKED_UNREAD, max_length=1)

    def __str__(self) -> str:
        """ str representation """
        return self.title
    
    class Meta:
        verbose_name = 'Notificacion'
        verbose_name_plural = 'Notificaciones'