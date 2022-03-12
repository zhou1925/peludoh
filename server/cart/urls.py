from django.urls import path

from .views import CartAPIView, CheckProductInCart, CartItemView

urlpatterns = [
    path('', CartAPIView.as_view()),
    path('cart-item/<int:pk>/', CartItemView.as_view()),
    path('<product_id>/', CheckProductInCart.as_view()),
]