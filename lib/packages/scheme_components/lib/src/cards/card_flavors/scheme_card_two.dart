import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/cards/controller/scheme_card_controller.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

import '../../../scheme_components.dart';

class SchemeCardTwo extends StatelessWidget {
  final Color backgroundColor;
  final Color ovalOneColor;
  final Color ovalTwoColor;
  final double height;
  final Widget content;
  final Widget bottomLeftDecoration;
  final EdgeInsets padding;
  final LinearGradient backgroundGradient;
  SchemeCardTwo(
      {Key key,
      this.backgroundColor,
      this.ovalOneColor,
      this.ovalTwoColor,
      this.height,
      this.content,
      this.bottomLeftDecoration,
      this.padding, this.backgroundGradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CardController(),
      initState: (_) => CardController.to.initFlareController(FlareRes.decoration_dots,
          primaryColor: ovalOneColor, secondaryColor: ovalTwoColor),
      builder: (s) => Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              boxShadow: liftedShadow,
              color: backgroundColor,
              gradient: backgroundGradient,
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: screenWidth / 25, vertical: screenWidth / 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[

                Positioned(
                  top: 0,
                  bottom: 0,
                  right: -200,
                  child: Container(
                    height: screenWidth,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: backgroundColor.darkenBy(5).withOpacity(0.42),
                              blurRadius: 50,
                              spreadRadius: 2,
                              offset: Offset(20, 0)),
                          BoxShadow(
                              color: backgroundColor.withOpacity(0.12),
                              blurRadius: 0,
                              spreadRadius: -2,
                              offset: Offset(0, 0)),
                        ],
                        shape: BoxShape.circle,
                        gradient: schemeGradient(
                            colorOne: ovalOneColor.lightenBy(20),
                            colorTwo: ovalOneColor.darkenBy(50))),
                  ),
                ),
                Positioned(
                  top: height * .65,
                  bottom: -50,
                  right: -50,
                  child: Transform.rotate(
                    angle: pi / -3,
                    child: Container(
                      width: height,
                        decoration: BoxDecoration(
                            gradient: schemeGradient(
                                colorOne: ovalTwoColor, colorTwo: ovalTwoColor.darkenBy(45)))),
                  )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: bottomLeftDecoration ?? SizedBox.shrink(),
                ),
                Padding(
                  padding: padding ?? EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
