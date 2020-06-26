import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ThemeAnimController extends GetxController {


	ThemeData oldTheme;
	Offset switcherOffset;
	AnimationController controller;
	bool busy = false;

	@override
	void onInit() {
		super.onInit();
		WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
	}


	@override
  void onClose() {
    super.onClose();
    controller.dispose();
  }


	void getSwitcherCoordinates(switcherGlobalKey) {
		RenderBox renderObject =
		switcherGlobalKey.currentContext.findRenderObject();
		final size = renderObject.size;
		switcherOffset = renderObject
				.localToGlobal(Offset.zero)
				.translate(size.width / 2, size.height / 2);
	}

	void _afterLayout(_) {
		oldTheme = Get.theme;

		controller.forward();
	}
}