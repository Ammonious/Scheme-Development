import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchemeAnimationUtils extends GetController with _ScrollAnimations{




}

mixin _ScrollAnimations {
  double get opacity => _rxOpacity.value;
  double _opacity;
  get _rxOpacity => _opacity.obs;

  scrollOpacityAnimation(ScrollController controller, {double threshold = 24}) {
    controller.addListener(() {
      _opacity = getOpacity(controller.offset, threshold);
    });
  }

  getOpacity(double offset, double threshold) {
    if (offset >= threshold) {
      return 1.0;
    } else if (offset <= threshold && offset >= 12) {
      return 0.75;
    } else if (offset < threshold) {
      return 0.0;
    } else {
      return 0.0;
    }
  }
}
