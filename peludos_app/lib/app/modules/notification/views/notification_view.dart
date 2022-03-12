import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: CustomAppBarCart2('Notificacion'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              
              Obx(
                () {
                  if(controller.isLoading.value) {
                    return pet_loader();
                  }

                  return
                  Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              controller.notification[0]['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1
                              ),
                            ),
                          ]
                        ),
                      ),

                      SizedBox(height: 5),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          
                          children: [
                            Container(
                              child: Expanded(
                                child: Text(
                                  controller.notification[0]['body'],
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                ),
                              ),
                            )
                          ]
                        ),
                      ),


                    ],
                  );
              }
              )
            ],
          ),
        ),
      )
    );
  }
}
