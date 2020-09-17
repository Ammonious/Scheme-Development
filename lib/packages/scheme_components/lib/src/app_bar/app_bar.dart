import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/app_bar/app_bar_types/fading_app_bar.dart';
import 'package:scheme_components/src/app_bar/controllers/app_bar_controller.dart';
import 'package:scheme_components/src/builders/scheme_builder_controller.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemeAppBar extends GetView<AppBarController> {

  SchemeAppBarStyle style;
  Color color;
  List<Widget> options;
  Widget leading;
  Widget title;
  Widget trailing;
  EdgeInsets padding;
  double height;
  Function(double offset) onScroll;
  Color iconColor;
  List<BoxShadow> boxShadow;
  bool enableColorOffset;
  Color colorOffset;
  bool centerTitle;
  SchemeAppBar._internal(
  {this.title,
    this.boxShadow,
    this.iconColor,
    this.enableColorOffset = false,
    this.color,
    this.options,
    this.leading,
    this.padding,
    this.height,
    this.trailing,
    this.colorOffset,}
  );

  SchemeAppBar.none({
    this.trailing,
    this.title,
    this.leading,
    this.color,
    this.centerTitle = false,
    this.boxShadow}) : style = SchemeAppBarStyle.none;


  SchemeAppBar.fading({
    this.onScroll,
    this.title,
    this.boxShadow,
    this.iconColor,
    this.enableColorOffset = false,
    this.color,
    this.options,
    this.leading,
    this.padding,
    this.height,
    this.trailing,
    this.colorOffset,
  }) : style = SchemeAppBarStyle.fading;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case SchemeAppBarStyle.fading:
        return FadingAppBar(
          title: title,
          boxShadow: boxShadow,
          iconColor: iconColor,
          enableColorOffset: enableColorOffset,
          color: color,
          options: options,
          leading: leading,
          height: height,
          trailing: trailing,
          colorOffset: colorOffset,
          padding: padding,
        );
      case SchemeAppBarStyle.none:
        return _SchemeToolbar(leading: leading,title: title,trailing: trailing,color: color,centerTitle: centerTitle,boxShadow: boxShadow,);
    }
    return Material(
      color: Colors.transparent,
    );
  }


}

enum SchemeAppBarStyle { fading, none }

class _SchemeToolbar extends StatelessWidget {
  final Widget trailing;
  final Widget title;
  final Widget leading;
  final bool centerTitle;
  final Color color;
  final List<BoxShadow> boxShadow;
  _SchemeToolbar(
      {Key key,
        this.trailing,
        this.title,
        this.leading,
        this.color,
        this.centerTitle = false,
        this.boxShadow,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
        color: Colors.transparent,
        child: Container(
          height: appbarWithPadding,
          padding: EdgeInsets.only(
            top: topPadding,left: 16,
          ),
          decoration: BoxDecoration(
              color: color ?? Colors.transparent,
              boxShadow: slightShadow),
          child: NavigationToolbar(
            centerMiddle: centerTitle,
            leading: leading ??
                SchemeIcon.icon(
                  icon: Icons.arrow_back_ios,
                  size: 24,
                ),
            middle: title ??
                SizedBox.shrink(),
            trailing: trailing ?? SizedBox.shrink(),
            ),
          ),
        );
  }
}

