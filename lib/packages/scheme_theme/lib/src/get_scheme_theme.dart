import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_utilities/scheme_utilities.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'constant_presets.dart';
import 'models/theme_controller.dart';
import 'text_theme.dart';
import 'ui_helper.dart';

class GetScheme extends GetController {
  static GetScheme get to => Get.find();

  ///
  /// [Club] Private Variables
  Color _brandColorDark = Colors.pink;
  Rx<Object> get _rxTheme => theme.obs;
  Rx<Object>  get _rxBrandColorDark => _brandColorDark.obs;
  Rx<Object> get _rxBrandColor => isDarkMode ? _rxBrandColorDark : theme.primaryColor.obs;
  ThemeData get _defaultTheme => schemeLight(themeColor: _fallbackColor);
  Color get _fallbackColor => Colors.blueAccent.shade700;

  bool get isDarkMode => theme != null && theme.brightness == Brightness.dark;
  bool get systemThemeMode => themeMode == ThemeMode.system;
  Brightness get systemBrightness => theme.brightness;

  TextTheme get textThemeLight => SchemeTextTheme.to.textThemeLight;
  TextTheme get textThemeDark => SchemeTextTheme.to.textThemeDark;
  TextTheme get textTheme => theme.textTheme;

  ThemeMode get themeMode => ThemeMode.system;
  ThemeData get theme => schemeLight(themeColor: _fallbackColor);
  ThemeData get themeLight => schemeLight(themeColor: _fallbackColor);
  ThemeData get themeDark => schemeDark(themeColor: _fallbackColor, themeDark: _fallbackColor);

  Color _textDark = Colors.grey.shade300;
  Color _textLight = nearlyBlack;
  Color _canvasLight = Colors.white.darkenBy(10);
  Color _cardLight = Colors.white.darkenBy(5);
  Color _barLight = Colors.white;
  Color _canvasDark = Color(0xff121212);
  Color _cardDark = Color(0xff121212).lightenBy(10);
  Color _barDark = Color(0xff121212).lightenBy(15);
  Color get _canvas => isDarkMode ? _canvasDark : _canvasLight;
  Color get _card => isDarkMode ? _cardDark : _cardLight;
  Color get _bar => isDarkMode ? _barDark : _barLight;

  Color get joinColor => Color(0xFF4fb847);
  Color get fullColor => Color(0xFFfdcb2b);
  Color get infoColor => Color(0xFFFBC02D);
  Color get reservedColor => Color(0xFF2962FF);
  Color get brandColor =>  isDarkMode ? _brandColorDark  : _rxBrandColor.value ?? _fallbackColor;
  Color get brandColorDark => _rxBrandColorDark.value ?? Colors.yellowAccent.shade700;
  Color get canvasColor => _canvas ?? _canvasLight;
  Color get cardColor => _card ?? _cardLight;
  Color get barColor => _bar ?? _barLight;
  Color get iconColor => brandColor.shade900.textColor;
  Color get secondaryCardColor => _bar;
  Color get textColor => isDarkMode ? _textDark : _textLight;
  Color get lightBrand => theme != null ? theme.primaryColor.shade200 : _fallbackColor.shade200;
  Color get gradientIconColor =>
      theme != null ? theme.primaryColor.shade900.textColor : _fallbackColor.shade900.textColor;

