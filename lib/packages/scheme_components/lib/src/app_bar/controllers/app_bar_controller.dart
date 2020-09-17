import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController {

	static AppBarController get  to => Get.put(AppBarController());

	var opacity = 0.0.obs;


	@override
  void onInit() {
    super.onInit();

  }


}