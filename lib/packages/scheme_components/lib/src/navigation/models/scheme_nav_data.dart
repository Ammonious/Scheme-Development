import 'package:flutter/material.dart';
import 'package:scheme_icons/scheme_icons.dart';

class SchemeNavData {
  /// Title of the button. Must not be null if using [SchemeNavRail].
  String title;

  SchemeIconType iconType;

  /// [SchemeNavRail] - child replaces the [title]. Can be used to show a [Column] with title and subtitle.
  Widget label;

  /// Optional [TextStyle] for [Navigation] title.
  TextStyle textStyle;

  /// [Icon] for the given button
  Widget icon;

  /// [Icon] for the given button
  Widget selectedIcon;

  /// [IconData] iconData for the given item. Must not be null if using [SchemeNavRail].
  IconData iconData;

  /// [String] value with covers [SchemeIcons.svg], [SchemeIcons.color],[SchemeIcons.image],[SchemeIcons.lottie]-
  String iconPath;

  /// [String] value with covers [SchemeIcons.svg], [SchemeIcons.color],[SchemeIcons.image],[SchemeIcons.lottie]-
  String selectedIconPath;

  /// [IconData] selectedIcon for the given item. Must not be null if using [SchemeNavRail].
  IconData selectedIconData;

  double iconSize;

  Color unSelectedColor;

  /// Selected [Color] of the button
  Color selectedColor;

  /// This is specific to [BottomNavigation] button width.
  double width;

  /// Route name for [Route] navigation.
  String route;

  Widget page;

  ColorScheme selectedScheme;

  ColorScheme unSelectedScheme;


  SchemeNavData({
    @required this.title,
    this.icon,
    this.width = 110,
    this.selectedColor,
    this.selectedIcon,
    this.iconPath,
    this.selectedIconPath,
    this.label,
    this.selectedIconData,
    this.iconData,
    this.route,
    this.textStyle,
    this.selectedScheme,
    this.unSelectedScheme,
    this.iconSize = 24,
    this.unSelectedColor,
    this.iconType,
    this.page,
  });

  SchemeNavData.flare(this.iconPath,{
    this.iconSize = 24,
    this.width = 110,
    this.title,
    this.route,
    this.label,
    this.selectedScheme,
    this.unSelectedScheme,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.flare;
  SchemeNavData.flip(this.iconPath,{
    this.iconSize = 24,
    this.width = 110,
    this.selectedIconPath,
    this.title,
    this.route,
    this.label,
    this.selectedColor,
    this.unSelectedColor,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.flip;

  SchemeNavData.icon(this.iconData,{
    this.selectedIconData,
    this.iconSize = 24,
    this.width = 110,
    this.title,
    this.route,
    this.label,
    this.selectedColor,
    this.unSelectedColor,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.icon;

  SchemeNavData.svg(this.iconPath,{
    this.iconSize = 24,
    this.width = 110,
    this.selectedIconPath,
    this.title,
    this.route,
    this.label,
    this.selectedColor,
    this.unSelectedColor,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.svg;

  SchemeNavData.image(this.iconPath,{
    this.iconSize = 24,
    this.width = 110,
    this.selectedIconPath,
    this.title,
    this.route,
    this.label,
    this.selectedColor,
    this.unSelectedColor,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.image;

  SchemeNavData.color(this.iconPath,{
    this.iconSize = 24,
    this.width = 110,
    this.selectedIconPath,
    this.title,
    this.route,
    this.label,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.color,
  selectedColor = Colors.transparent,
  unSelectedColor = Colors.transparent;

  SchemeNavData.lottie(this.iconPath,{
    this.iconSize = 24,
    this.width = 110,
    this.selectedIconPath,
    this.title,
    this.route,
    this.label,
    this.selectedColor,
    this.unSelectedColor,
    this.textStyle,
    this.page,
  }) : iconType = SchemeIconType.lottie;
}
