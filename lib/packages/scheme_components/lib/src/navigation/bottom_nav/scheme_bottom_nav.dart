import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/navigation/bottom_nav/nav_bar_styles/bubble_nav_bar/bubble_nav_bar.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_constants.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_data.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'controllers/bottom_nav_controller.dart';

class SchemeBottomNavBar extends StatelessWidget {
  final SchemeNavStyle style;
  final List<SchemeNavData> items;
  final List<BoxShadow> boxShadow;
  final Color color;
  final double height;
  final Function(String route) navigateTo;
  final Function(int index) onPositionChanged;
  SchemeBottomNavBar(
      {Key key,
      this.style = SchemeNavStyle.bubble,
      this.items,
      this.color,
      this.boxShadow,
      this.height,
      this.navigateTo,
      this.onPositionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchemeNavController>(
      init: SchemeNavController(),
      builder: (s) => initBottomBar(),
    );
  }

  initBottomBar() {
    switch (style) {
      case SchemeNavStyle.neu:
      case SchemeNavStyle.bubble:
        return BubbleNavBar(
          height: height ?? kBottomNavigationBarHeight,
          items: items,
          backgroundColor: color,
          boxShadow: boxShadow ?? flatShadow,
          onTap: (index) => _handleButtonPress(index),
          currentIndex: SchemeNavController.to.currentIndex,
        );
    }
  }

  _handleButtonPress(index) =>  SchemeNavController.to.selectIndex(index, items[index],
      onPositionChanged: (index) => onPositionChanged(index),
      navigateTo: (route) => navigateTo != null ? navigateTo(route) : () {});
}
