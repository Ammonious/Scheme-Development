import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class CardController extends GetController {
  static CardController get to => Get.put(CardController());

  PaletteGenerator get palette => _rxPalette.value;
  PaletteGenerator _palette;
  FlareIconController flareController;
   get _rxPalette => _palette.obs;

  initFlareController(String asset, {Color primaryColor, Color secondaryColor}) {
    flareController = FlareIconController(
        flareIcon: asset,
        defaultScheme:
            Get.theme.colorScheme.copyWith(primary: primaryColor, secondary: secondaryColor));
  }

  Future<PaletteGenerator> generatePalette(double imageHeight,{ String imageUrl,String asset}) async {
    _palette = await PaletteGenerator.fromImageProvider(
       imageUrl != null ? NetworkImage(imageUrl) : AssetImage(asset),
        size: Size(screenWidth - 32, imageHeight),
        maximumColorCount: 20);
    update();
    return _palette;
  }
}
