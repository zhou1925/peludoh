from django.urls import path

from .views import OrderDetail, UserOrderList
from .views import CheckoutView


urlpatterns = [
    path('', UserOrderList.as_view()),
    path('<order_code>', OrderDetail.as_view()),
    path("checkout/", CheckoutView.as_view()),
]