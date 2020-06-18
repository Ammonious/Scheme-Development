import 'package:flutter/material.dart';
import 'package:scheme_utilities/src/color_utils/picaso_colorizer.dart';
import 'dart:math' as math;
import 'picaso_utils.dart';
import 'picaso_colorizer.dart';
extension StringToColor on String {
  int _getColorFromHex(String hexColor) {
    if (hexColor == null) hexColor = Colors.white.hexString;

    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  Color get toColor => Color(_getColorFromHex(this));
}

extension ColorExtension on Color {
  /// Colors.red.tweenTo(Colors.blue) // ColorTween(begin: Colors.red, end: Colors.blue);
  /// ```
  ColorTween tweenTo(Color end) {
    return ColorTween(begin: this, end: end);
  }

  bool get isBlack => PicasoColorizer(this).colorIsBlack;

  bool isDarkerThan(Color anotherColor) => PicasoColorizer(this).isDarkerThan(anotherColor);


  /// [distanceFrom] Computes the "distance" of the color swatch and the background color
  /// useful for deciding on if you need to add border around those color swatches that are too
  /// close to the background's [saturation] and [lightness]. We ignore [hue] for
  /// the comparison.
  double distanceFrom(Color backgroundColor) =>
      getColorDistance(color: this, backgroundColor: backgroundColor);

  /// Mix two [Colors] together to form a new [Color].
  mix(Color another, double amount) => Color.lerp(this, another, amount);

  /// Spin a color and get another.
  spin(double amount) => PicasoColorizer(this).spin(amount);

  /// Convert color to hex string
  String get hexString => this == null
      ? Colors.blue.value.toRadixString(16).substring(2, this.value.toRadixString(16).length)
      : this.value.toRadixString(16).substring(2, this.value.toRadixString(16).length);

  lightenBy(int percent) => _lighter(percent);

  darkenBy(int percent) => _darker(percent);

  Color get darken => Color.fromARGB(-1, (this.red * this.red) ~/ 255,
      (this.green * this.green) ~/ 255, (this.blue * this.blue) ~/ 255);

  Color get lighten => Color.fromARGB(-1, (math.sqrt(this.red / 255) * 255).floor(),
      (math.sqrt(this.green / 255) * 255).floor(), (math.sqrt(this.blue / 255) * 255).floor());

  get _materialColor => generateSwatch(this);

  Color get shade50 => _materialColor[50];

  Color get shade100 => _materialColor[100];

  Color get shade200 => _materialColor[200];

  Color get shade300 => _materialColor[300];

  Color get shade400 => _materialColor[400];

  Color get shade500 => _materialColor[500];

  Color get shade600 => _materialColor[600];

  Color get shade700 => _materialColor[700];

  Color get shade800 => _materialColor[800];

  Color get shade900 => _materialColor[900];

  Color get compColor => PicasoColorizer(this).complimentary;

  Color get textColor => TextColor(this);

  Color adjustTextColorBy({double luminLevelTwo = .33}) =>
      textColorLevels(this, luminLevelTwo: luminLevelTwo);

  /// Make color lighter by so many [percents]
  Color _lighter(int percents) {
    assert(percents >= 1 && percents <= 100);
    final int rgbPercent = (percents / 100 * 255).round();
    int red = this.red + rgbPercent, green = this.green + rgbPercent, blue = this.blue + rgbPercent;
    if (red > 255) {
      red = 255;
    }
    if (green > 255) {
      green = 255;
    }
    if (blue > 255) {
      blue = 255;
    }
    return Color.fromARGB(alpha, red, green, blue);
  }

  /// Make color darker by so many [percents]
  Color _darker(int percents) {
    assert(percents >= 1 && percents <= 100);
    final int rgbPercent = (percents / 100 * 255).round();
    int red = this.red - rgbPercent, green = this.green - rgbPercent, blue = this.blue - rgbPercent;
    if (red < 0) {
      red = 0;
    }
    if (green < 0) {
      green = 0;
    }
    if (blue < 0) {
      blue = 0;
    }
    return Color.fromARGB(alpha, red, green, blue);
  }
}
