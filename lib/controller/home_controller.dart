import 'package:flutterpfe/model/products.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

import '../services/http_service.dart';

class HomeController extends GetxController{
  HttpService httpService = HttpService();
  var isLoading = false.obs;
  var addressList = <Products>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    httpService.init();
    getProducts();
    super.onInit();
  }
  Future<List<Products>?> getProducts({bool isShowLoading = true}) async {
    try {

      isLoading(true);
      final result = await httpService.request(
          url: "products", method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          List<Products> resp = (result.data as List)
              .map((x) => Products.fromJson(x))
              .toList();
          addressList.clear();
          addressList.addAll(resp);
          return resp;
        }
        return null;
      }
    } finally {
      isLoading(false);


    }
    return null;
  }

}