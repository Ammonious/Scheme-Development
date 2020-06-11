import 'dart:core';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/navigation/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:scheme_components/src/navigation/bottom_nav/models/bubble_flip_properties.dart';
import 'package:scheme_components/src/navigation/bottom_nav/views/nav_button_icon.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_data.dart';
import 'package:flutter/material.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

import 'package:scheme_theme/scheme_theme.dart';
 

// Handle the transition between selected and de-deselected, by animating it's own width,
// and modifying the color/visibility of some child widgets
class BubbleNavButton extends HookWidget {
  final SchemeNavData data;
  final int selectedIndex;
  final int index;
  final Function onTap;
  final bool isSelected;
  final Color barColor;
  final bool animate;
  BubbleNavButton( {
    @required this.onTap,
    this.data,
    this.selectedIndex = 0,
    this.isSelected,
    this.index,
    this.barColor,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => onTap(),
      child: GetBuilder<SchemeNavController>(
          init: SchemeNavController(),
          builder: (s) {
            SchemeNavController.to.startAnimIfSelectedChanged(isSelected);
            return Container(
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 4, left: 4),
              child: AnimatedContainer(
                alignment: Alignment.center,
                width: isSelected ? data.width : 56,
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.all(12),
                duration: Duration(milliseconds: 700),
                decoration: BoxDecoration(
                  color: isSelected ? data.selectedColor : barColor,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: ClippedView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      NavBtnIcon(isSelected: isSelected, data: data,animate: animate,),
                      SizedBox(width: 12),
                      Text(data.title,
                        style: data.textStyle.copyWith(color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );

  }

  get textColor => isSelected
  ? data.selectedColor != null
  ? data.selectedColor.textColor
      : Colors.white
      : data.unSelectedColor;

}
