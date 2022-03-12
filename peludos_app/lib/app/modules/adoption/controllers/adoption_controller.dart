import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/app/constants/constants.dart';

getPets() async {
  var apiEndpoint = baseIpUrl + "/adoption/";
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

class AdoptionController extends GetxController {

  List pets = [].obs;
  RxBool isloading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    loadPets();
    super.onInit();
  }

  void loadPets() async {
    isloading.value = true;
    var response = await getPets();
    if(response != null) {
      pets.clear();
      response.forEach((pet) {
        pets.add(pet);
      });
      // print(pets.length);
    }
    isloading.value = false;
  }

}
