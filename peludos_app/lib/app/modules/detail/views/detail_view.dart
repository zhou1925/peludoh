import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/constants/constants.dart';
import 'package:pet_care/app/modules/cart/controllers/cart_controller.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final CartController cartController = Get.put(CartController());
  final box = GetStorage('app');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarDetail('Detalles'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if(controller.isloading.value) {
                  return Container(
                    height: Get.height * 0.40,
                    child: Center(
                      child: pet_loader(),
                    ),
                  );
                }

                return 
                Container(
                  height: Get.height * 0.40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        controller.product[0]['photo']
                      )
                    )
                  ),
                );
             }
            ),

            Obx(
              () {
                if(controller.isloading.value) {
                  return Container();
                }
                return 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            controller.product[0]['title'],
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'S./ ${controller.product[0]['price'].toString()}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Descripcion',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${controller.product[0]['description']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10),
            
                        ],
                      ),
                    ),
                  );
           }
          )
      
          ]
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () {
                  if(controller.isloading.value) {
                    return Text('');
                  }
                  return
                  Text(
                    'S./ ${controller.product[0]['price'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                  );
                }
              ),
              SizedBox(width: 5),
              Obx(
                () =>
                Visibility(
                  visible: !controller.cartIsloading.value,
                  child: GestureDetector(
                    onTap: () async {
                        controller.cartIsloading.value = true;
                        var productId = controller.product[0]['id'].toString();
                        var productQuantity = "1";
                        String token = box.read('token');
                        var response = await http.post(
                          Uri.parse(baseIpUrl + '/cart/'),
                          body:{
                            'id': productId,
                            'quantity': productQuantity
                          },
                          headers: {
                            "Authorization": 'Token ' + token,
                            "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                          }
                        );
                        if (response.statusCode >= 200 && response.statusCode < 300) {
                          show_add_cart_dialog(controller.product[0]['title']);
                        }
                        controller.cartIsloading.value = false;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kRedMainColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text('Agregar al Carro', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 5),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                              'assets/icons/add_cart.svg',
                              width: 25,
                              height: 35,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                )
              ),

              Obx(
                () =>
                Visibility(
                  visible: controller.cartIsloading.value,
                  child: Container(
                    
                    child: Row(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  )
                )
              )

            ],
          ),
        ),
      ),
    );
  }
}
