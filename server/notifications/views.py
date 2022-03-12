from rest_framework.views import APIView
from rest_framework.generics import ListAPIView, RetrieveDestroyAPIView
from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.exceptions import PermissionDenied


from .models import Notification
from .serializers import (
    NotificationSerializer,
    NotificationMiniSerializer,
)
from .permissions import IsOwner


class NotificationListView(ListAPIView):
    """
    Return Notifications filter by user
    """
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = NotificationMiniSerializer

    def get_queryset(self):
        user = self.request.user
        queryset = Notification.objects.filter(
            user=user, status=Notification.MARKED_UNREAD
        ).order_by("-created")
        return queryset


class NotificationAPIView(RetrieveDestroyAPIView):
    """
    Notification supports GET, DELETE methods
    """
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = NotificationMiniSerializer
    queryset = Notification.objects.all()

    def retrieve(self, request, *args, **kwargs):
        """Get notification"""
        user = request.user
        notification = self.get_object()
        notification.status = 'r'
        notification.save()
        if notification.user != user:
            raise PermissionDenied("this notification not belong to you")
        serializer = self.get_serializer(notification)
        return Response(serializer.data)

    def destroy(self, request, *args, **kwargs):
        """Delete Notification"""
        user = request.user
        notification = self.get_object()
        if notification.user != user:
            raise PermissionDenied(
                "this notification not belong to you, can't delete this notification"
            )
        notification.delete()
        return Response(
            {"detail": "this notification is deleted successfuly."},
            status=status.HTTP_204_NO_CONTENT,
        )


class MarkedAllAsReadNotificationView(APIView):
    """
    Mark as read all notifications of user
    """
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        """ mark notifications as read """
        user = request.user
        notifications = Notification.objects.filter(
            user=user, status=Notification.MARKED_UNREAD
        )
        for notification in notifications:
            if notification.user != user:
                raise PermissionDenied("this notifications don't belong to you.")
            notification.status = Notification.MARKED_READ
            notification.save()
        return Response("No new notifications.", status=status.HTTP_200_OK)
