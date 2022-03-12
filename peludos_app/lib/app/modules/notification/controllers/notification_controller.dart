import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care/app/constants/constants.dart';

final box = GetStorage('app');

  getNotificationApi(String notification_id) async {
    var apiEndpoint = baseIpUrl + "/notifications/";

    String token = box.read('token');

    var response = await http.get(
      Uri.parse(apiEndpoint + notification_id + '/'),
      headers: {"Authorization": 'Token ' + token}
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);

    } else {
      return null;
    }
  }


class NotificationController extends GetxController {
  var notification = [].obs;
  RxBool isLoading = false.obs;

  void loadNotification(String notification_id) async {
    isLoading.value = true;
    var response = await getNotificationApi(notification_id);
    notification.clear();
    if(response != null) {
      notification.add(response);
    }
    isLoading.value = false;    
  }
}
