import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/constants/constants.dart';
import 'package:pet_care/app/modules/settings/widgets/profile_menu.dart';
import 'package:pet_care/app/routes/app_pages.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSettings('Cuenta'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 5),

            Account(
              text: 'Actualizar Cuenta',
              press: () {Get.toNamed(Routes.PROFILE);}
            ),
            ProfileMenu(
              text: "Mis Ordenes",
              icon: "assets/icons/parcel.svg",
              press: () {
                Get.toNamed(Routes.ORDERS);
              },
            ),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
              primary: kBlackMainColor,
              padding: EdgeInsets.all(20),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
              ),
              onPressed: () {
                Get.toNamed(Routes.APPOINTMENT_LIST);
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Mis citas')),
                  Icon(Icons.arrow_forward_ios),
                ]
              ),
            ),
          ),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
              primary: kBlackMainColor,
              padding: EdgeInsets.all(20),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
              ),
              onPressed: () {
                Get.toNamed(Routes.NOTIFICATIONS);
              },
              child: Row(
                children: [
                  Icon(Icons.notifications_active_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Notificaciones')),
                  Icon(Icons.arrow_forward_ios),
                ]
              ),
            ),
          ),
            ProfileMenu(
              text: "Sobre nosotros",
              icon: "assets/icons/question_mark.svg",
              press: () {
                Get.bottomSheet(Container(
                  // width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Container(
                      width: 300,
                      child: Text(
                        about,
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                )));
              },
            ),
            ProfileMenu(
              text: "Salir",
              icon: "assets/icons/log_out.svg",
              press: () {
                controller.logout();
              },
            ),
          ],
        ),
      )
    );
  }
}
