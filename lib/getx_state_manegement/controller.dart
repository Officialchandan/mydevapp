import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mydevapp/getx_state_manegement/services.dart';

import 'model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <DataFormUser>[].obs;
  var isDark = false.obs;
  @override
  void onInit() {
    _fetchProducts();

    super.onInit();
  }

  _fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void changeTheme(state) {
    if (state == true) {
      isDark(true);

      Get.changeTheme(ThemeData.dark());
    } else {
      isDark(false);
      Get.changeTheme(ThemeData.light());
    }
  }
}
