import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/cards/controller/scheme_card_controller.dart';
import 'package:scheme_components/src/styles/scheme_styles.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemePaletteCard extends StatelessWidget {
  final double height;
  final String asset;
  final Color backgroundColor;
  final Widget content;
  final EdgeInsets padding;
  SchemePaletteCard(
      {Key key, this.height = 250, this.backgroundColor = Colors.white,this.content, this.asset, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CardController(),
      initState: (_) => {CardController.to.generatePalette(height,asset: asset)},
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
            child: ShaderMask(blendMode: BlendMode.srcOver,
              shaderCallback: (rect) => LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0,0.35,1.0],
                  colors: [backgroundColor.darkenBy(5), backgroundColor.darkenBy(5).withOpacity(0.95),Colors.transparent,])
                  .createShader(rect),
              child: Image.asset(asset,fit:BoxFit.cover,),
            ),
          ),
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
}
