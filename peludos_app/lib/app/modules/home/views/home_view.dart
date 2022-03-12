import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';
import 'package:pet_care/app/modules/detail/controllers/detail_controller.dart';
import 'package:pet_care/app/widgets/alert_dialogs.dart';
import 'package:pet_care/app/widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';



class HomeView extends GetView<HomeController> {

  final DetailController detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffF5F5F5),
      backgroundColor: Color(0xffece9e9),
      // backgroundColor: Colors.white,
      appBar: CustomAppBar('Peludo Heart'),
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Color(0xffe60023))
          // iconTheme: IconThemeData(color: kBlackMainColor)
        ),
        child: Obx(
          () => 

          CurvedNavigationBar(
            
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.white,
            // buttonBackgroundColor: Color(0xff191919),
            // color: Color(0xff191919),
            color: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            // items: controller.bottomNavItems,
            items: [
              controller.bottom_index.value == 0 ? 
              Icon(Icons.shopping_bag, size: 30) :
              Icon(Icons.shopping_bag_outlined, size: 30),
              // FaIcon(FontAwesomeIcons.dog, size: 30,),

              controller.bottom_index.value == 1 ? 
              Icon(Icons.calendar_today, size: 30) :
              Icon(Icons.calendar_today_outlined, size: 30),
              

              controller.bottom_index.value == 2 ? 
              Icon(Icons.pets, size: 30) :
              Icon(Icons.pets_outlined, size: 30),

              controller.bottom_index.value == 3 ? 
              Icon(Icons.account_circle, size: 30) :
              Icon(Icons.account_circle_outlined, size: 30),
            ],
            height: 60,
            index: controller.bottom_index.value,
            onTap: (index) {
              controller.goPage(index);
            },
          ),
        )
      ),
      // appBar: AppBar(
      //   title: Text('App name'),
      //   // centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: 
                  Obx(
                    () {
                      return
                      ListView.builder(
                        itemCount: controller.categories.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  controller.selectedTabIndex.value = index;
                                  controller.loadData((index + 1).toString());
                                },
                                child: Obx(
                                  () =>
                                  Chip(
                                    backgroundColor: index == controller.selectedTabIndex.value ? kWhiteMainColor : blackMain,
                                    shape: StadiumBorder(side: BorderSide()),
                                    shadowColor: Colors.black,
                                    label: Text(
                                      controller.categories[index]['title'],
                                      style: TextStyle(
                                        color: index == controller.selectedTabIndex.value ? blackMain : Color(0xffd3dcde).withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    ),
                                  )
                                )
                              )
                            ],
                          ),
                        )
                      );
                    }
                  ),
                ),

                Obx(
                  () {
                    if(controller.isloading.value) {
                      return pet_loader();
                    }
                    if(controller.categoryDataDetail.isEmpty) {
                      return Center(child: Text('No hay productos'));
                    }
                    return
                StaggeredGrid.count(
                  axisDirection: AxisDirection.down,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  
                  children:
                  List.generate(
                    controller.categoryDataDetail.length, (index)
                    => StaggeredGridTile.count(
                      crossAxisCellCount: 2, 
                      mainAxisCellCount: controller.random_cell_count(), 
                      child: GestureDetector(
                        onTap: () {
                          // print(index);
                          var slug = controller.categoryDataDetail[index]['slug'].toString().toLowerCase();
                          detailController.loadProduct(slug);
                          Get.toNamed('/detail');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                // controller.random_img()
                                controller.categoryDataDetail[index]['photo']
                              )
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                              Padding(
                                padding: EdgeInsets.symmetric( horizontal: 5,vertical: 2.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0x44000000).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Text(
                                    controller.categoryDataDetail[index]['title'].toString().length < 17 ?
                                    controller.categoryDataDetail[index]['title'].toString() :
                                    '${controller.categoryDataDetail[index]['title'].toString().substring(0,12)}...}',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.symmetric( horizontal: 5,vertical: 2.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0x44000000).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Text(
                                    'S./ ${controller.categoryDataDetail[index]['price']}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold 
                                    ),
                                  ),
                                ),
                              ),
                            ],

                          ),
                        ),
                      )
                    )
                  )
                );

                }
                )

              ],
              
            ),
          ),
        ),
      )
    );
  }
}
