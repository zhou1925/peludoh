from PIL import Image, ImageOps
from django.db import models

class Pet(models.Model):
    """
    Pet model to adoption view
    """
    GENDERS = (
        ('m', 'Macho'),
        ('h', 'Hembra'),
    )
    name = models.CharField(max_length=20)
    photo = models.ImageField(upload_to='uploads/pets/%Y/%m/%d/')
    age = models.CharField(max_length=2)
    race = models.CharField(max_length=20)
    gender = models.CharField(choices=GENDERS, default='m', max_length=10)

    def __str__(self) -> str:
        """ str representation """
        return self.name
    
    def save(self, *args, **kwargs):
        """ Reduce file size of pictures"""
        super(Pet, self).save(*args, **kwargs)
        img = Image.open(self.photo.path)
        if img.height > 500 or img.width > 500:
            new_img = ImageOps.exif_transpose(img)
            output_size = (350, 550)
            new_img.thumbnail(output_size, Image.ANTIALIAS)
            new_img.save(self.photo.path, quality=95)
    
    @property
    def photo_url(self):
        """ return path of the photo """
        if self.photo:
            return 'http://192.168.1.69:8000' + self.photo.url

    class Meta:
        ordering = ['-id']
        verbose_name = 'Mascota'
        verbose_name_plural = 'Mascotas'
    