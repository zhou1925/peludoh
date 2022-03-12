import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/app/constants/constants.dart';

final box = GetStorage('app');

updatePhoneApi(String newUsername) async {
    String token = box.read('token');
    var user_id = box.read('user_id');
    var apiEndpoint = baseIpUrl + "/users/${user_id}/";

    var response = await http.put(
      Uri.parse(apiEndpoint),
      body :
      {
        "username": newUsername,
        "is_active": 'true',
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

updatePasswordApi(String old_password, String new_password) async {
    String token = box.read('token');
    var user_id = box.read('user_id');
    var apiEndpoint = baseIpUrl + "/users/${user_id}/change_password/";

    var response = await http.put(
      Uri.parse(apiEndpoint),
      body:
      {
        "old_password": old_password,
        "new_password": new_password
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


class ProfileController extends GetxController {
  // Loader
  RxBool isLoading = false.obs;
  RxBool updateUserLoader = false.obs;
  RxBool updatePassLoader = false.obs;

  // Form
  final formKey = GlobalKey<FormState>();
  TextEditingController newUsernameCtrl = TextEditingController();
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();

  updateUsername() async {
    updateUserLoader.value = true;
    var response = await updatePhoneApi(newUsernameCtrl.text);
    if(response != null) {
      EasyLoading.showSuccess('Nombre de usuario Actualizado.');
      Get.offAndToNamed('/welcome');
    } else {
      EasyLoading.showSuccess('Algo salio mal, vuelve a intentarlo.');
    }
    updateUserLoader.value = false;
  }

  updatePassword() async {
    updatePassLoader.value = true;
    var response = await updatePasswordApi(oldPasswordCtrl.text, newPasswordCtrl.text);
    if(response != null) {
      EasyLoading.showSuccess('Contraseña actualizada.');
      Get.back();
    } else {
      EasyLoading.showSuccess('Algo salio mal, vuelve a intentarlo.');
    }
    updatePassLoader.value = false;
  }
}