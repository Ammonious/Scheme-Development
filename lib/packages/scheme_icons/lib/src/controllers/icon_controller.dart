import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_icons/src/icon_types/flare_icon.dart';
import 'package:supercharged/supercharged.dart';
import 'package:scheme_shared/scheme_shared.dart';
import 'package:flutter/services.dart';

class SchemeIconController extends GetxController {
  static SchemeIconController get to => Get.put(SchemeIconController());

  CustomAnimationControl get control => _rxControl.value;
  CustomAnimationControl _control;
  Rx<Object> get _rxControl => _control.obs;
  bool get animate => _rxAnimate.value;
  bool _animate;
    get _rxAnimate => _animate.obs;


}

class IconViewModel {
  double size;
  String asset;
  IconData iconData;
  String animation;
  String filePath;
  SchemeIconType iconType;
  bool animate;
  Color color;

  IconViewModel(
      {this.size,
      this.asset,
      this.iconData,
      this.animation,
      this.filePath,
      this.iconType,
      this.animate,
      this.color});
}
