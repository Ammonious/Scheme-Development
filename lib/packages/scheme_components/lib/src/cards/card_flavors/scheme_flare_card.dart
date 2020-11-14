import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

import '../../../scheme_components.dart';
import '../controller/scheme_card_controller.dart';
enum FlareCardType {fill,align}
class SchemeFlareCard extends StatelessWidget {
  final double height;
  final Widget content;
  final EdgeInsets padding;
  final String flareAsset;
  final bool pauseAnimation;
  final Color scrimColor;

  Alignment alignment;
  FlareCardType cardType;
  double flareHeight;
  double flareWidth;
  SchemeFlareCard(
      {Key key,
      this.height = 250,
      this.content,
      this.padding,
      this.flareAsset,
      this.pauseAnimation = false,
      this.scrimColor = Colors.black38});

  SchemeFlareCard.fill(
      {Key key,
        this.height = 250,
        this.content,
        this.padding,
        this.flareAsset,
        this.pauseAnimation = false,
        this.scrimColor = Colors.black38}) : cardType = FlareCardType.fill;

  SchemeFlareCard.align(
      {Key key,
        this.height = 250,
        this.content,
        this.padding,
        this.flareAsset,
        this.flareHeight = 100,
        this.flareWidth = 100,
        this.pauseAnimation = false,
        this.alignment = Alignment.center,
        this.scrimColor = Colors.black38}) : cardType = FlareCardType.align;


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CardController(),
      builder: (s) => Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              boxShadow: normalShadow,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: screenWidth / 25, vertical: screenWidth / 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: <Widget>[
               _body(),

                Padding(
                  padding: padding ?? EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: content ?? SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _body(){
    switch(cardType){

      case FlareCardType.fill:
        return  Positioned.fill(
          child: ShaderMask(blendMode: BlendMode.multiply,
            shaderCallback: (rect) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0,0.3,0.7],
                colors: [ Color(0xffCCBCD7).darkenBy(25),Color(0xffCCBCD7).darkenBy(15),Colors.transparent,])
                .createShader(rect),
            child: SchemeFlare(
              asset: flareAsset ?? FlareRes.travel_train_bg,
              animation: 'play',
              height: height,
              width: screenWidth,
              isPaused: pauseAnimation,
              fit: BoxFit.cover,
            ),
          ),
        );
      case FlareCardType.align:
        return Align(alignment: alignment ?? Alignment.center,child: SchemeFlare(
          asset: flareAsset ?? FlareRes.travel_train_bg,
          animation: 'play',
          height: flareHeight,
          width: flareWidth,
          isPaused: pauseAnimation,
          fit: BoxFit.contain,
        ),);
    }
  }


}
