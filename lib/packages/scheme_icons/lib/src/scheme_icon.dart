import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_icons/src/controllers/icon_controller.dart';

import 'constants/flare_icons.dart';
import 'icon_types/flare_icon.dart';

enum SchemeIconType { icon, svg, image, flare, lottie, color, flip }

class SchemeIcon extends StatelessWidget {
  final double size;
  ColorScheme colorScheme;
  String asset;
  IconData icon;
  String animation;
  String filePath;
  SchemeIconType iconType;
  bool animate;
  Color color;

  SchemeIcon(
      {this.size,
      this.colorScheme,
      this.asset,
      this.icon,
      this.animation,
      this.filePath,
      this.iconType,
      this.animate = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    final model = IconViewModel(
      size: size,
      color: color,
      colorScheme: colorScheme,
      asset: asset,
      iconData: icon,
      iconType: iconType,
      animation: animation,
      filePath: filePath,
      animate: animate,
    );
    return GetBuilder(
      init: SchemeIconController(),
      builder: (s) => model.iconView(iconType),
    );
  }



  SchemeIcon.flare({
    this.size = 24,
    this.colorScheme,
    this.color,
    @required this.asset,
    this.animation = 'idle',
    this.filePath,
  }) : this.iconType = SchemeIconType.flare;

  SchemeIcon.icon({
    this.size = 24,
    this.color = Colors.black,
    @required this.icon,
  }) : this.iconType = SchemeIconType.icon;

  SchemeIcon.image({
    this.size = 24,
    this.color = Colors.black,
    @required this.asset,
  }) : this.iconType = SchemeIconType.image;

  SchemeIcon.svg({
    this.size = 24,
    this.color = Colors.black,
    @required this.asset,
  }) : this.iconType = SchemeIconType.svg;

  SchemeIcon.color({
    this.size = 24,
    @required this.asset,
  }) : this.iconType = SchemeIconType.color;

  SchemeIcon.lottie({
    this.size = 24,
    @required this.asset,
    this.color = Colors.transparent,
    this.animate = false,
  }) : this.iconType = SchemeIconType.lottie;

  SchemeIcon.flip({
    this.size = 24,
    @required this.asset,
    this.color = Colors.black,
    this.animate = false,
  }) : this.iconType = SchemeIconType.flip;
}
