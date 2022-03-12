import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/constants/constants.dart';
import 'package:pet_care/app/widgets/background.dart';
import 'package:pet_care/app/widgets/rounded_button.dart';
import 'package:pet_care/app/widgets/rounded_input_field.dart';
import 'package:pet_care/app/widgets/rounded_password_field.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  final box = GetStorage('app');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Bienvenido a Peludo Heart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent[400],
                  ),
                ),
                Lottie.asset(
                  'assets/json/welcome5.json',
                  width: Get.width * 0.45,
                  height: Get.height * 0.45
                ),
                RoundedButton(
                  text: "INGRESAR",
                  textColor: Colors.white,
                  color: kRedMainColor,
                  press: () {
                    Get.dialog(
                      AlertDialog(
                        scrollable: true,
                        title: Text('INGRESAR'),
                        content: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              RoundedInputField(
                              hintText: 'Nombre de usuario',
                              controller: controller.usernameCtrl,
                              onChanged: (value){},
                              icon: Icons.account_circle,
                            ),
                            Obx(
                              () => RoundedPasswordField(
                                showPassword: controller.showPassword.value,
                                showPassBtn: () {
                                  controller.showPassword.value = !controller.showPassword.value;
                                },
                                controller: controller.passwordCtrl,
                                onChanged: (value) {},
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: !controller.isloading.value,
                                child: RoundedButton(
                                  text: "INGRESAR",
                                  press: () async {
                                    var username = controller.usernameCtrl.text;
                                    var password = controller.passwordCtrl.text;
                                    if(username.isNotEmpty && password.isNotEmpty ) {
                                      controller.isloading.value = true;
                                      var response = await http.post(
                                        Uri.parse(baseIpUrl + '/login/'),
                                        body: {
                                          "username": username,
                                          "password": password
                                        },
                                        headers: {
                                          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                                        }
                                      ).timeout(Duration(seconds: 15));
                                      if(response.statusCode >= 200 && response.statusCode < 300) {
                                        var data = json.decode(response.body);
                                        box.write('token', data['token']);
                                        box.write('user', data['user']);
                                        box.write('user_id', data['user']['id']);
                                        box.write('user_username', data['user']['username']);
                                        controller.isloading.value = false;
                                        Get.offAllNamed('/home');
                                      } else {
                                        EasyLoading.showError('Algo Salio mal Vuelve a intentarlo');
                                      }
                                    } else {
                                      EasyLoading.showError('Falta rellenar algun campo');
                                      controller.isloading.value = false;
                                    }
                                    controller.isloading.value = false;
                                    
                                  },
                                ),
                              )
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.isloading.value,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: Get.width * 0.8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(29),
                                    child: TextButton(
                                      onPressed: (){},
                                      child: CircularProgressIndicator(),
                                    )
                                  ),
                                )
                              )
                            ),
                            ],
                          ),
                        ),
                      )
                    );
                  },
                ),
                RoundedButton(
                  text: "CREAR UNA CUENTA",
                  color: kRedMainColor.withOpacity(0.9),
                  textColor: Colors.white.withOpacity(0.9),
                  press: () {
                    Get.dialog(AlertDialog(
                      scrollable: true,
                      title: Text('Crear Cuenta'),
                      content: Form(
                        key: controller.formKey2,
                        child: Column(
                          children: [
                            RoundedInputField(
                              hintText: 'Nombre de usuario',
                              controller: controller.signup_usernameCtrl,
                              onChanged: (value){},
                              icon: Icons.account_circle,
                            ),
                            Obx(
                              () => RoundedPasswordField(
                                showPassword: controller.showPassword.value,
                                showPassBtn: () {
                                  controller.showPassword.value = !controller.showPassword.value;
                                },
                                controller: controller.signup_passwordCtrl,
                                onChanged: (value) {},
                              ),
                            ),
                      
                            SizedBox(height: 2),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Confirmar Contraseña',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            Obx(
                                () => RoundedPasswordField(
                                  showPassword: controller.showPassword.value,
                                  showPassBtn: () {
                                    controller.showPassword.value = !controller.showPassword.value;
                                  },
                                  controller: controller.signup_password2Ctrl,
                                  onChanged: (value) {},
                                ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: !controller.signup_loader.value,
                                child: RoundedButton(
                                  text: "CREAR CUENTA",
                                  press: () async {
                                    var username = controller.signup_usernameCtrl.text;
                                    var password = controller.signup_passwordCtrl.text;
                                    var password2 = controller.signup_password2Ctrl.text;
                                    if(username.isNotEmpty && password.isNotEmpty && password2.isNotEmpty) {
                                      controller.signup_loader.value = true;
                                      if(password == password2) {
                                        controller.signup_loader.value = true;
                                        if(password.length >= 6 && password2.length >= 6) {
                                          controller.signup_loader.value = true;
                                          if(username.length >= 4) {
                                            controller.signup_loader.value = true;
                                            var response = await http.post(
                                              Uri.parse(baseIpUrl + '/users/'),
                                              body: {
                                                'username': username,
                                                'password': password,
                                                'is_active': 'true'
                                              },
                                              headers: {
                                                "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                                              }
                                            );

                                            if(response.statusCode >= 200 && response.statusCode < 300) {
                                              EasyLoading.showSuccess('Cuenta creada exitosamente, ahora puedes ingresar');
                                              controller.signup_loader.value = false;
                                              Get.back();
                                            }
                                            else {
                                              EasyLoading.showError('Algo salio mal intentalo de nuevo');
                                              controller.signup_loader.value = false;
                                            }
                                          }
                                          else {
                                            EasyLoading.showError('Tu nombre de usuario debe tener mas de 6 caracteres');
                                            controller.signup_loader.value = true;
                                          }
                                        }
                                        else {
                                          EasyLoading.showError('Tu contraseña debe tener mas de 6 caracteres');
                                          controller.signup_loader.value = true;
                                        }
                                      }
                                      else {
                                        EasyLoading.showError('Tu contraseña no coincide');
                                        controller.signup_loader.value = true;
                                      }
                                    } else {
                                      EasyLoading.showError('Falta rellenar algun campo');
                                      controller.signup_loader.value = true;
                                    }

                                  },
                                ),
                              )
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.signup_loader.value,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: Get.width * 0.8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(29),
                                    child: TextButton(
                                      
                                      onPressed: (){},
                                      child: CircularProgressIndicator(),
                                    )
                                  ),
                                )
                              )
                            ),
                          ],
                        ),
                      ),
                      // actions: [
                      //   TextButton(
                      //       onPressed: () => Get.offAllNamed('/login'), // Close the dialog
                      //       child: const Text('Crear'))
                      // ],
                    )
                    );
                  },
                ),
              ]
            )
          )
        )
      ),
    );
  }
}
