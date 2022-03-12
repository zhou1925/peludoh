from django.contrib.auth import get_user_model
from django.db import models

from products.models import Product

User = get_user_model()


class CartManager(models.Manager):
    """
    Cart Manager of Cart Model
    """
    def get_existing_or_new(self, request):
        created = False
        cart_id = request.session.get('cart_id')
        if self.get_queryset().filter(id=cart_id, used=False).count() == 1:
            obj = self.model.objects.get(id=cart_id)
        elif self.get_queryset().filter(user=request.user, used=False).count() == 1:
            obj = self.model.objects.get(user=request.user, used=False)
            request.session['cart_id'] = obj.id
        else:
            obj = self.model.objects.create(user=request.user)
            request.session['cart_id'] = obj.id
            created = True
        return obj, created


class Cart(models.Model):
    """
    Cart Model
    """
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)
    used = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    objects = CartManager()

    def __str__(self):
        """ str representation """
        return str(self.id)

    @property
    def total(self):
        """ return total sum of products in cart """
        total = 0
        for item in self.products.all():
            total += int(item.quantity) * float(item.product.price)
        return total

    @property
    def tax_total(self):
        """ return tax of total cart """
        total = 0
        for item in self.products.all():
            total += int(item.quantity) * float(item.product.price) * \
                float(item.product.tax) / 100
        return total

    @property
    def total_cart_products(self):
        """ return total cart in products """
        return sum(item.quantity for item in self.products.all())
    
    class Meta:
        verbose_name = 'Carro'
        verbose_name_plural = 'Carros'


class CartItem(models.Model):
    """
    Cart Item Model for Cart model
    """
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name="products")

    class Meta:
        unique_together = (
            ('product', 'cart')
        )