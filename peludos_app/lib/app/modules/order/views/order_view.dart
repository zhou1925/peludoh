import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCart2('Detalles'),
      backgroundColor: Color(0xfff4f4f4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Detalles',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height:10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 70,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kRedLightMainColor
                        ),
                        child: Icon(
                          Icons.pin_drop_outlined,
                          color: kWhiteMainColor
                        )
                      ),
                      SizedBox(width: 10),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () {
                            if(controller.isLoading.value) {
                              return Text('');
                            }
                            return
                            Text(
                              controller.order[0]['address_line_1'].toString().length < 30 ?
                              controller.order[0]['address_line_1'].toString() :
                              controller.order[0]['address_line_1'].toString().substring(0, 30), 
                              style: TextStyle(color: kRedLightMainColor)
                            );
                          } 
                          
                        ),
                        Obx(
                          () {
                            if(controller.isLoading.value) {
                              return Text('');
                            }

                            return
                            Text('${controller.order[0]['name']}', style: TextStyle(color: Colors.grey[400]));
                          } 
                        ),
                        Obx(
                          () {
                            if(controller.isLoading.value) {
                              return Text('');
                            }

                            return
                            Text('+51${controller.order[0]['phone']}', style: TextStyle(color: Colors.red[200]));
                          } 
                        ),
                        ]
                      ),
                    ]
                  ),
                )
              ),
            
              SizedBox(height:10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Productos',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              Obx(() {
                if(controller.isLoading.value == true) {
                  return pet_loader();
                }

                return Container(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.cartProducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        width: 150,
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(controller.cartProducts[index]['product']['photo_url'])
                          )
                        ),    
                        child: Column(
                          children: [
                            SizedBox(height:10),
                            Container(
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // DropDown button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric( horizontal: 0,vertical: 4.0),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color(0x44000000).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Text(
                                            'x${controller.order[0]['cart']['products'][index]['quantity'].toString()}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.symmetric( horizontal: 0,vertical: 4.0),
                                        child: Container(
                                          
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color(0x44000000).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Text(
                                            'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  
                                ],
                              )
                            ),
                          ],
                      
                        )
                      );
                    }
                  ),
                );
              }),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Estado de la Orden',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Theme(
                  data: ThemeData(   
                    primarySwatch: Colors.green,
                    colorScheme: ColorScheme.light(
                    primary: kRedLightMainColor
                  )
                  ),
                  child: 
                  Obx(
                    () {
                      if(controller.isLoading()) {
                        return Container();
                      }

                      if(controller.order[0]['status'] == 'canceled' || controller.order[0]['status'] == 'refunded') {
                        return Container(width: 200, height: 100,child: Text('Tu orden ha sido cancelada'),);
                      }
                                            
                  return
                  Stepper(
                    type: StepperType.vertical,
                    currentStep: controller.getOrderStatus(),
                    controlsBuilder: (BuildContext? context,
                    {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                        return Row(
                          children: <Widget>[
                          ],
                        );
                    },
                    steps: [

                        // 1-created
                        Step(
                          title: Text('Orden Creada', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Tu orden ha sido creada. Si te equivocaste en algo puedes cancelar la orden antes de que preparemos la orden.'),
                              GestureDetector(
                                onTap: () async {
                                  var order_id =  controller.order[0]['id'].toString();
                                  await controller.cancelOrder(order_id);
                                  Get.offAllNamed('/home');
                                },
                                child: Container(
                                  width: 150,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)

                                  ),
                                  child: Center(child: Text('Cancelar Orden', style: TextStyle(color:Colors.white))),
                                ),
                              ),
                            ],
                          ),
                          state: controller.order[0]['status'] == 'created' ? StepState.complete : StepState.disabled,
                          isActive:
                            (controller.order[0]['status'] == 'created' || 
                            controller.order[0]['status'] == 'received' ||
                            controller.order[0]['status'] == 'shipped' ||
                            controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        // 2-received
                        Step(
                          title: Text('Orden Aceptada', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Text('Recibimos tu orden. Ahora lo estamos preparando.'),
                          state: controller.order[0]['status'] == 'received' ? StepState.complete : StepState.disabled,
                          isActive:
                            (controller.order[0]['status'] == 'received' ||
                            controller.order[0]['status'] == 'shipped' ||
                            controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        // 3-
                        Step(
                          title: Text('Orden Enviada', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: RichText(
                            text: TextSpan(
                              style: TextStyle(color: kBlackMainColor, fontFamily: 'Nunito'),
                              children: [
                                TextSpan(text: 'Tu orden ha sido enviada a la direccion: '),
                                TextSpan(text: '${controller.order[0]['address_line_1']} ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: 'cuando estemos cerca llamaremos a este numero: '),
                                TextSpan(text: '${controller.order[0]['phone']} . ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: 'El tiempo de entrega puede variar. Gracias por tu paciencia :)', style: TextStyle(fontSize: 12, color: Colors.red))
                              ]
                            )
                          ),
                          
                          state: controller.order[0]['status'] == 'shipped' ? StepState.complete : StepState.disabled,
                          isActive: 
                            (controller.order[0]['status'] == 'shipped' ||
                            controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        Step(
                          title: Text('Pedido Completado', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Text('Tu orden se ha completado satisfactoriamente, gracias por tu preferencia.'),
                          state: controller.order[0]['status'] == 'paid' ? StepState.complete : StepState.disabled,
                          isActive: controller.order[0]['status'] == 'paid' ? true : false
                        ),
                      
                    ]
                  );
                 }
                )
                ),
              ),


            ],
          ),
        )
      )
    );
  }
}
