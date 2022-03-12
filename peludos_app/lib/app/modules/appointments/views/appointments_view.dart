import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: CustomAppBarCart2('Citas'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Fecha',
                  style: TextStyle(
                    color: kBlackMainColor,
                    fontSize: 20
                  ),
                ),
              ),
              
              CalendarTimeline(
              showYears: false,
              initialDate: now,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                // print(date);
                // print('${date.toString().substring(0,11)}');
                controller.dateSelected.value = date.toString().substring(0,10);
              },
              leftMargin: 20,
              
              // monthColor: kBlackMainColor,
              dayColor: Colors.teal[200],
              // dayNameColor: Color(0xFF333A47),
              dayNameColor: Colors.white,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: kRedMainColor,
              dotsColor: blackMain,
              // selectableDayPredicate: (date) => date.day != 23,
              locale: 'es',
            ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Hora',
                  style: TextStyle(
                    color: kBlackMainColor,
                    fontSize: 20
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 40,
                  width: Get.width - 20,
                  child: 
                  Container(
                    height: 40,
                    width: Get.width - 20,
                    child: 
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.timeList.length,
                      itemBuilder: (context, index) {
                        return
                        GestureDetector(
                          onTap: () {
                            // print(index);
                            controller.timeSelected.value = index;
                            // print(controller.timeList[index]);
                            // controller.9:00.active = true;
                          },
                          child: 
                          Obx(
                            () =>
                          
                          Container(
                            width: 55,
                            height: 30,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: controller.timeSelected.value == index ? kRedMainColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border(
                                left: BorderSide(width: 1.0, color: kGrey),
                                right: BorderSide(width: 1.0, color: kGrey),
                                top: BorderSide(width: 1.0, color: kGrey),
                                bottom: BorderSide(width: 1.0, color: kGrey),
                              ),
                            ),
                            child: Obx(
                              () =>
                                Center(
                                  child: Text(
                                    '${controller.timeList[index]}',
                                    style: TextStyle(
                                      color: controller.timeSelected.value == index ? kWhiteMainColor : kGrey
                                    )
                                  )
                                ),
                            ) 
                          )
                          )
                        );
                      }
                    )
                    )
                ),
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Servicio',
                  style: TextStyle(
                    color: kBlackMainColor,
                    fontSize: 20
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: CoolDropdown(
                  resultAlign: Alignment.center,
                  // resultBD: BoxDecoration(
                  //   color: kRedMainColor,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  // resultTS: TextStyle(
                  //   fontSize: 20,
                  //   color: Colors.white
                  // ),
                  dropdownList: controller.services,
                  onChange: (value) {
                    // print(value);
                    // print(value['value']);
                    controller.serviceSelected.value = value['value'];
                  },
                  defaultValue: controller.services[0],
                ),
              ),
            ],
          )
        ),
      ),
      bottomNavigationBar: 
      Obx(
        () {
          return 
        
          Container(
            width: Get.width,
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              color: kRedMainColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        var service = controller.serviceSelected.value;
                        // var date = now;
                        var date = controller.dateSelected.value;
                        var time = controller.timeSelected.value;
                        // print(service + date + time.toString());
                        // print(service);
                        // print(date.toString());
                        controller.makeAppointment(service, date.toString(), time.toString());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: 
                        
                        Center(
                          child:
                          controller.isLoading.value ?
                          Visibility(
                            child: CircularProgressIndicator()
                          ) :
                          Visibility(
                            visible: !controller.isLoading.value,
                            child: Text(
                              'Confirmar', 
                              style: TextStyle(
                                color: kRedMainColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2
                              )
                            ),
                          )

                        ),

                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      )
    );
  }
}