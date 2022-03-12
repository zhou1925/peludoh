
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class InitialController extends GetxController {
  
  final box = GetStorage('app');

  @override
  void onReady() async {
    await Future.delayed(Duration(seconds: 2));
    verifyAuth();
    super.onReady();
  }

  verifyAuth() {
    var token = box.read('token');
    if( token != null) {
      return Get.offAllNamed('/home');
    }
    else {
      return Get.offAndToNamed('/welcome');
    }
  }
}
