from rest_framework.permissions import BasePermission


class IsOwner(BasePermission):
    """Return current permission of user"""
    def has_object_permission(self, request, view, obj):
        if obj.user == request.user:
            return True
        return False
