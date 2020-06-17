import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  Loader({Key key, this.color, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
	      height: height ?? Get.height,
        width: width ?? Get.width,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(color ?? Get.theme.primaryColor),
          ),
        ),
      ),
    );
  }
}
