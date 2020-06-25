import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_icons/src/icon_types/flare_icon.dart';
import 'package:supercharged/supercharged.dart';

class SchemeIconController extends GetController {
  static SchemeIconController get to => Get.put(SchemeIconController());

  CustomAnimationControl get control => _rxControl.value;
  CustomAnimationControl _control;
  Rx<Object> get _rxControl => _control.obs;
  bool get animate => _rxAnimate.value;
  bool _animate;
  BoolX get _rxAnimate => _animate.obs;
  double size;
  String asset;
  IconData iconData;
  String animation;
  String filePath;
  SchemeIconType iconType;
  Color color;
  initIcon(IconViewModel model){
    size = model.size;
    asset = model.asset;
    iconData = model.iconData;
    animation = model.animation;
    filePath = model.filePath;
    iconType = model.iconType;
    color = model.color;
  }


  get _icon => Icon(iconData, size: size, color: color);

  get _svgIcon => ColorFiltered(
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    child: kIsWeb ? _compatSvg : svgMobile,
  );

  get _compatSvg => PlatformSvg.asset(
      asset,
      height: size,
      width: size,
      package: Env.getPackage('scheme_icons')
  );

  get  svgMobile => SvgPicture.asset(
    asset,
    color: color,
    height: size,
    package: Env.getPackage('scheme_icons'),
    width: size,
    colorBlendMode: BlendMode.srcIn,
  );

  get _svgColorIcon => kIsWeb ? _compatSvg : SvgPicture.asset(
    asset,
    height: size,
    package: Env.getPackage('scheme_icons'),
    width: size,
  );

  get _imageIcon => Image.asset(asset, color: color, height: size, width: size);

  get _urlIcon => CachedNetworkImage(
    imageUrl: asset,
    useOldImageOnUrlChange: true,
    color: color,
    height: size,
    width: size,
  );

  get _flareIcon => FlareIconMap(
    flareIcon: asset,
    iconSize: size,
    flrPath: filePath,
    animation: animation,
  );

  get _lottieIcon => SizedBox(
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
    if (iconData != null) return _icon;
    if (asset.contains('svg') && !asset.contains('md_color')) return _svgIcon;
    if (asset.contains('md_color')) return _svgColorIcon;
    if (asset.contains('http') || asset.contains('www')) return _urlIcon;
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

  IconViewModel({this.size, this.asset, this.iconData, this.animation,
      this.filePath, this.iconType, this.animate, this.color});



  iconView(iconType) {
    switch (iconType) {
      case SchemeIconType.icon:
        return _icon;
      case SchemeIconType.svg:
        return _svgIcon;
      case SchemeIconType.image:
        if (asset != null && (asset.contains('http') || asset.contains('www'))) return _urlIcon;
        return _imageIcon;
      case SchemeIconType.flare:
        return _flareIcon;
      case SchemeIconType.lottie:
        return _lottieIcon;
      case SchemeIconType.color:
        return _svgColorIcon;
      case SchemeIconType.flip:
        return flipIcon;
      default:
        return SizedBox.shrink();
    }
  }


}
