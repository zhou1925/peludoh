// import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:pet_care/app/constants/constants.dart';
import 'package:pet_care/app/modules/home/bindings/home_binding.dart';
import 'package:pet_care/app/routes/app_pages.dart';

// import 'package:http/http.dart' as http;

// import 'package:workmanager/workmanager.dart';


void main() async {
  await GetStorage.init('app');
  HttpOverrides.global = new MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();
  
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // await Workmanager().registerPeriodicTask(
  //   "2",
  //   "simplePeriodicTask",
  //   frequency: Duration(minutes: 2),
  //   initialDelay: Duration(seconds: 5),
  //   constraints: Constraints(
  //     networkType: NetworkType.connected,
  //     requiresBatteryNotLow: true,
  //   ),
    
  // );
  runApp(
    GetMaterialApp(
      title: 'Peludo Heart',
      debugShowCheckedModeBanner: false,
      // theme: appThemeData,
      theme:  ThemeData(fontFamily: 'Nunito'),
      initialRoute: Routes.INITIAL,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    )
  );
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

// callbackDispatcher() async {
//   Workmanager().executeTask((taskName, inputData) async {
//     var endpoint = '/adoption/';
//     var response = await http.get(Uri.parse(baseIpUrl + endpoint));

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       print('fetch data works!');
//     }

//     return Future.value(true);
//   });
// }