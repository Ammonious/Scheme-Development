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
  double size;
  String asset;
  IconData iconData;
  String animation;
  String filePath;
  SchemeIconType iconType;
  Color color;
  initIcon(IconViewModel model) {
    size = model.size;
    asset = model.asset;
    iconData = model.iconData;
    animation = model.animation;
    filePath = model.filePath;
    iconType = model.iconType;
    color = model.color;
  }

  get icon => Icon(iconData, size: size, color: color);

  get svgIcon => kIsWeb ? compatSvg : svgMobile;

  get compatSvg => ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
        child: PlatformSvg.asset(asset, height: size, width: size, package: 'scheme_icons'),
      );

  get svgMobile => ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
        child: SvgPicture.asset(asset,
            height: size, width: size, color: color ?? Colors.white, package: 'scheme_icons'),
      );

  get svgColorIcon => kIsWeb
      ? compatSvg
      : SvgPicture.asset(
          asset,
          height: size,
          package: 'scheme_icons',
          width: size,
        );

  get imageIcon => Image.asset(asset, color: color, height: size, width: size);

  get urlIcon => CachedNetworkImage(
        imageUrl: asset,
        useOldImageOnUrlChange: true,
        color: color,
        height: size,
        width: size,
      );

  get flareIcon => FlareIconMap(
        flareIcon: asset,
        iconSize: size,
        flrPath: filePath,
        animation: animation,
      );

  get lottieIcon => SizedBox(
        height: size + 8,
        width: size + 8,
        child: SchemeLottie.asset(
          src: asset,
          height: size + 8,
          width: size + 8,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          animate: animate,
          repeat: false,
          package: 'scheme_icons',
        ),
      ); // LottieBuilder.asset(asset);

  get flipIcon => CustomAnimation(
        duration: Duration(milliseconds: 350),
        tween: (0.0).tweenTo(1.0),
        control: SchemeIconController.to.control,
        builder: (context, child, progress) => Rotation3d(
          rotationY: 180.0 * progress,
          child: getFlipIcon(),
        ),
      );

  getFlipIcon() {
    if (iconData != null) return icon;
    if (asset.contains('svg') && !asset.contains('md_color')) return svgIcon;
    if (asset.contains('md_color')) return svgColorIcon;
    if (asset.contains('http') || asset.contains('www')) return urlIcon;
  }
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
