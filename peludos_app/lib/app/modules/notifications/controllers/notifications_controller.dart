import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care/app/constants/constants.dart';
import 'package:http/http.dart' as http;

final box = GetStorage('app');

getNotificationsApi() async {
    var apiEndpoint = baseIpUrl + "/notifications/";

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

mark_read_notifications_api() async {
    var apiEndpoint = baseIpUrl + "/notifications/mark-all-as-read/";

    String token = box.read('token');
    var response = await http.post(
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

class NotificationsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool mark_read_loader = false.obs;
  List notifications = [].obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    notifications.clear();
    super.onClose();
  }

  void loadData() async {
    isLoading.value = true;
    var response = await getNotificationsApi();
    // print(response);
    notifications.clear();
    if(response != null) {
      response.forEach((notification) {
          notifications.add(notification);
        });
      // print(notifications);
    }
    isLoading.value = false;
  }

  void markAllNotificationsRead() async {
    mark_read_loader.value = true;
    var response = await mark_read_notifications_api();
    notifications.clear();
    if(response != null) {
      EasyLoading.showSuccess('Notificaciones leidas');
      Get.back();
    }
    mark_read_loader.value = false;
  }
}
