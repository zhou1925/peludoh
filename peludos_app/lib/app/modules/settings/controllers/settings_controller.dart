import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final box = GetStorage('app');
  
  logout() {
    box.erase();
    Get.offAllNamed('/welcome');
  }
}
