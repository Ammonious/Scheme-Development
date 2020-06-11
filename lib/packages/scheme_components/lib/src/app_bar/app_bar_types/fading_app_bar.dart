import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/builders/scheme_builder_controller.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

class FadingAppBar extends HookWidget {
  final SchemeBuilderController controller = Get.find();
  final Color color;
  final List<Widget> options;
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final EdgeInsets padding;
  final double height;
  final Function(double offset) onScroll;
  final Color iconColor;
  final List<BoxShadow> boxShadow;
  final double tabHeight;
  final bool enableColorOffset;
  final Color colorOffset;
  FadingAppBar({
    Key key,
    this.onScroll,
    this.title,
    this.boxShadow,
    this.iconColor,
    this.enableColorOffset = false,
    this.color = Colors.white,
    this.tabHeight = 0,
    this.options,
    this.leading,
    this.padding,
    this.height,
    this.trailing,
    this.colorOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GetBuilder<SchemeBuilderController>(
      init: Get.find<SchemeBuilderController>(),
      builder: (s) {
        double opacity = SchemeBuilderController.to.opacity != null ? s.opacity : 0.0;
      return  Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: normalDuration,
              height: height != null ? height + tabHeight : appbarWithPadding + tabHeight,
              padding: padding ?? EdgeInsets.only(top: topPadding),
              decoration: BoxDecoration(
                  color: color != null ? color.withOpacity(opacity) : Colors.white,
                  boxShadow: boxShadow ??
                      <BoxShadow>[
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15 * opacity),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0)
                      ]),
              child: Column(
                children: [
                  Container(
                    height: kToolbarHeight,
                    child: Stack(
                      children: <Widget>[
                        Visibility(
                          visible: leading != null,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:
                            enableColorOffset ? filterWrap(leading ?? SizedBox.shrink()) : leading,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Visibility(
                            visible: title != null,
                            child: enableColorOffset ? filterWrap(title ?? SizedBox.shrink()) : title,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: enableColorOffset ? filterWrap(trailingWidget) : trailingWidget)
                      ],
                    ),
                  ),
                ],
              ),
            ));
      }
    );
  }

  get trailingWidget => Visibility(
        visible: options != null,
        child: options != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: options ?? [],
              )
            : trailing != null ? trailing : SizedBox.shrink(),
      );
  filterWrap(Widget child) {
    return ColorFiltered(
      child: child,
      colorFilter: ColorFilter.mode(colorOffset ?? color.textColor, BlendMode.srcIn),
    );
  }
}
