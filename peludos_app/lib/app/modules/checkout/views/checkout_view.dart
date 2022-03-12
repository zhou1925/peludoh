import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';
import 'package:pet_care/app/widgets/rounded_button.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: CustomAppBarCart2('Confirmar Orden'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [

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
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),

                Obx(() {
                  if(controller.cartProducts.isEmpty) {
                    return pet_loader();
                  }

                return Container(
                  height: 150,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.cartProducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150,
                        width: 130,
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
                            image: NetworkImage(controller.cartProducts[index]['product']['photo'])
                          )
                        ),
                        child: Column(
                          children: [
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Color(0x44000000).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(
                                          'x${controller.cartProducts[index]['quantity'].toString()}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Color(0x44000000).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10)
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
                                    ],
                                  ),
                                  // DropDown button
                                  
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.nameCtrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: "John Doe",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.address1Ctrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Direccion',
                    hintText: "Jr. Huari Nro 112 Mz G",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.address2Ctrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Referencia',
                    hintText: "Casa blanca/interior A/callejon/etc/",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.phoneCtrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Numero de Telefono',
                    hintText: "987654321",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'S./ ${Get.arguments['total'].toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              
              Obx(
                  () => Visibility(
                    visible: !controller.makeOrderLoading.value,
                    child: RoundedButton(
                      text: "Finalizar pedido",
                      color: kBlackMainColor,
                      press: () {
                        controller.nameCtrl.text.isNotEmpty &&
                        controller.address1Ctrl.text.isNotEmpty &&
                        controller.address2Ctrl.text.isNotEmpty &&
                        controller.phoneCtrl.text.isNotEmpty ?
                        controller.createOrder() : () {};
                      },
                    ),
                  )
                ),
                Obx(
                  () => Visibility(
                    visible: controller.makeOrderLoading.value,
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
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
}
