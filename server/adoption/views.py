from rest_framework.pagination import PageNumberPagination
from rest_framework.generics import ListAPIView
from rest_framework.permissions import AllowAny

from .models import Pet
from .serializers import PetSerializer


class PetPagination(PageNumberPagination):
    """
    Pet Pagination for Pet ViewSet
    """
    page_size = 10


class PetListView(ListAPIView):
    """ 
    Pet List View of Pet model
    """
    # pagination_class = PetPagination
    permission_classes = [AllowAny]
    serializer_class = PetSerializer
    queryset = Pet.objects.all()