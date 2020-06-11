import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';


enum CurveType { concave, convex, none }
class SchemeFieldDecoration {
  final List<BoxShadow> boxShadow;

  /// [NeuTextField] Properties
  ///
  /// This tells the widget to use a different color for the inside of the container, despite whatever is set in the color field.
  final Color cardColor;

  /// This tells the widget to use a different color for the outside emboss/deboss effect, despite whatever is set in the color field.
  final Color backgroundColor;

  /// This receives a [CurveType] enum. Use this to set the inside surface to look either [convex] or [concave].
  final CurveType curveType;

  /// This is false by default. Set this to true in order to make an embossed container.
  final bool emboss;

  ///  How far should the emboss/deboss effect spread?
  final double spread;

  ///  How strong should the emboss/deboss effect be?
  final int depth;

  final TextStyle textStyle;

  /// This receives a number representing a border radius to be applied to all corners of the container.
  final double borderRadius;
  final double height;

  SchemeFieldDecoration._internal(
      {this.boxShadow,
      this.borderRadius = 8,
      this.cardColor = Colors.white,
      this.backgroundColor = Colors.white,
      this.curveType = CurveType.none,
      this.textStyle,
      this.emboss = false,
      this.spread = 6,
      this.height = 72,
      this.depth = 20});

  factory SchemeFieldDecoration.neu({
    List<BoxShadow> boxShadow = flatShadow,
    TextStyle textStyle,
    Color backgroundColor = Colors.white,
    double borderRadius = 8,
    CurveType curveType = CurveType.none,
    bool emboss = false,
    double spread = 6,
    double height = 72,
    int depth = 20,
  }) =>
      SchemeFieldDecoration._internal(
          backgroundColor: backgroundColor,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
          curveType: curveType,
          height: height,
          emboss: emboss,
          spread: spread,
          depth: depth,
          textStyle: textStyle);

  factory SchemeFieldDecoration.card({
    List<BoxShadow> boxShadow = flatShadow,
    TextStyle textStyle,
    Color cardColor = Colors.white,
    double borderRadius = 8,
    double height = 72,
  }) =>
      SchemeFieldDecoration._internal(
          textStyle: textStyle,
		      cardColor: cardColor,
		      borderRadius: borderRadius,
		      boxShadow: boxShadow,
		      height: height,
      );

  factory SchemeFieldDecoration.outline({
    Color backgroundColor,
    Color borderColor,
    double borderRadius,
    double borderWidth,
    double height,
    TextStyle textStyle,
  }) =>
      SchemeFieldDecoration._internal(textStyle: textStyle);
}
