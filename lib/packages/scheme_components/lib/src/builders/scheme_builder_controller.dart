import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

class SchemeBuilderController extends GetController {
	static SchemeBuilderController get to => Get.put(SchemeBuilderController());

	ScrollController scrollController;
	double get opacity => _rxOpacity.value;
	DoubleX get _rxOpacity => _opacity.obs;
	double _opacity = 0.0;

	initController({bool enableScrollAnimation}){
		scrollController = ScrollController();
		if(enableScrollAnimation){
			SchemeUtils.animation.scrollOpacityAnimation(scrollController);
			_opacity = SchemeUtils.animation.opacity;
		}
	}

}

