import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'constant_presets.dart';

class SchemeTextTheme extends GetController {
	static SchemeTextTheme get to => Get.put(SchemeTextTheme());


	get	textTheme => GetScheme.to.isDarkMode ? (_rxDark != null ? _rxDark.value : _fallbackTextThemeDark) : (_rxLight != null ? _rxLight.value : _fallbackTextThemeLight);

  setTextThemeLight(Color textLight, String googleFont,{TextTheme textThemeLight}) {
  	if(textThemeLight != null) {
		  _schemeTextThemeLight = textThemeLight;
	  }
  	else {
		  _textLight = textLight ?? nearlyBlack;
		  _googleFont = googleFont;
		  _schemeTextThemeLight = googleFont != null ? GoogleFonts.getTextTheme(googleFont) : _fallbackTextThemeLight;
	  }

  }

    setTextThemeDark(Color textDark, String googleFont,{TextTheme textThemeDark}) {
	    if(textThemeDark != null) {
		    _schemeTextThemeDark = textThemeDark;
	    }
	    else {
		    _textDark = textDark ?? Colors.grey.shade300;
		    _googleFont = googleFont;
		    _schemeTextThemeDark = googleFont != null ? GoogleFonts.getTextTheme(googleFont) : _fallbackTextThemeLight;
	    }

  }

	Rx<Object> get _rxLight => _schemeTextThemeLight.obs;
 Rx<Object> get _rxDark => _schemeTextThemeDark.obs;

  String get googleFont => _googleFont;
  String _googleFont;
  Color get textLight => _textLight ?? _textLight;
  Color get textDark => _textDark ?? _textDark;
  Color _textDark = Colors.grey.shade300;
  Color _textLight = nearlyBlack;
  TextTheme _schemeTextThemeDark;

  TextTheme _schemeTextThemeLight;
  TextTheme get textThemeLight => _schemeTextThemeLight ?? _fallbackTextThemeLight;

  TextTheme get textThemeDark => _schemeTextThemeDark ?? _fallbackTextThemeLight;

  get _thin => FontWeight.w100;
  get _extraLight => FontWeight.w200;
  get _light => FontWeight.w300;
  get _regular => FontWeight.w400;
  get _medium => FontWeight.w500;
  get _semiBold => FontWeight.w600;
  get _bold => FontWeight.w700;
  get _extraBold => FontWeight.w800;
  get _black => FontWeight.w900;


	TextTheme get _fallbackTextThemeDark => TextTheme(
		headline1: h1.copyWith(color: _textDark),
		headline2: h2.copyWith(color: _textDark),
		headline3: h3.copyWith(color: _textDark),
		headline4: h4.copyWith(color: _textDark),
		headline5: h5.copyWith(color: _textDark),
		headline6: h6.copyWith(color: _textDark),
		bodyText1: b1.copyWith(color: _textDark),
		bodyText2: b2.copyWith(color: _textDark),
		subtitle1: s1.copyWith(color: _textDark),
		subtitle2: s2.copyWith(color: _textDark),
		caption: c_style.copyWith(color: Colors.grey.shade500),
		button: b_style.copyWith(color: _textDark),
		overline: o_style.copyWith(color: _textDark),
	);

	TextTheme get _fallbackTextThemeLight => TextTheme(
		headline1: h1.copyWith(color: _textLight),
		headline2: h2.copyWith(color: _textLight),
		headline3: h3.copyWith(color: _textLight),
		headline4: h4.copyWith(color: _textLight),
		headline5: h5.copyWith(color: _textLight),
		headline6: h6.copyWith(color: _textLight),
		bodyText1: b1.copyWith(color: _textLight),
		bodyText2: b2.copyWith(color: _textLight),
		subtitle1: s1.copyWith(color: _textLight),
		subtitle2: s2.copyWith(color: _textLight),
		caption: c_style.copyWith(color: Colors.grey.shade700),
		button: b_style.copyWith(color: _textLight),
		overline: o_style.copyWith(color: _textLight),
	);
  TextStyle get h1 => GoogleFonts.rubikMonoOne(
      fontSize: 73,
      fontWeight: _light,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: -1.5));

  TextStyle get h2 => GoogleFonts.rubikMonoOne(
      fontSize: 46,
      fontWeight: _light,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: -0.5));

  TextStyle get h3 => GoogleFonts.rubikMonoOne(
      fontSize: 36,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.0));

  TextStyle get h4 => GoogleFonts.rubikMonoOne(
      fontSize: 26,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.25));

  TextStyle get h5 => GoogleFonts.rubikMonoOne(
      fontSize: 22,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0));

  TextStyle get h6 => GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: _bold,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.15));

  TextStyle get b1 => GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.5));

  TextStyle get b2 => GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.25));

  TextStyle get s1 => GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.15));

  TextStyle get s2 => GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: _medium,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.1));

  TextStyle get b_style => GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: _medium,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.25));

  TextStyle get c_style => GoogleFonts.rubik(
      fontSize: 12,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.4));

  TextStyle get o_style => GoogleFonts.rubik(
      fontSize: 10,
      fontWeight: _regular,
      textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.5));
}
