import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/scheme_theme.dart';
class PicasoColor extends GetController {


  /// The main theme or brand color.
  Color primary;

  /// variant of main theme or brand color.
  Color primaryVariant;


  Color accent;


  Color secondary;

  Color secondaryVariant;

  /// iconColor is the dynamically set [textColor] atop of [canvas], [bar], [card] backgrounds. Not to be used atop primary color backgrounds. Use [accentIconColor] for that.
  Color get iconColor => Picaso.to.theme.primaryIconTheme.color;

  /// [accentIconColor] is the dynamically set [textColor] atop of primary color backgrounds. Accesses the [accentIconTheme] of the current set theme.
  Color get accentIconColor => Picaso.to.theme.accentIconTheme.color;

  /********************************************************************************************************************************
	 ********************************************************************************************************************************
	 * ? [Picaso] background colors
	 ********************************************************************************************************************************
	 *********************************************************************************************************************************/
  /// Default value: 'Colors.white.darkenBy(10)' [canvas] quick access to current themes canvas color. Used to set the background of the lowest level components.
  Color canvas;

  /// Default value: `Color(0xff121212)` [canvasDark] quick access to themes dark [canvasColor]. Typically you'll only need to access [canvas] to  the [Light] or [Dark] theme color that's based of current user or device settings.
  Color get canvasDark => Color(0xff121212);

  /// Default `Colors.white`. [bar] quick access to themes [bottomAppBarColor] color.  Used to set color for [AppBar], [BottomAppBar] and other top level components.
  Color bar;

  /// Default value: `Color(0xff121212).lightenBy(15)` [barDark] quick access to themes dark [bottomAppBarColor]. Typically you'll only need to access [bar] to  the [Light] or [Dark] theme color that's based of current user or device settings.
  Color get barDark => Color(0xff121212).lightenBy(15);

  /// Default value: `Colors.white.darkenBy(5)` [card] quick access to themes card color. Used to set color of [Card] and [Container] that lay  below the [AppBar] in elevation.
  Color card;

  /// Default value: `Color(0xff121212).lightenBy(10)` [cardDark] quick access to themes dark card color.  Typically you'll only need to access [card] to  the [Light] or [Dark] theme color that's based of current user or device settings.
  Color get cardDark => Color(0xff121212).lightenBy(10);
}
