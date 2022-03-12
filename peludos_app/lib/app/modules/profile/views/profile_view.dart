import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCart2('Actualizar cuenta'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: Text(
                    "Actualizar Nombre de Usuario",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 10),
                  child: TextFormField(
                    controller: controller.newUsernameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                      hintText: '${box.read('user_username').toString()}',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateUsername();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kBlackMainColor,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    child: Text(
                      'Actualizar Nombre',
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 5),
                  child: Divider(),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0, vertical: 5),
                  child: Text(
                    "Actualizar Contraseña",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                  child: TextFormField(
                    controller: controller.oldPasswordCtrl,
                    decoration: InputDecoration(
                      labelText: 'Contraseña Actual',
                      hintText: 'Ingresa tu Contraseña actual',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                  child: TextFormField(
                    controller: controller.newPasswordCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nueva Contraseña',
                      hintText: 'Ingresa tu nueva Contraseña',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),

                Obx(
                  () =>
                  Visibility(
                    visible: !controller.isLoading.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updatePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kBlackMainColor,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        child: Text(
                          'Actualizar Contraseña',
                          style: TextStyle(color: Colors.white),
                        )
                      ),
                    ),
                  )
                ),

                Obx(
                  () =>
                  Visibility(
                    visible: controller.isLoading.value,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                )

              ],
            ),
          ),
        )
      )
    );
  }
}
