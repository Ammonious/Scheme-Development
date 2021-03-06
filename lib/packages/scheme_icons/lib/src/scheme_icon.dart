import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_icons/src/controllers/icon_controller.dart';
import 'package:scheme_shared/scheme_shared.dart';
import 'icon_maps/flare_icons.dart';
import 'icon_types/flare_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scheme_icons/src/icon_types/flare_icon.dart';
import 'package:supercharged/supercharged.dart';

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
    return GetBuilder(
      init: SchemeIconController(),
      builder: (_) {
        switch (iconType) {
          case SchemeIconType.icon:
            return Icon(icon, size: size, color: color);
          case SchemeIconType.svg:
            return kIsWeb ? svgMobile : compatSvg;
          case SchemeIconType.image:
            if (asset != null && (asset.contains('http') || asset.contains('www'))) return urlIcon;
            return imageIcon;
          case SchemeIconType.flare:
            return flareIcon;
          case SchemeIconType.lottie:
            return lottieIcon; // LottieBuilder.asset(
          case SchemeIconType.color:
            return svgColorIcon;
          case SchemeIconType.flip:
            return flipIcon;
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

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
      ); // LottieBuilder.

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
    if (icon != null) return Icon(icon, size: size, color: color);
    if (asset.contains('svg') && !asset.contains('md_color')) return svgIcon;
    if (asset.contains('md_color')) return svgColorIcon;
    if (asset.contains('http') || asset.contains('www')) return urlIcon;
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
