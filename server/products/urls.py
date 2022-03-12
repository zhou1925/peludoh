from django.urls import path

from .views import ProductViewSet, RelatedProductView, CategoryViewSet

app_name = 'products'

urlpatterns = [
    path("list/", ProductViewSet.as_view({'get': 'list'})),
    path("list/<slug>/", ProductViewSet.as_view({'get': 'retrieve'}), name='detail'),
    path("related/<id>/", RelatedProductView.as_view()),
    path("category/", CategoryViewSet.as_view({'get': 'list'})),
    path("category/<id>/", CategoryViewSet.as_view({'get': 'retrieve'})),
]
