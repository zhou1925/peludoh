from django.urls import path
from . import views


urlpatterns = [
    path("", views.NotificationListView.as_view()),
    path("<int:pk>/", views.NotificationAPIView.as_view()),
    path("mark-all-as-read/", views.MarkedAllAsReadNotificationView.as_view()),
]