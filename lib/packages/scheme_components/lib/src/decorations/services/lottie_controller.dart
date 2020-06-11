import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LottieController extends GetController{

	static LottieController get to => Get.put(LottieController());
	AnimationController controller;

	@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}