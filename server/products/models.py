from PIL import Image, ImageOps
from django.db import models
from django.db.models import Q
from django.db.models.signals import pre_save
from django.urls import reverse

from core.models import TimeStampedModel
from server.utils import unique_slug_generator


class ProductManager(models.Manager):
    """
    Custom Product manager to retrieve products by keyword, 
    sort, max_price, min_price
    """
    def get_queryset(self):
        return super().get_queryset()

    def filter_products(self, keyword, sort, min_price, max_price):
        qs = self.get_queryset().filter(active=True)
        if keyword:
            qs = qs.filter(
                Q(tag_list__title__icontains=keyword) |
                Q(title__icontains=keyword)
            ).distinct()
        if sort:
            sort = int(sort)
            if sort == 2:
                qs = qs.order_by('-price')
            elif sort == 1:
                qs = qs.order_by('price')
        if max_price:
            max_price = int(max_price)
            qs = qs.filter(price__lt=max_price)
        if min_price:
            min_price = int(min_price)
            qs = qs.filter(price__gt=min_price)
        return qs

    def get_products(self):
        return self.get_queryset().filter(active=True)


class Product(TimeStampedModel):
    """Product model"""
    photo = models.ImageField(upload_to='uploads/products/%Y/%m/%d/')
    title = models.CharField(max_length=120)
    slug = models.SlugField(blank=True, unique=True)
    active = models.BooleanField(default=True)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    tax = models.DecimalField(max_digits=4, decimal_places=2, default=18)

    objects = ProductManager()

    class Meta:
        ordering = ('-created',)
        verbose_name = 'Producto'
        verbose_name_plural = 'Productos'

    def __str__(self):
        """ str representation """
        return self.title

    def get_absolute_url(self):
        """ return absolute url"""
        return reverse('products:detail', kwargs={'slug': self.slug})

    def get_related_products(self):
        """ return related products """
        title_split = self.title.split(' ')
        lookups = Q(title__icontains=title_split[0])

        for i in title_split[1:]:
            lookups |= Q(title__icontains=i)

        for i in self.tag_list.all():
            lookups |= Q(tag_list__title__icontains=i.title)

        related_products = Product.objects.filter(
            lookups).distinct().exclude(id=self.id)
        return related_products

    def save(self, *args, **kwargs):
        """ Reduce file size of pictures"""
        super(Product, self).save(*args, **kwargs)
        img = Image.open(self.photo.path)
        if img.height > 500 or img.width > 500:
            new_img = ImageOps.exif_transpose(img)
            output_size = (350, 550)
            new_img.thumbnail(output_size, Image.ANTIALIAS)
            new_img.save(self.photo.path, quality=95)
    
    @property
    def photo_url(self):
        """ return path of photo"""
        if self.photo:
            return 'http://192.168.1.69:8000' + self.photo.url
    

def product_pre_save_receiver(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.slug = unique_slug_generator(instance)


pre_save.connect(product_pre_save_receiver, sender=Product)


class Tag(models.Model):
    """Tag model to products"""
    title = models.CharField(max_length=120)
    slug = models.SlugField(blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    active = models.BooleanField(default=True)
    product = models.ManyToManyField(Product, blank=True, related_name="tag_list")

    def __str__(self):
        return self.title
    
    class Meta:
        ordering = ('id',)
        verbose_name = 'Etiqueta'
        verbose_name_plural = 'Etiquetas'


def tag_pre_save_receiver(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.slug = unique_slug_generator(instance)


pre_save.connect(tag_pre_save_receiver, sender=Tag)
