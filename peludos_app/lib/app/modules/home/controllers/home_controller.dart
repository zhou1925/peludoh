import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/app/constants/constants.dart';


getCategoryList() async {
    var apiEndpoint = baseIpUrl + "/products/category/";
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  getCategoryDetail(String categoryId) async {
    var apiEndpoint = baseIpUrl + "/products/category/";
    var response = await http.get(
      Uri.parse(apiEndpoint + categoryId + '/'),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }



class HomeController extends GetxController {

  random_img() {
    var imgs = [
      'https://i.ibb.co/4FQMq6L/toy4.jpg',
      'https://i.ibb.co/Hg7LzLn/toy5.jpg',
      'https://i.ibb.co/j3SS4Pj/toy6.jpg',
      'https://i.ibb.co/fds5H8R/toy7.jpg',
      'https://i.ibb.co/rH35xm5/toy8.jpg'
    ];
    return (imgs..shuffle()).first;
  }
  
  random_cell_count() {
    // return random num between 2-3 to size home page
    var list = [2, 3];
    return (list..shuffle()).first;
  }

  // Tab
  var selectedTabIndex = 0.obs;

  // bottom nav
  var bottom_index = 0.obs;
  
  goPage(index) {
    if(index == 0) {
      bottom_index.value = index;
      Get.toNamed('/home');
    }
    else if (index == 1) {
      bottom_index.value = index;
      Get.toNamed('/appointments');
    }
    else if (index == 2) {
      bottom_index.value = index;
      Get.toNamed('/adoption');
    }
    else if (index == 3) {
      bottom_index.value = index;
      Get.toNamed('/settings');
    }
  }

  final bottomNavItems = [
    Icon(Icons.home_outlined, size: 30),
    Icon(Icons.shopping_bag_outlined, size: 30),
    Icon(Icons.calendar_today_outlined, size: 30),
    Icon(Icons.account_box_outlined, size: 30),
  ];


  var currentIndex = 0.obs;
  List categories = [].obs;
  RxBool isloading = false.obs;
  // Categories names
  List categoryData = [].obs;
  // Categories content
  List categoryDataDetail = [].obs;

  @override
  void onInit() async {
    await loadData(1.toString());
    await loadCategory();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   loadData(1.toString());
  //   loadCategory();
  //   super.onReady();
  // }

  // load titles category
  loadCategory() async {
    isloading.value = true;
    var response = await getCategoryList();
    if(response != null) {
      response.forEach((category) {
          categories.add(category);
        });
    }
    isloading.value = false;
  }

  // Load data by ID and data of product
  loadData(String categoryId) async {
    isloading.value = true;
    var response = await getCategoryDetail(categoryId);
    // print(categoryDataDetail);
    if(response != null) {
      categoryData.clear();
      categoryData.add(response);
      categoryDataDetail = categoryData[0]['product'];
    }
    isloading.value = false;
  }

}