  TextStyle get subtitle1 => theme != null ? theme.textTheme.subtitle1 : textTheme.subtitle1;
  TextStyle get subtitle2 => theme != null ? theme.textTheme.subtitle2 : textTheme.subtitle2;
  TextStyle get bodyText1 => theme != null ? theme.textTheme.bodyText1 : textTheme.bodyText1;
  TextStyle get bodyText2 => theme != null ? theme.textTheme.bodyText2 : textTheme.bodyText2;
  TextStyle get headline1 => theme != null ? theme.textTheme.headline1 : textTheme.headline1;
  TextStyle get headline2 => theme != null ? theme.textTheme.headline2 : textTheme.headline2;
  TextStyle get headline3 => theme != null ? theme.textTheme.headline3 : textTheme.headline3;
  TextStyle get headline4 => theme != null
      ? theme.textTheme.headline6.copyWith(fontSize: 28)
      : textTheme.headline6.copyWith(fontSize: 28);
  TextStyle get headline5 => theme != null
      ? theme.textTheme.headline6.copyWith(fontSize: 24)
      : textTheme.headline6.copyWith(fontSize: 24);
  TextStyle get headline6 => theme != null ? theme.textTheme.headline6 : textTheme.headline6;

  TextStyle get branded_button => theme != null
      ? theme.accentTextTheme.button
      : textTheme.button.copyWith(color: _fallbackColor.shade800.textColor);

  TextStyle get flat_button => theme != null ? theme.textTheme.button : textTheme.button;
  TextStyle get button => theme != null ? theme.textTheme.button : textTheme.button;
  TextStyle get caption => theme != null ? theme.textTheme.caption : textTheme.caption;
  TextStyle get overline => theme != null ? theme.textTheme.overline : textTheme.overline;

  TextStyle get title => theme != null
      ? theme.textTheme.headline6.copyWith(color: barColor.textColor)
      : textTheme.headline6.copyWith(color: barColor.textColor);
  TextStyle get number => GoogleFonts.anton(color: brandColor.shade700.textColor, fontSize: 20);
  TextStyle get reward => theme != null
      ? theme.textTheme.caption.copyWith(color: isDarkMode ? lightBrand : nearlyBlack)
      : textTheme.caption.copyWith(color: isDarkMode ? lightBrand : nearlyBlack);

  get textFieldDecoration => SchemeFieldDecoration.card(
        cardColor: theme != null ? theme.cardColor : _defaultTheme.cardColor,
        boxShadow: normalShadow,
        height: smallPhone(ScreenUtil.screenHeightDp) ? 62 : 72,
        textStyle: theme != null
            ? theme.textTheme.subtitle1
            : textTheme.subtitle1
                .copyWith(fontSize: smallPhone(ScreenUtil.screenHeightDp) ? 14 : 16),
      );

  LinearGradient get themGradient =>
      schemeGradient(colorOne: brandColor, colorTwo: brandColor.shade800);

  ThemeData setTheme(
      {Color themeColor,
      Color themeColorDark,
      Color textLight,
      Color textDark,
      String googleFont,
      TextTheme textThemeDark,
      TextTheme textThemeLight}) {
    SchemeTextTheme.to.setTextThemeDark(textDark, googleFont, textThemeDark: textThemeDark);
    SchemeTextTheme.to.setTextThemeLight(textLight, googleFont, textThemeLight: textThemeLight);

    return theme;
  }

  updateTheme(Color themeColor,
      {Color themeColorDark, Color textLight, Color textDark, String googleFont}) {
    SchemeTextTheme.to.setTextThemeDark(textDark, googleFont, textThemeDark: textThemeDark);
    SchemeTextTheme.to.setTextThemeLight(textLight, googleFont, textThemeLight: textThemeLight);

    Get.changeTheme(theme);
    update();
  }

  resetTheme() {
  ThemeData  themeDark = schemeDark(themeDark: _fallbackColor);
  ThemeData  themeLight = schemeLight(themeColor: _fallbackColor);
  ThemeData theme = isDarkMode ? themeDark : themeLight;
  Get.changeTheme(theme);
  }

  initScreenUtils() {
    ScreenUtil.init(Get.context,
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        allowFontScaling: true);
  }


  Future<void> setThemeMode(ThemeMode themeMode) async {
    StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
    String themeText = themeMode.toString().split('.')[1];
    await prefs.setString('theme', themeText);
    themeMode = themeMode;
    Get.changeThemeMode(themeMode);


    update();
  }

