from django.urls import path
from . import views



urlpatterns = [
    path('', views.AppointmentView.as_view()),
    path('list/', views.AppointmentViewList.as_view()),
]