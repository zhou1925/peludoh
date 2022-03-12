from datetime import datetime
from django.db.utils import IntegrityError
from django.shortcuts import get_object_or_404
from rest_framework import viewsets
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework.response import Response
from rest_framework.generics import ListAPIView, RetrieveUpdateDestroyAPIView

from users.models import User
from .models import Appointment
from .serializers import AppointmentSerializer, AppointmentUpdateSerializer, AppointmentDetailSerializer



class AppointmentViewList(ListAPIView):
    """Return appointments of user filter by creation date"""
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    serializer_class = AppointmentSerializer

    def get_queryset(self):
        user = self.request.user
        queryset = Appointment.objects.filter(user=user).order_by("-created")
        return queryset


class AppointmentView(RetrieveUpdateDestroyAPIView):
    """
    Appointment view supports GET, UPDATE, DELETE method
    """
    queryset = Appointment.objects.all()
    serializer_class = AppointmentSerializer
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def post(self, request, *args, **kwargs):
        user_id = request.data.get('user_id')
        user = User.objects.get(id=user_id)

        if user_id == None:
            return Response({'error': 'User id not found'}, status=400)
        
        service = request.data.get('service')
        date = request.data.get('date')
        date_time_obj = datetime.strptime(date, '%Y-%m-%d')
        time = int(request.data.get('time'))

        try:
            appointment = Appointment.objects.create(
                user = user,
                service = service,
                date = date_time_obj,
                timeslot = time,
                status = 'creado'
            )
        except IntegrityError as err:
            return Response({'error': 'Insufficient Data'}, status=400)
        
        appointments = Appointment.objects.filter(user=user)
        appointment_obj = appointments.last()

        return Response(AppointmentDetailSerializer(appointment_obj).data, status=200)
    
    def update(self, request, *args, **kwargs):
        appointment_id = request.data.get('appointment_id')
        try:
            appointment_obj = get_object_or_404(Appointment, pk=appointment_id)
            appointment_obj.status = 'cancelado'
            appointment_obj.save()
        except Exception as e:
            raise ValidationError("Please, input vaild data")

        serializer = AppointmentUpdateSerializer(appointment_obj, data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)
