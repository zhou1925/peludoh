from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from rest_framework.authentication import TokenAuthentication
from rest_framework.response import Response
from rest_framework.views import APIView
from django.db.utils import IntegrityError
from rest_framework.exceptions import ValidationError
from rest_framework.generics import RetrieveUpdateDestroyAPIView

from .models import Order
from .serializers import DetailedOrderSerializer, OrderSerializer, OrderUpdateSerializer
from users.models import User
from cart.models import Cart
from products.models import Product

class UserOrderList(APIView):
    """Return orders filter by user"""
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        """return order list of user"""
        orders = Order.objects.filter(user=request.user).all().order_by('-id')
        return Response(OrderSerializer(orders, many=True).data)


class OrderDetail(APIView):
    """Access order detail by id"""
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, order_code, **kwargs):
        """get order by id"""
        order_obj: Order = get_object_or_404(Order, order_code=order_code)
        if order_obj.user != request.user:
            return Response(status=401)
        return Response(DetailedOrderSerializer(order_obj).data)



class CheckoutView(RetrieveUpdateDestroyAPIView):
    """Confirm and create order """
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        """create order"""
        profile_id = request.data.get("profile_id")
        user = User.objects.get(id=profile_id)

        if profile_id == None:
            return Response({'error': 'Profile Id Not Found'}, status=400)

        name = request.data.get('name')
        address_line_1 = request.data.get('address_line_1')
        address_line_2 = request.data.get('address_line_2')
        phone = request.data.get('phone')
        # list of carts of the user
        carts = Cart.objects.filter(user=user)
        # set last cart of the user
        cart = carts.last()

        try:
            order = Order.objects.create(
                user=user,
                name=name,
                address_line_1=address_line_1,
                address_line_2=address_line_2,
                phone=phone,
                cart=cart,
                status='created'
            )
        except IntegrityError as err:
            return Response({"error": "Insufficient Data"}, status=400)

        orders = Order.objects.filter(user=user)
        order_obj = orders.last()
        done = order_obj.mark_used_cart()

        if not done:
            return Response({'error': 'Unable To mark used cart'}, status=500)

        return Response(DetailedOrderSerializer(order_obj).data)
    
    def update(self, request, *args, **kwargs):
        """update order status """
        status = request.data["status"]
        try:
            order = get_object_or_404(Order, pk=request.data["order_id"])
            order.status = status
            order.save()
        except Exception as e:
            raise ValidationError("Please, input vaild data")

        serializer = OrderUpdateSerializer(order, data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)