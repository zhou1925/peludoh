from random import sample
from django.test import TestCase
from django.contrib.auth import get_user_model

from ..models import Order
from cart.models import Cart

User = get_user_model()


def sample_user(username='usernametest', password='userpassword'):
    """Create a simple user"""
    return User.objects.create_user(username, password)

def sample_cart():
    return Cart.objects.create(
        user = sample_user(),

    )

def sample_order():
    """ create appointment"""
    user = sample_user()
    name='user full name'
    address_line_1='address_line_1'
    address_line_2='address_line_2'
    cart=sample_cart()
    active=True
    status='created'
       
    return Order.objects.create(
        user=user, name=name,
        address_line_1=address_line_1, address_line_2=address_line_2,
        cart=cart, active=active, status=status
    )


class ModelTests(TestCase):
    
    def test_create_order(self):
        """ Test create apointment """
        order = sample_order()

        self.assertEqual(order.name, 'user full name')
        self.assertEqual(order.address_line_1, 'address_line_1')
        self.assertEqual(order.address_line_2, 'address_line_2')
        self.assertEqual(order.status, 'created')
