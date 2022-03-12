import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/constants/constants.dart';
import 'package:pet_care/app/modules/appointment_detail/controllers/appointment_detail_controller.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/appointment_list_controller.dart';

class AppointmentListView extends GetView<AppointmentListController> {
  // final OrdersController ordersController = Get.put(OrdersController());
  final AppointmentDetailController appintmentDetailController = Get.put(AppointmentDetailController());

  final box = GetStorage('app');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: CustomAppBarCart2('Mis Citas'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if(controller.isLoading.value) {
                  return pet_loader();
                }
                
                if(controller.appointments.isEmpty) {
                  return Center(child: Text('No hay citas'));
                }

                return Container(
                  width: Get.width,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.appointments.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: controller.appointments[index]['status'] == 'creado' ? 240 : 200,
                          width: 300,
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SizedBox(height:5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.grey[400],
                                      ),

                                      SizedBox(width: 2),
                                      Text(
                                        '${controller.appointments[index]['service']}',
                                        style: TextStyle(
                                          color: kBlackMainColor.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),
                                      )

                                    ],
                                  ),
                                  
                                  // Icon(
                                  //   Icons.drag_handle_outlined
                                  // )
                                  Text(
                                    '${controller.appointments[index]['date']}',
                                    style: TextStyle(
                                      color: kBlackMainColor.withOpacity(0.7),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                    ),
                                  )
                                ]
                              ),

                              Divider(),

                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(3.0),
                                  labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  label: Text('${controller.appointments[index]['time'].toString().substring(0,6)}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.access_time_outlined, size: 20, color: Colors.black.withOpacity(0.5),)
                                  ),
                                ),

                                Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  )
                                ),

                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(3.0),
                                  labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  label: Text('${controller.appointments[index]['time'].toString().substring(8,13)}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.access_time_outlined, size: 20, color: Colors.black.withOpacity(0.5),)
                                  ),
                                ),
                                
                              ]),

                              controller.appointments[index]['status'] == 'creado' ?
                              GestureDetector(
                                onTap: () async {
                                  var appointment_id = controller.appointments[index]['id'].toString();
                                  // controller.cancelAppointment(appointment_id);
                                  controller.isLoading.value = true;
                                  String token = box.read('token');
                                  var apiEndpoint = baseIpUrl + "/appointments/";
                                  var response = await http.put(
                                    Uri.parse(apiEndpoint),
                                    body :
                                    {
                                      "appointment_id": appointment_id,
                                    },
                                    headers: {
                                      "Authorization": 'Token ' + token,
                                    }
                                  );
                                  if (response.statusCode == 200) {
                                    EasyLoading.showSuccess('Cita Cancelada');
                                    
                                    Get.back();
                                  } else {
                                    EasyLoading.showError('Algo salio mal');
                                  }
                                  controller.isLoading.value = false;
                                  

                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.all(10),
                                  width: Get.width - 30,
                                  decoration: BoxDecoration(
                                    color: kRedMainColor,
                                    borderRadius: BorderRadius.circular(10),
                                    
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        color: kWhiteMainColor,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              :
                              Container(),

                              Divider(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                  (controller.appointments[index]['status'] == 'creado') ? 'Creado' :
                                  (controller.appointments[index]['status'] == 'registrado') ? 'Recibido' :
                                  (controller.appointments[index]['status'] == 'completado') ? 'Completado' :
                                  'Cancelado'
                                  , 
                                  style: TextStyle(
                                    color: 
                                    (controller.appointments[index]['status'] == 'creado') ? Colors.red[400] :
                                    (controller.appointments[index]['status'] == 'registrado') ? Colors.blue[200] :
                                    (controller.appointments[index]['status'] == 'completado') ? Colors.red[400] :
                                    Colors.red[200]
                                  )),
                                Text(
                                  '${ DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.appointments[index]['created']))}',
                                  style: TextStyle(color: Colors.grey[400]),
                                  ),
                              ]),

                              SizedBox(height:5),
                            ],
                      
                          )
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
