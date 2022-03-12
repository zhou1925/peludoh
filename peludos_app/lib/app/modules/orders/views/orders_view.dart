import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/modules/order/controllers/order_controller.dart';
import 'package:pet_care/app/routes/app_pages.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  final OrdersController ordersController = Get.put(OrdersController());
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: CustomAppBarCart2('Mis Ordenes'),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Obx(() {
                if(controller.isLoading.value == true) {
                  return pet_loader();
                }

                if(ordersController.orders.isEmpty) {
                  return Center(child: Text('No hay ordenes'));
                }

                return Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: ordersController.orders.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var order_code = ordersController.orders[index]['order_code'];
                        
                          orderController.loadOrder(order_code);
                          Get.toNamed(Routes.ORDER);
                        },
                        child: Container(
                          height: 160,
                          width: 300,
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),    
                          child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(
                                      '${ordersController.orders[index]['order_code']}',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  
                                  Icon(
                                    Icons.drag_indicator_rounded
                                  )
                                ]
                              ),

                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(6.0),
                                  label: Text('${ordersController.orders[index]['cart_total'].toString()}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.black,)
                                  ),
                                ),

                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(6.0),
                                  label: Text('${ordersController.orders[index]['shipping_total'].toString()}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(Icons.delivery_dining_outlined, size: 20, color: Colors.black,)
                                  ),
                                ),

                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(6.0),
                                  label: Text('${ordersController.orders[index]['total'].toString()}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Text('S./', style: TextStyle(color: Colors.black),)
                                  ),
                                ),
                                
                              ]),

                              Container(
                                alignment: Alignment.topCenter,
                                // margin: EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value:
                                  (ordersController.orders[index]['status'] == 'created') ? 0.3 :
                                  (ordersController.orders[index]['status'] == 'received') ? 0.5 :
                                  (ordersController.orders[index]['status'] == 'shipped') ? 0.7 :
                                  (ordersController.orders[index]['status'] == 'paid') ? 1 : 0.0,
                                  backgroundColor: Colors.grey[200],
                                  color: kRedLightMainColor
                                )
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                  '${ DateFormat('yyyy-MM-dd').format(DateTime.parse(ordersController.orders[index]['timestamp']))}',
                                  style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  Text(
                                  (ordersController.orders[index]['status'] == 'created') ? 'Creado' :
                                  (ordersController.orders[index]['status'] == 'received') ? 'Recibido' :
                                  (ordersController.orders[index]['status'] == 'shipped') ? 'Enviado' :
                                  (ordersController.orders[index]['status'] == 'delivered') ? 'Completado' :
                                  (ordersController.orders[index]['status'] == 'paid') ? 'Completado' :
                                  (ordersController.orders[index]['status'] == 'canceled') ? 'Cancelado' :
                                  (ordersController.orders[index]['status'] == 'refunded') ? 'Cancelado' :
                                  '...'
                                  , 
                                  style: TextStyle(
                                    color: 
                                    (ordersController.orders[index]['status'] == 'created') ? Colors.red[400] :
                                    (ordersController.orders[index]['status'] == 'received') ? Colors.blue[200] :
                                    (ordersController.orders[index]['status'] == 'shipped') ? Colors.amber[400] :
                                    (ordersController.orders[index]['status'] == 'paid') ? Colors.orange[400] :
                                    Colors.red[200]
                                  )),
                              ]),
                      
                            ],
                      
                          )
                        ),
                      );
                    }
                  ),
                );
              }),
            ]
          ),
        )
      ),
    );
  }
}
