import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BubbleBackground extends StatelessWidget {
	final ThemeData theme;
	final Color backgroundColor;
	final Color primary;
	final Color primaryAccent;
	final Color secondary;
	final double height;
  BubbleBackground({this.theme, this.backgroundColor, this.primary, this.primaryAccent, this.secondary, this.height});


  Color get background => theme != null ? theme.canvasColor : Colors.transparent;
  Color get firstCircleColor => theme != null ? theme.cardColor.withOpacity(0.3) : Colors.white.withOpacity(0.3);
  Color get secondCircleColor => theme != null ? theme.cardColor.withOpacity(0.4) : Colors.white.withOpacity(0.4);
  Color get thirdCircleColor => theme != null ? theme.bottomAppBarColor.withOpacity(0.6) : Colors.white.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
     final _height = height ?? Get.height;
    final width = Get.width;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -(_height / 2 - width / 2),
            bottom: _height * 0.45,
            child: Container(
              height: _height,
              width: _height,
              decoration: BoxDecoration(shape: BoxShape.circle, color:primary ?? firstCircleColor),
            ),
          ),
          Positioned(
            left: width * 0.15,
            top: -width * 0.5,
            child: Container(
              height: width * 1.6,
              width: width * 1.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryAccent ?? secondCircleColor,
              ),
            ),
          ),
          Positioned(
            right: -width * 0.2,
            top: -50,
            child: Container(
              height: width * 0.6,
              width: width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondary ?? thirdCircleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
