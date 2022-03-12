import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/app/constants/constants.dart';


final box = GetStorage('app');

getAppointmnetsApi() async {
    var apiEndpoint = baseIpUrl + "/appointments/list/";

    String token = box.read('token');
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Authorization": 'Token ' + token,
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
}

  cancelAppointmentApi(String appointment_id) async {
    String token = box.read('token');
    var apiEndpoint = baseIpUrl + "/appointments/";
    var response = await http.put(
      Uri.parse(apiEndpoint),
      body :
      {
        "appointment_id": appointment_id,
      },
      headers: {
        "Authorization": 'Token ' + token,
      }
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

class AppointmentListController extends GetxController {
  RxBool isLoading = false.obs;
  List appointments = [].obs;
  RxBool cancelLoader = false.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    appointments.clear();
    super.onClose();
  }

  void loadData() async {
    isLoading.value = true;
    var response = await getAppointmnetsApi();
    appointments.clear();
    if(response != null) {
      response.forEach((appointment) {
          appointments.add(appointment);
        });
    }
    isLoading.value = false;
  }

  cancelAppointment(String appointment_id) async {
    isLoading.value = true;

    String token = box.read('token');
    var apiEndpoint = baseIpUrl + "/appointments/";
    var response = await http.put(
      Uri.parse(apiEndpoint),
      body :
      {
        "appointment_id": appointment_id,
      },
      headers: {
        "Authorization": 'Token ' + token,
      }
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      EasyLoading.showSuccess('Cita Cancelada');
      isLoading.value = false;
      Get.back();
    } else {
      return null;
    }
    isLoading.value = false;

  }

}
