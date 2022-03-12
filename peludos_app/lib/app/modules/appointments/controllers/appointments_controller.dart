import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import 'package:pet_care/app/constants/constants.dart';


final box = GetStorage('app');

var token = box.read('token');
DateTime now = new DateTime.now();

make_appointment_api(service, date, time) async {
  var apiEndpoint = baseIpUrl + "/appointments/";
  var user_id = box.read('user_id');
  var response = await http.post(
    Uri.parse(apiEndpoint),
    body : jsonEncode({
      "user_id": user_id.toString(),
      "service": service,
      "date": date,
      "time": time,
    }),
    headers: {
      "Authorization": 'Token ' + token,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      "Content-Type": "application/json"
    }
  );
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return 'sucess';

  } else {
    return null;
  }
}



class AppointmentsController extends GetxController {

  List timeList = [
    '09:00', '09:30',
    '09:30', '10:00',
    '10:00', '10:30',
    '10:30', '11:00',
    '11:00', '11:30',
    '11:30', '12:00',
    '12:00', '12:30',
    '12:30', '13:00',
    '13:00', '13:30',
    '13:30', '14:00',
    '14:00', '14:30',
    '14:30', '15:00',
    '15:00', '15:30',
    '15:30', '16:00',
    '16:00', '16:30',
    '16:30', '17:00',
    '17:00', '17:30',
    '17:30', '18:00',
    '18:00', '18:30',
    '18:30', '19:00',
    '19:00', '19:30',
    '19:30', '20:00',
    '20:00', '20:30',
    '20:30', '21:00',
  ];

  // label is required and unique
  List services = [
    {'label': 'Hospitalizacion', 'value': 'hospitalizacion'},
    {'label': 'Aseo', 'value': 'aseo'}, 
    {'label': 'Vacuna', 'value': 'vacuna'},
    {'label': 'Atencion Medica', 'value': 'medicina'},
    {'label': 'Laboratorio', 'value': 'laboratorio'},
    {'label': 'Otros', 'value': 'otros'},
  ];

  var dateSelected = now.toString().substring(0,10).obs;
  RxString serviceSelected = ''.obs;
  RxInt timeSelected = 99.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    serviceSelected.value = services[0]['value'];
    super.onInit();
  }

  makeAppointment(String service, String date, String time) async {
    isLoading.value = true;
    if(service.isNotEmpty && date.isNotEmpty && time.isNotEmpty) {
      var response = await(make_appointment_api(
        service,
        date,
        time)
      );
      if(response != null) {
        EasyLoading.showSuccess('Cita creada correctamente');
        isLoading.value = false;
        Get.back();
      }
      else {
        EasyLoading.showError('Algo Salio mal');
        isLoading.value = false;
      }
    }else {
      EasyLoading.showError('Falta rellenar algun campo');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

}
