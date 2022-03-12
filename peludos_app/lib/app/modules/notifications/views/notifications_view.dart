import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/modules/notification/controllers/notification_controller.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';

import '../controllers/notifications_controller.dart';


class NotificationsView extends GetView<NotificationsController> {

  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Notificaciones', style: TextStyle(color: blackMain),),
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/icons/back_arrow.svg',
                width: 24,
                height: 24,
                color: blackMain
              )
            ),
          )
        ),
        actions: [
          
          Obx(
            () =>

            controller.notifications.isEmpty ? Container()
            :
            Visibility(
              visible: !controller.mark_read_loader.value,
              child: TextButton(
                  onPressed: () => controller.markAllNotificationsRead(),
                  child: Text(
                    'Marcar todo como leido',
                    style: TextStyle(
                      color: kRedLightMainColor
                    ),
                  )
              ),
            )
          ),

          Obx(
            () =>
            Visibility(
              visible: controller.mark_read_loader.value,
              child: TextButton(
                onPressed: (){},
                child: Center(child: CircularProgressIndicator())
              ),
            )
          )

        ],
      
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Obx(
              () {
                if(controller.isLoading.value) {
                  return pet_loader();
                }
                
                if(controller.notifications.isEmpty) {
                  return Center(child: Text('No hay notificaciones'));
                }

                return Container(
                  width: Get.width,
                  child: ListView.builder(
                    itemCount: controller.notifications.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var notification_id = controller.notifications[index]['id'].toString();
                          notificationController.loadNotification(notification_id);
                          Get.toNamed('/notification');
                        },
                        child: Container(
                          height: 100,
                          width: Get.width - 300,
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: kRedLightMainColor,
                                      borderRadius: BorderRadius.circular(25)
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${controller.notifications[index]['title']}',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold 
                                    ),
                                  ),

                                  
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller.notifications[index]['body'].toString().length < 45 ?
                                    controller.notifications[index]['body'] :
                                    '${controller.notifications[index]['body'].toString().substring(0,40)}...',
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.grey[400]
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                );
              }
            )
          ]
        ),
      )
    );
  }
}
