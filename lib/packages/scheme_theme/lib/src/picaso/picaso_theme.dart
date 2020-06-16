import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'picaso_color.dart';

class Picaso  extends GetController{
  static PicasoColor get paint => Get.put(PicasoColor());
  static Picaso get jot => Get.put(Picaso());
  static Picaso get to => Get.find();





  /// [Picaso] access to [ThemeData].
  ThemeData theme;
 static ThemeData _theme = Get.theme;

  Brightness get brightness => Get.mediaQuery.platformBrightness;

  ThemeMode get themeMode =>_themeMode;
	ThemeMode _themeMode = ThemeMode.system;



  // ignore: slash_for_doc_comments
  /********************************************************************************************************************************
   ********************************************************************************************************************************
   * ? [Picaso] text theme
   ********************************************************************************************************************************
   *********************************************************************************************************************************/

	TextTheme get textTheme => _theme.textTheme;
  TextTheme get primaryTextTheme => _theme.primaryTextTheme;

  TextStyle get headline1 => _theme.textTheme.headline1;
  TextStyle get headline2 => _theme.textTheme.headline2;
  TextStyle get headline3 =>  _theme.textTheme.headline3;
  TextStyle get headline4 =>  _theme.textTheme.headline4;
  TextStyle get headline5 => _theme.textTheme.headline5;
  TextStyle get headline6 => _theme.textTheme.headline6;
  TextStyle get subtitle1 => _theme.textTheme.subtitle1;
  TextStyle get subtitle2 =>_theme.textTheme.subtitle2;
  TextStyle get bodyText1 =>_theme.textTheme.bodyText1;
  TextStyle get bodyText2 => _theme.textTheme.bodyText2 ;
  TextStyle get button => _theme.textTheme.button;
  TextStyle get caption =>_theme.textTheme.caption;
  TextStyle get overline => _theme.textTheme.overline;


  setTheme(
      {Color primary,
      Color primaryVariant,
      Color accent,
      Color secondary,
	    Color secondaryVariant,
      Color canvas,
      Color card,
      Color bar,
      Brightness brightness = Brightness.light,
      TextTheme textTheme,
      TextTheme primaryTextTheme}) {
  	// Set background colors.
    Picaso.paint.canvas = canvas ?? Colors.white.darkenBy(10);
    Picaso.paint.card = bar ?? Colors.white;
    Picaso.paint.bar =  card ?? Colors.white.darkenBy(5);


    // Set Theme Colors.
	  Picaso.paint.primary = primary ?? Colors.blueAccent.shade700;
	  Picaso.paint.primaryVariant = primaryVariant ?? Colors.blue.shade700;
	  Picaso.paint.accent = accent ?? Colors.pinkAccent.shade700;
	  Picaso.paint.secondary = secondary ?? Colors.yellowAccent.shade700;
	  Picaso.paint.secondaryVariant = secondaryVariant ?? Colors.yellowAccent.shade200;

    _theme = ThemeData(
      brightness: brightness,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: generateSwatch(Picaso.paint.primary),
      primaryColor: Picaso.paint.primary,
      primaryColorDark: Picaso.paint.primaryVariant ?? Picaso.paint.primary,
      accentColor: Picaso.paint.accent,
      colorScheme: ColorScheme(
          primaryVariant: Picaso.paint.primaryVariant,
          secondary: Picaso.paint.secondary,
	        secondaryVariant: Picaso.paint.secondaryVariant,
          onError: Colors.redAccent.shade700,
          primary: Picaso.paint.primary,
          onSecondary: Picaso.paint.secondary,
          onSurface: Picaso.paint.canvas,
          surface: Picaso.paint.canvas,
          error: Colors.redAccent.shade700,
          onBackground: Picaso.paint.canvas,
          onPrimary: Picaso.paint.primary,
          background: Picaso.paint.canvas,
          brightness: brightness,),
      textSelectionHandleColor: Picaso.paint.primary,
      primaryColorLight: Picaso.paint.primary.shade200,
      secondaryHeaderColor: Picaso.paint.bar,
      hintColor: Colors.grey.shade600,
      canvasColor: Picaso.paint.canvas,
      cardColor: Picaso.paint.card,
      scaffoldBackgroundColor: Picaso.paint.canvas,
      backgroundColor: Picaso.paint.canvas,
      dividerColor: Colors.grey.withOpacity(0.45),
      cursorColor: Picaso.paint.primary,
      splashColor: Picaso.paint.primary.withOpacity(0.35),
      hoverColor: Picaso.paint.primary.withOpacity(.35),
      bottomAppBarColor: Picaso.paint.bar,
      textTheme: textTheme.apply(
          displayColor: Picaso.paint.canvas.textColor,
          bodyColor: Picaso.paint.canvas.textColor,
          decorationColor: Picaso.paint.canvas.textColor),
      primaryTextTheme: primaryTextTheme != null
          ? primaryTextTheme.apply(
              displayColor: Picaso.paint.canvas.textColor,
              bodyColor: Picaso.paint.canvas.textColor,
              decorationColor: Picaso.paint.canvas.textColor)
          : textTheme.apply(
              displayColor: Picaso.paint.canvas.textColor,
              bodyColor: Picaso.paint.canvas.textColor,
              decorationColor: Picaso.paint.canvas.textColor),
      iconTheme: IconThemeData(color: Picaso.paint.canvas.textColor),
      primaryIconTheme: IconThemeData(color: Picaso.paint.canvas.textColor),
      accentIconTheme: IconThemeData(color: Picaso.paint.primary.shade700.textColor),
      cardTheme: CardTheme(
          color: Picaso.paint.card,
          shape: RoundedRectangleBorder(
            borderRadius: cardRadius,
          )),
      buttonTheme:
          ButtonThemeData(buttonColor: Picaso.paint.primary,
		          shape: RoundedRectangleBorder(
				          borderRadius: BorderRadius.circular(8))),
    );
    return _theme;
  }


  Future<void> setThemeMode(ThemeMode themeMode) async {
	  Get.changeThemeMode(themeMode);
	  update();
	  String themeText = themeMode.toString().split('.')[1];
	  StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
	  await prefs.setString('theme', themeText);
	  _themeMode = themeMode;
  }

  getThemeMode() async {
	  StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
	  bool darkModeSupported = await SchemeUtils.device.darkModeSupported();
	  String defaultSetting = 'system';
	  if(!darkModeSupported) defaultSetting = 'light';
	  String themeText = prefs.getString('theme',defaultValue: defaultSetting).getValue();
	  try {
		  _themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
	  } catch (e) {
		  _themeMode = ThemeMode.system;
	  }
	  setThemeMode(_themeMode);
  }
}
