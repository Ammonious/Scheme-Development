import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:math' as math;

import 'package:scheme_utilities/src/color_utils/color_extensions.dart';

import 'color_utils.dart';




paletteFromImage(ImageProvider image) async =>  PaletteGenerator.fromImageProvider(image);


paletteFromTheme(ThemeData themeData, double size)  => PaletteGenerator.fromColors([
      if (themeData.primaryColor != null) PaletteColor(themeData.primaryColor, (size * 2).round()),
      if (themeData.primaryColorDark != null)
        PaletteColor(themeData.primaryColorDark, (size * 2).round()),
      if (themeData.accentColor != null) PaletteColor(themeData.primaryColor, (size * 2).round()),
      if (themeData.colorScheme != null && themeData.colorScheme.secondary != null)
        PaletteColor(themeData.colorScheme.secondary, (size * 2).round()),
      if (themeData.colorScheme != null && themeData.colorScheme.secondaryVariant != null)
        PaletteColor(themeData.colorScheme.secondaryVariant, (size * 2).round()),
    ]);


paletteFromColors(List<Color> colors, double size) {
  List<PaletteColor> items = List();
  colors.forEach((element) =>  items.add(PaletteColor(element, (size * 2).round())));
  return   PaletteGenerator.fromColors(items);

}

// Compute the "distance" of the color swatch and the background color
// so that we can put a border around those color swatches that are too
// close to the background's saturation and lightness. We ignore hue for
// the comparison.
getColorDistance({Color color, Color backgroundColor}) {
  final HSLColor hslColor = HSLColor.fromColor(color ?? Colors.transparent);

  HSLColor backgroundAsHsl = HSLColor.fromColor(backgroundColor);
  return math.sqrt(math.pow(hslColor.saturation - backgroundAsHsl.saturation, 2.0) +
      math.pow(hslColor.lightness - backgroundAsHsl.lightness, 2.0));
}

double _luminLevelOne = .29;
double _luminLevelTwo = .33;

Color textColorLevels(Color color, {double luminLevelTwo = .33}) {
  _luminLevelOne = .29;
  _luminLevelTwo = luminLevelTwo;
  double lumin = color.computeLuminance();
  if (lumin > _luminLevelOne) {
    if (color == Colors.white) {
      return color.darkenBy(96);
    }
    if (lumin > luminLevelTwo)
      return color.darkenBy(78);
    else
      return color.darkenBy(88);
  } else {
    return color.lightenBy(95);
  }
}

MaterialColor generateSwatch(Color src) => MaterialColor(src.value, _generateSwatch(src));

MaterialAccentColor generateAccentSwatch(Color src) =>
    MaterialAccentColor(src.value, _generateAccentSwatch(src));

Map<int, Color> _generateSwatch(Color base) {
  return {
    50: getSwatchShade(base,50),
    100: getSwatchShade(base,100),
    200: Color.fromARGB(255, base.red, base.green, base.blue).lightenBy(23),
    300: Color.fromARGB(255, base.red, base.green, base.blue).lightenBy(15),
    400: Color.fromARGB(255, base.red, base.green, base.blue).lightenBy(5),
    500: Color.fromARGB(255, base.red, base.green, base.blue),
    600: Color.fromARGB(255, base.red, base.green, base.blue).darkenBy(5),
    700: Color.fromARGB(255, base.red, base.green, base.blue).darkenBy(10),
    800: Color.fromARGB(255, base.red, base.green, base.blue).darkenBy(15),
    900: Color.fromARGB(255, base.red, base.green, base.blue).darkenBy(22),
  };
}

Map<int, Color> _generateAccentSwatch(Color color) {
  var baseDark = color.darken;
  var hslBase = HSLColor.fromColor(color);
  var baseTriad = hslBase.withHue((hslBase.hue + 270) % 360).toColor();
  var accentBase = HSLColor.fromColor(Color.lerp(baseDark, baseTriad, 0.15));
  return {
    100: accentBase
        .withSaturation((accentBase.saturation + 0.80).clamp(0, 1))
        .withLightness((accentBase.lightness + 0.65).clamp(0, 1))
        .toColor(),
    200: accentBase
        .withSaturation((accentBase.saturation + 0.80).clamp(0, 1))
        .withLightness((accentBase.lightness + 0.55).clamp(0, 1))
        .toColor(),
    400: accentBase
        .withSaturation((accentBase.saturation + 1.00).clamp(0, 1))
        .withLightness((accentBase.lightness + 0.45).clamp(0, 1))
        .toColor(),
    700: accentBase
        .withSaturation((accentBase.saturation + 1.00).clamp(0, 1))
        .withLightness((accentBase.lightness + 0.40).clamp(0, 1))
        .toColor(),
  };
}

Color _tweak(Color base, double bf, double df, double lf, double wf,
    {Color darker, Color lighter}) {
  if (darker == null) darker = base.darken;
  if (lighter == null) lighter = base.lighten;
  return Color.lerp(Colors.black,
      Color.lerp(Colors.white, Color.lerp(darker, Color.lerp(lighter, base, lf), df), wf), bf);
}

List<Color> _getMaterialColors() {
  List<Color> items = List();
  baseMaterialColors.forEach((element) => items.addAll(getMaterialColorShades(element)));
  accentMaterialColors.forEach((element) => items.addAll(getMaterialColorShades(element)));
  return items;
}

List<Color> get materialColors => _getMaterialColors();

List<Color> getMaterialColorShades(ColorSwatch color) {
  return <Color>[
    if (color[50] != null) color[50],
    if (color[100] != null) color[100],
    if (color[200] != null) color[200],
    if (color[300] != null) color[300],
    if (color[400] != null) color[400],
    if (color[500] != null) color[500],
    if (color[600] != null) color[600],
    if (color[700] != null) color[700],
    if (color[800] != null) color[800],
    if (color[900] != null) color[900],
  ];
}

final List<ColorSwatch> baseMaterialColors = const <ColorSwatch>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

final List<ColorSwatch> accentMaterialColors = const <ColorSwatch>[
  Colors.redAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.deepPurpleAccent,
  Colors.indigoAccent,
  Colors.lightBlueAccent,
  Colors.blueAccent,
  Colors.cyanAccent,
  Colors.tealAccent,
  Colors.greenAccent,
  Colors.lightGreenAccent,
  Colors.limeAccent,
  Colors.yellowAccent,
  Colors.amberAccent,
  Colors.orangeAccent,
  Colors.deepOrangeAccent,
];



class TextColor extends Color {
  static double luminLevelOne = _luminLevelOne;
  static double luminLevelTwo = _luminLevelTwo;

  static int _getBrandColorFromString(Color backgroundColor) {
    String shadedHex = textColorLevels(backgroundColor).hexString.toUpperCase().replaceAll("#", "");
    if (shadedHex.length == 6) {
      shadedHex = "FF" + shadedHex;
    }
    return int.parse(shadedHex, radix: 16);
  }

  TextColor(final Color backgroundColor) : super(_getBrandColorFromString(backgroundColor));
}
