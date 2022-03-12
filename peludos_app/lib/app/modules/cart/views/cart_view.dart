import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: CustomAppBarCart('Carrito'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () {
                  if(controller.isLoading.value) {
                    return pet_loader();
                  }

                  if(controller.cartProducts.length == 0) {
                    return Center(child: Text('El Carrito esta vacio'));
                  }

                  return
                
              Container(
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: controller.cartProducts.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90,
                      width: 300,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: 
                              DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  controller.cartProducts[index]['product']['photo']
                                )
                              ) 
                            )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    controller.isLoading.value ? '' :
                                    controller.cartProducts[index]['product']['title'],
                                    // 'product name',
                                    style: TextStyle(
                                    color: kGreyDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  // DropDown button
                                  Text(
                                    // categoryController.isloading.value ? '' :
                                    // 'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                                    'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                    // 'S./ 12.0',
                                    style: TextStyle(
                                      color: kRedLightMainColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                              ]
                            )
                          ),

                          // quantity
                          Obx(() {
                              return Text(controller.cartProducts[index]['quantity'].toString());
                          }),

                          PopupMenuButton(
                              tooltip: 'Cantidad',
                              onSelected: (value) {
                                var cartProductId = controller.cartProducts[index]['id'].toString();
                                var productId = controller.cartProducts[index]['product']['id'].toString();
                                var productQuantity = value.toString();
                                controller.updateItemInCart(cartProductId, productQuantity, productId);
                              },
                              icon: Icon(Icons.arrow_drop_down),
                              initialValue: 1,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("1"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text("2"),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text("3"),
                                  value: 3,
                                ),
                                PopupMenuItem(
                                  child: Text("4"),
                                  value: 4,
                                ),
                                PopupMenuItem(
                                  child: Text("5"),
                                  value: 5,
                                ),
                                PopupMenuItem(
                                  child: Text("6"),
                                  value: 6,
                                ),
                                PopupMenuItem(
                                  child: Text("7"),
                                  value: 7,
                                ),
                                PopupMenuItem(
                                  child: Text("8"),
                                  value: 8,
                                ),
                                PopupMenuItem(
                                  child: Text("9"),
                                  value: 9,
                                ),
                              ]
                            ),

                            SizedBox(width: 15),
                            IconButton(
                              color: kRedLightMainColor.withOpacity(0.7),
                              onPressed: (){
                               controller.deleteItemInCart(
                                  controller.cartProducts[index]['id'].toString(),
                                );
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.green[200],
                              )
                            )

                        ],
                      ),
                    );
                  }
                ),
              );
             }
            ),
            ]
          )
        )
      ),
      bottomNavigationBar: 
      Obx(
        () {
          if(controller.cartProducts.isEmpty) {
            return Container(height: 130, width: Get.width);
          }
          return 
        
          Container(
            width: Get.width,
            height: 130,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(
                        'S./ ${controller.cart['total'].toString()}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/checkout',
                          arguments: {
                                      'products' : controller.cartProducts,
                                      'total': controller.cart['total'],
                                    });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text('Confirmar Pedido', style: TextStyle(color: kRedMainColor))
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
