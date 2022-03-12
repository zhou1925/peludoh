import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care/app/constants/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


final box = GetStorage('app');

var token = box.read('token');

createOrderRequest(
                  String name, String address, 
                  String address2, String phone) async {
  var apiEndpoint = baseIpUrl + "/orders/checkout/";
  var user_id = box.read('user_id');
  var response = await http.post(
    Uri.parse(apiEndpoint),
    body : jsonEncode({
      "profile_id": user_id.toString(),
      "name": name,
      "address_line_1": address,
      "address_line_2": address2,
      "phone": phone
    }),
    headers: {
      "Authorization": 'Token ' + token,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      "Content-Type": "application/json"
    }
  );
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body);

  } else {
    return null;
  }
}


class CheckoutController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool makeOrderLoading = false.obs;
  
  List cartProducts = Get.arguments['products'];
  
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController address1Ctrl = TextEditingController();
  TextEditingController address2Ctrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();    
  }

  createOrder() async {
    makeOrderLoading.value = true;
    var response = await createOrderRequest(
      nameCtrl.text, 
      address1Ctrl.text, 
      address2Ctrl.text, 
      phoneCtrl.text
    );
    if(response != null) {
      EasyLoading.showSuccess('Orden creada exitosamente');
      await Future.delayed(Duration(seconds: 2));
      Get.offAllNamed('/home');
    }
    makeOrderLoading.value = false;
  }
  
}