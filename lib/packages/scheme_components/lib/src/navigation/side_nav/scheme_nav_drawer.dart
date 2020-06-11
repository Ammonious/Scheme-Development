import 'package:flutter/material.dart';
import 'package:scheme_components/src/navigation/side_nav/controllers/scheme_drawer_controller.dart';
import 'package:scheme_components/src/navigation/side_nav/scheme_rail_nav.dart';

import '../scheme_navigation.dart';

enum GroupAlignment {top,center,bottom}
class SchemeNavDrawer extends StatelessWidget {
  SchemeDrawerStyle style;
  List<SchemeNavData> items;
  double elevation;
  Color backgroundColor;
  NavigationRailLabelType labelType;
  bool extended;
  double minWidth;
  double minExtendedWidth;
  TextStyle textStyle;
  Widget header;
  Widget footer;
  int selectedIndex;
  Function(int index) onPositionChanged;
   GroupAlignment groupAlignment;
  SchemeNavDrawer({
    this.extended,
    this.minWidth,
    this.minExtendedWidth,
    this.items,
    this.elevation,
    this.backgroundColor,
    this.labelType,
    this.header,
    this.footer,
    this.textStyle,
    this.selectedIndex = 0,
    this.groupAlignment,
    this.onPositionChanged,
  });

  SchemeNavDrawer.rail({
    this.extended,
    this.minWidth,
    this.minExtendedWidth,
    this.items,
    this.elevation,
    this.backgroundColor,
    this.labelType,
    this.header,
    this.footer,
    this.textStyle,
    this.selectedIndex = 0,
    this.groupAlignment,
    this.onPositionChanged,
  }) : style = SchemeDrawerStyle.rail;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case SchemeDrawerStyle.rail:
        return SchemeNavRail(
          header: header,
          footer: footer,
          groupAlignment: groupAlignment,
          backgroundColor: backgroundColor,
          elevation: elevation,
          labelType: labelType,
          extended: extended,
          textStyle: textStyle,
          minExtendedWidth: minExtendedWidth,
          minWidth: minWidth,
          selectedIndex: selectedIndex,
          onPositionChanged: (index) => onPositionChanged(index),
          items: items,
        );
    }
  }
}
