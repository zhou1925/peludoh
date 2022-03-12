from django.db import models
from django.contrib.auth import get_user_model
from django.db.models.signals import pre_save

from cart.models import Cart
from server.utils import unique_product_id_generator
from .utils import STATUS_CHOICES


User = get_user_model()

class OrderManager(models.Manager):
    """
    Custom order manager
    """
    def get_queryset(self):
        return super().get_queryset().filter()


class Order(models.Model):
    """Order model """
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    address_line_1 = models.CharField(max_length=255)
    address_line_2 = models.CharField(max_length=255, blank=True, null=True)
    order_code = models.CharField(max_length=120, blank=True)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    phone = models.CharField('Telefono', max_length=9)
    active = models.BooleanField(default=True)
    status = models.CharField(choices=STATUS_CHOICES, default='created', max_length=120)
    timestamp = models.DateTimeField(auto_now_add=True)
    shipping_total = models.DecimalField(default=0, max_digits=10, decimal_places=2)

    objects = OrderManager()
    
    def __str__(self):
        """ str representation """
        return "{}".format(self.id)

    @property
    def total_in_pen(self):
        """ total in local currency """
        return int(self.total * 100)

    def check_done(self):
        """ check order is correct"""
        user = self.user
        total = self.total
        cart = self.cart
        active = self.active
        if active and total > 0 and cart and user:
            return True
        return False

    def mark_used_cart(self):
        """ mark cart as used """
        if self.check_done():
            self.cart.used = True
            self.cart.save()
            self.status = 'created'
            self.save()
            return True
        return False

    def mark_paid(self):
        """ mark cart as paid """
        if self.check_done():
            self.cart.used = True
            self.cart.save()
            self.status = 'paid'
            self.save()
            return True
        return False

    @property
    def cart_total(self):
        """ return total cart """
        return self.cart.total

    @property
    def tax_total(self):
        """ return tax total of order"""
        return self.cart.tax_total

    @property
    def total(self):
        """ return total + shipmnet """
        return float(self.cart_total) + float(self.shipping_total)
    
    class Meta:
        verbose_name = 'Orden'
        verbose_name_plural = 'Ordenes'


def pre_save_create_order_code(sender, instance, *args, **kwargs):
    if not instance.order_code:
        instance.order_code = unique_product_id_generator(instance)


pre_save.connect(pre_save_create_order_code, sender=Order)