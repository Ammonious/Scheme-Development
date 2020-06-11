import 'package:flutter/material.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_components/src/cards/controller/scheme_card_controller.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemeCardOne extends StatelessWidget {
  final Color backgroundColor;
  final Color ovalOneColor;
  final Color ovalTwoColor;
  final double height;
  final Widget content;
  final Widget bottomLeftDecoration;
  final EdgeInsets padding;
  final Function onTap;
  SchemeCardOne(
      {Key key,
      this.backgroundColor = Colors.white,
      this.ovalOneColor = Colors.pink,
      this.height,
      this.content,
      this.ovalTwoColor = Colors.pink,
      this.bottomLeftDecoration,
      this.padding, this.onTap});



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
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: screenWidth / 25, vertical: screenWidth / 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Positioned.fill(
                  top: 140,
                  bottom: -200,
                  right: -100,
                  child: FlutterShine(
                      config: Config(shadowColor: ovalTwoColor ?? Colors.black12),
                      builder: (context, shine) => Container(
                          decoration: BoxDecoration(
                              gradient: schemeGradient(
                                  colorOne: ovalTwoColor, colorTwo: ovalTwoColor.darkenBy(45)),
                              boxShadow: liftedShadow))),
                ),
                Positioned.fill(
                  top: -100,
                  bottom: -100,
                  left: -110,
                  child: Container(
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
                  bottom: 0,
                  left: 0,
                  child: bottomLeftDecoration ?? SizedBox.shrink(),
                ),
                Positioned(
                  top: 40,
                  right: 32,
                  child: SchemeFlare(
                    asset: FlareRes.decoration_dots,
                    primary: ovalOneColor,
                    secondary: ovalTwoColor,
                    animation: 'play',
                    height: 50,
                    width: 50,
                  ),
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


