import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/app/constants/constants.dart';


final box = GetStorage('app');

getOrdersApi() async {
    var apiEndpoint = baseIpUrl + "/orders/";

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


class OrdersController extends GetxController {

  RxBool isLoading = false.obs;
  List orders = [].obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    orders.clear();
    super.onClose();
  }

  void loadData() async {
    isLoading.value = true;
    var response = await getOrdersApi();
    orders.clear();
    if(response != null) {
      response.forEach((order) {
          orders.add(order);
        });
    }
    isLoading.value = false;
  }

}