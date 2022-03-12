from django.contrib.sitemaps import Sitemap
from products.models import Product

class ProductSitemap(Sitemap):
    change_freq = 'weekly'
    priority = 0.9

    def items(self):
        return Product.objects.get_products()

    def lastmod(self, obj):
        return obj.modified