from django.contrib.sitemaps.views import sitemap
from django.conf.urls.static import static
from django.urls import include, path
from django.conf import settings
from django.contrib import admin
from users.views import CustomObtainAuthToken
from core.views import home
from core.sitemaps import ProductSitemap

sitemaps = {'products': ProductSitemap,}

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', view=home, name='home'),
    path('users/', include('users.urls')),
    path('login/', CustomObtainAuthToken.as_view()),
    path('orders/', include('orders.urls')),
    path('products/', include('products.urls', 'products')),
    path('cart/', include('cart.urls')),
    path('adoption/', include('adoption.urls')),
    path('appointments/', include('appointments.urls')),
    path('notifications/', include('notifications.urls')),
    path('sitemap.xml', sitemap, {'sitemaps': sitemaps},
            name='django.contrib.sitemaps.views.sitemap')
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)


admin.site.site_title = 'Peludo Hearth'
admin.site.index_title = 'Admin'
admin.site.site_header = 'Administracion'