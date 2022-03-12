import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/app/constants/constants.dart';


final box = GetStorage('app');

  getOrderDetailApi(String orderId) async {
    var apiEndpoint = baseIpUrl + "/orders/";

    String token = box.read('token');

    var response = await http.get(
      Uri.parse(apiEndpoint + orderId),
      headers: {"Authorization": 'Token ' + token}
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // print(response.body);
      return json.decode(response.body);

    } else {
      return null;
    }
  }

  cancelOrderApi(String order_id) async {
    String token = box.read('token');
    var apiEndpoint = baseIpUrl + "/orders/checkout/";
    var response = await http.put(
      Uri.parse(apiEndpoint),
      body :
      {
        "order_id": order_id,
        "status": "canceled"
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





class OrderController extends GetxController {

  var order = [].obs;
  List cartProducts = [].obs;
  RxBool isLoading = false.obs;
  RxBool cancelLoader = false.obs;
  String orderStatus = '';


  @override
  void onClose() {
    order.clear();
    cartProducts.clear();
    super.onClose();
  }

  cancelOrder(String order_id) async {
    cancelLoader.value = true;

    var response = await cancelOrderApi(order_id);

    if(response != null) {
      EasyLoading.showSuccess('Orden Cancelada');
    }

    cancelLoader.value = false;
  }

  getOrderStatus() {
    switch (orderStatus) {
      case 'created':
        return 0;
      case 'received':
        return 1;
      case 'shipped':
        return 2;
      case 'paid':
        return 3;
      default:
        return 0;
    }
  }

  void loadOrder(String orderId) async {
    isLoading.value = true;
    var response = await getOrderDetailApi(orderId);
    order.clear();
    cartProducts.clear();
    // print('product data cleared!');
    if(response != null) {
      order.add(response);
      orderStatus = response['status'];
      // print(response['status']);
      response['cart']['products'].forEach((product) {
        cartProducts.add(product);
      });
    }
    isLoading.value = false;    
  }

}
