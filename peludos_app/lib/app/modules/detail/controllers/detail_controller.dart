import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pet_care/app/constants/constants.dart';


getProductDetail(String slug) async {
    var apiEndpoint = baseIpUrl + "/products/list/";
    var response = await http.get(
      Uri.parse(apiEndpoint + slug + '/'),
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

  getRelatedProducts(String productId) async {
    var apiEndpoint = baseIpUrl + "/products/related/";
    var response = await http.get(
      Uri.parse(apiEndpoint + productId + '/'),
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


class DetailController extends GetxController {
  var product = [].obs;
  RxBool isloading = false.obs;
  RxBool cartIsloading = false.obs;

  @override
  void onClose() {
    product.clear();
    super.onClose();
  }

  void loadProduct(String slug) async {
    isloading.value = true;
    var response = await getProductDetail(slug);
    product.clear();
    if(response != null) {
      product.add(response);
    }
    isloading.value = false;
  }
}
