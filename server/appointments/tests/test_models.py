from random import sample
from django.test import TestCase
from django.contrib.auth import get_user_model

from ..models import Appointment


User = get_user_model()


def sample_user(username='usernametest', password='userpassword'):
    """Create a simple user"""
    return User.objects.create_user(username, password)

def sample_appointment():
    """ create appointment"""
    user = sample_user()
    service='aseo'
    date='2022-02-11'
    timeslot=0
    status='creado'    
    return Appointment.objects.create(
        user=user, service=service,
        date=date, timeslot=timeslot,
        status=status
    )


class ModelTests(TestCase):

    def test_appointment_str(self):
        """Test the appointment string representation"""
        appointment = sample_appointment()
        self.assertEqual(str(appointment), '{} {} {}'.format(
            appointment.user,
            appointment.time,
            appointment.date))
    
    def test_create_appointment(self):
        """ Test create apointment """
        appointment = sample_appointment()
        self.assertEqual(appointment.service, 'aseo')
        self.assertEqual(appointment.date, '2022-02-11')
        self.assertEqual(appointment.timeslot, 0)
        self.assertEqual(appointment.status, 'creado')