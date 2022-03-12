import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // Login
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  // Signup
  TextEditingController signup_usernameCtrl = TextEditingController();
  TextEditingController signup_passwordCtrl = TextEditingController();
  TextEditingController signup_password2Ctrl = TextEditingController();

  // final box = GetStorage('app');

  RxBool showPassword = false.obs;
  RxBool isloading = false.obs;
  RxBool signup_loader = false.obs;
}