  getThemeMode() async {
    StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
    bool darkModeSupported = await SchemeUtils.device.darkModeSupported();
    String defaultSetting = 'system';
    ThemeMode  themeMode ;
    if (!darkModeSupported) defaultSetting = 'light';
    String themeText = prefs.getString('theme', defaultValue: defaultSetting).getValue();
    try {
      themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
        themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }

  SystemUiOverlayStyle resolvedSystemUiOverlayStyle() {
    Brightness brightness;
    ThemeMode themeMode;

    switch (themeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    final overlayStyle =
        brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return overlayStyle;
  }
}

Color _textDark = Colors.grey.shade300;
Color _textLight = nearlyBlack;
Color _canvasLight = Colors.white.darkenBy(10);
Color _cardLight = Colors.white.darkenBy(10);
Color _barLight = Colors.white;
Color _canvasDark = Color(0xff121212);
Color _cardDark = Color(0xff121212).lightenBy(10);
Color _barDark = Color(0xff121212).lightenBy(15);
Color _fallbackColor = Color(0xFFB8474F);

ThemeData schemeLight({Color themeColor,Color themeColorDark, TextTheme textThemeLight}) {
  Color brandColor = themeColor ?? _fallbackColor;
  if(textThemeLight == null)  textThemeLight = GoogleFonts.robotoMonoTextTheme();
  return ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: generateSwatch(brandColor),
    primaryColor: brandColor,
    primaryColorDark: themeColorDark ?? brandColor,
    accentColor: brandColor,
    textSelectionHandleColor: brandColor,
    primaryColorLight: brandColor.shade400,
    secondaryHeaderColor: _barLight,
    hintColor: Colors.grey.shade600,
    canvasColor: _canvasLight,
    cardColor: _cardLight,
    scaffoldBackgroundColor: _canvasLight,
    backgroundColor: _canvasLight,
    dividerColor: Colors.grey.withOpacity(0.45),
    cursorColor: brandColor,
    splashColor: brandColor.withOpacity(0.35),
    hoverColor: brandColor.withOpacity(.35),
    bottomAppBarColor: _barLight,
    textTheme: textThemeLight.apply(
        displayColor: _textLight, bodyColor: _textLight, decorationColor: _textLight),
    primaryTextTheme: textThemeLight.apply(
        displayColor: _textLight, bodyColor: _textLight, decorationColor: _textLight),
    iconTheme: IconThemeData(color: _textLight),
    cardTheme: CardTheme(
        color: _cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )),
    buttonTheme:
        ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  );
}

ThemeData schemeDark({Color themeColor, Color themeDark, TextTheme textThemeDark}) {
  Color brandColor = themeDark ?? themeColor ?? _fallbackColor;
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    primarySwatch: generateSwatch(brandColor),
    primaryColor: brandColor,
    primaryColorDark: brandColor,
    textSelectionHandleColor: brandColor,
    accentColor: brandColor,
    primaryColorLight: brandColor.shade200,
    secondaryHeaderColor: _barDark,
    iconTheme: IconThemeData(color: _canvasDark.textColor),
    textTheme: textThemeDark.apply(
        displayColor: _textDark, bodyColor: _textDark, decorationColor: _textDark),
    primaryTextTheme: textThemeDark.apply(
        displayColor: _textDark, bodyColor: _textDark, decorationColor: _textDark),
    hintColor: Colors.grey.shade600,
    cursorColor: brandColor,
    splashColor: brandColor.withOpacity(0.35),
    hoverColor: brandColor.withOpacity(.35),
    canvasColor: _canvasDark,
    cardColor: _cardDark,
    scaffoldBackgroundColor: _canvasDark,
    backgroundColor: _canvasDark,
    dividerColor: Colors.grey.withOpacity(0.45),
    bottomAppBarColor: _barDark,
    cardTheme: CardTheme(
        color: _cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )),
    buttonTheme:
        ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  );
}

const BorderRadius cardRadius = BorderRadius.only(
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16));
