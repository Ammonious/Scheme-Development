import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_components/src/navigation/bottom_nav/views/nav_button_icon.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_constants.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_data.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemeNavRail extends StatelessWidget {
  final List<SchemeNavData> items;
  final double elevation;
  final Color backgroundColor;
  final NavigationRailLabelType labelType; 
  final bool extended;
  final double minWidth;
  final double minExtendedWidth;
  final TextStyle textStyle;
  final Widget header;
  final Widget footer;
  final int selectedIndex;
  final GroupAlignment groupAlignment;
  final Function(int index) onPositionChanged;
  SchemeNavRail({
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
      this.selectedIndex,
     this.onPositionChanged, this.groupAlignment,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Expanded(child: NavigationRail(
        leading: header,
        trailing: footer,
        backgroundColor: backgroundColor,
        elevation: elevation,
        labelType: labelType,
        extended: extended,
        groupAlignment: initAlignment(),
        unselectedIconTheme: Get.theme.iconTheme ?? IconThemeData.fallback(),
        selectedIconTheme: Get.theme.iconTheme.copyWith(color: items.first.selectedColor ?? Colors.transparent),
        selectedLabelTextStyle: textStyle.copyWith(color: items.first.selectedColor ?? Get.theme.primaryColor) ??
            Get.theme.textTheme.subtitle2.copyWith(color: items.first.selectedColor ?? Get.theme.primaryColor),
        unselectedLabelTextStyle: textStyle != null
            ? textStyle.copyWith(color: Get.theme.bottomAppBarColor.textColor)
            : Get.theme.textTheme.subtitle2.copyWith(color: Get.theme.bottomAppBarColor.textColor),
        minExtendedWidth: minExtendedWidth,
        minWidth: minWidth,
        destinations: items != null
            ? List.from(items.map((e) => NavigationRailDestination(
            icon: e.icon ?? NavBtnIcon(data: e, isSelected: false),
            selectedIcon: e.selectedIcon ?? NavBtnIcon(data: e, isSelected: false),
            label: e.label ??
                Text(
                  e.title,
                ))))
            : List<NavigationRailDestination>(),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => onPositionChanged(index),
      ),)
      ],
    );
  }
  initAlignment() {
    switch(groupAlignment){
      case GroupAlignment.top:
        return -1.0;
      case GroupAlignment.center:
        return 0.0;
      case GroupAlignment.bottom:
        return 1.0;
    }
  }
}

