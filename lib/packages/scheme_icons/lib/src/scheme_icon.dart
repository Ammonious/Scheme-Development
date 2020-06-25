import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_icons/src/controllers/icon_controller.dart';
import 'package:scheme_shared/scheme_shared.dart';
import 'constants/flare_icons.dart';
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

  final SchemeIconController get = Get.put(SchemeIconController());
  @override
  Widget build(BuildContext context) {
    final model = IconViewModel(
      size: size,
      color: color,
      asset: asset,
      iconData: icon,
      iconType: iconType,
      animation: animation,
      filePath: filePath,
      animate: animate,
    );
    return GetBuilder(
      initState: (_) => get.initIcon(model),
      builder: (_) {
        switch (iconType) {
          case SchemeIconType.icon:
            return Icon(icon, size: size, color: color);
          case SchemeIconType.svg:
            return kIsWeb ? ColorFiltered(
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              child: SvgPicture.asset(
                asset,
                color: color,
                height: size,
                package: Env.getPackage('scheme_icons'),
                width: size,
                colorBlendMode: BlendMode.srcIn,
              ),
            ) : PlatformSvg.asset(
                asset,
                height: size,
                width: size,
                package: Env.getPackage('scheme_icons')
            );
          case SchemeIconType.image:
            if (asset != null && (asset.contains('http') || asset.contains('www')))
              return CachedNetworkImage(
              imageUrl: asset,
              useOldImageOnUrlChange: true,
              color: color,
              height: size,
              width: size,
            );
            return  Image.asset(asset, color: color, height: size, width: size);
          case SchemeIconType.flare:
            return FlareIconMap(
              flareIcon: asset,
              iconSize: size,
              flrPath: filePath,
              animation: animation,
            );
          case SchemeIconType.lottie:
            return SizedBox(
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
            ); // LottieBuilder.asset(
          case SchemeIconType.color:
            return SvgPicture.asset(
              asset,
              height: size,
              package: Env.getPackage('scheme_icons'),
              width: size,
            );
          case SchemeIconType.flip:
            return CustomAnimation(
              duration: Duration(milliseconds: 350),
              tween: (0.0).tweenTo(1.0),
              control: SchemeIconController.to.control,
              builder: (context, child, progress) => Rotation3d(
                rotationY: 180.0 * progress,
                child: get.getFlipIcon(),
              ),
            );
          default:
            return SizedBox.shrink();
        }
      },
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
