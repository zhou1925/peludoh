import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';

import '../controllers/adoption_controller.dart';

class AdoptionView extends GetView<AdoptionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Adoptame'),
        centerTitle: true,
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body:
        Obx(
          () {
            if(controller.isloading.value) {
              return pet_loader();
            }
            if(controller.pets.isEmpty) {
              return Center(child: Text('No hay mascotas'));
            }
            return
          
        Swiper(
          itemCount: controller.pets.length,
          indicatorLayout: PageIndicatorLayout.COLOR,
          scrollDirection: Axis.vertical,
          autoplay: true,
          // pagination: const SwiperPagination(),
          control: const SwiperControl(),

          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    controller.pets[index]['photo_url']
                  )
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric( horizontal: 5,vertical: 5.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0x44000000).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              'Nombre: ${controller.pets[index]['name']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold 
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric( horizontal: 5,vertical: 5.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0x44000000).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              'Edad: ${controller.pets[index]['age']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold 
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric( horizontal: 5,vertical: 5.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0x44000000).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              controller.pets[index]['gender'] == 'm' ?
                              'Macho' : 'Hembra',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold 
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric( horizontal: 5,vertical: 5.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0x44000000).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              'Raza: ${controller.pets[index]['race']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold 
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          
        );
        }
      )
      
    );
  }
}
