import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_utilities/scheme_utilities.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import '../scheme_theme.dart';


class Scheme extends GetController {
	static Scheme get to => Get.find();

	///
	/// [Club] Private Variables
	ThemeMode _themeMode;
	ThemeData _theme;
	ThemeData get _defaultTheme => schemeLight(themeColor: _fallbackColor);
	TextTheme get _defaultTextTheme => schemeTextThemeLight;
	ThemeData _themeLight;
	ThemeData _themeDark;
	Color get _fallbackColor => Color(0xFFB8474F);

	bool get isDarkMode => _theme != null && _theme.brightness == Brightness.dark;
	bool get systemThemeMode => _themeMode == ThemeMode.system;
	Brightness get systemBrightness => _theme.brightness;
	TextTheme get textTheme => _theme != null ? _theme.textTheme : _defaultTextTheme;
	ThemeMode get themeMode => _themeMode;
	ThemeData get theme => _theme ?? schemeLight(themeColor: _fallbackColor);
	ThemeData get themeLight => _themeLight ?? schemeLight(themeColor: _fallbackColor);
	ThemeData get themeDark =>
			_themeDark ?? schemeDark(themeColor: _fallbackColor, themeDark: _fallbackColor);

	Color _brandColor;
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
	Color get brandColor => _brandColor ?? _fallbackColor;
	Color get canvasColor => _canvas ?? _canvasLight;
	Color get cardColor => _card ?? _cardLight;
	Color get barColor => _bar ?? _barLight;
	Color get iconColor => _brandColor.shade900.textColor;
	Color get secondaryCardColor => _bar;
	Color get textColor => isDarkMode ? _textDark : _textLight;
	Color get lightBrand => _theme != null ? _theme.primaryColor.shade200 : _fallbackColor.shade200;
	Color get gradientIconColor =>
			_theme != null ? _theme.primaryColor.shade900.textColor : _fallbackColor.shade900.textColor;

	TextStyle get subtitle1 =>
			_theme != null ? _theme.textTheme.subtitle1 : _defaultTextTheme.subtitle1;
	TextStyle get subtitle2 =>
			_theme != null ? _theme.textTheme.subtitle2 : _defaultTextTheme.subtitle2;
	TextStyle get bodyText1 =>
			_theme != null ? _theme.textTheme.bodyText1 : _defaultTextTheme.bodyText1;
	TextStyle get bodyText2 =>
			_theme != null ? _theme.textTheme.bodyText2 : _defaultTextTheme.bodyText2;
	TextStyle get headline1 =>
			_theme != null ? _theme.textTheme.headline1 : _defaultTextTheme.headline1;
	TextStyle get headline2 =>
			_theme != null ? _theme.textTheme.headline2 : _defaultTextTheme.headline2;
	TextStyle get headline3 =>
			_theme != null ? _theme.textTheme.headline3 : _defaultTextTheme.headline3;
	TextStyle get headline4 =>
			_theme != null ? _theme.textTheme.headline6.copyWith(fontSize: 28) : _defaultTextTheme
					.headline6.copyWith(fontSize: 28);
	TextStyle get headline5 =>
			_theme != null ? _theme.textTheme.headline6.copyWith(fontSize: 24) : _defaultTextTheme
					.headline6.copyWith(fontSize: 24);
	TextStyle get headline6 =>
			_theme != null ? _theme.textTheme.headline6 : _defaultTextTheme.headline6;
	TextStyle get branded_button =>
			_theme != null ? _theme.accentTextTheme.button : _defaultTextTheme.button.copyWith(
					color: _fallbackColor.shade800.textColor);
	TextStyle get flat_button => _theme != null ? _theme.textTheme.button : _defaultTextTheme.button;
	TextStyle get button => _theme != null ? _theme.textTheme.button : _defaultTextTheme.button;
	TextStyle get caption => _theme != null ? _theme.textTheme.caption : _defaultTextTheme.caption;
	TextStyle get overline => _theme != null ? _theme.textTheme.overline : _defaultTextTheme.overline;

	TextStyle get title => _theme != null
			? _theme.textTheme.headline6.copyWith(color: barColor.textColor)
			: _defaultTextTheme.headline6.copyWith(color: barColor.textColor);
	TextStyle get number => GoogleFonts.anton(color: brandColor.shade700.textColor, fontSize: 20);
	TextStyle get reward =>
			_theme != null ? _theme.textTheme.caption.copyWith(
					color: isDarkMode ? lightBrand : nearlyBlack) : _defaultTextTheme.caption.copyWith(
					color: isDarkMode ? lightBrand : nearlyBlack);
	SchemeFieldDecoration	 _textFieldDecoration;
	SchemeFieldDecoration	get textFieldDecoration => _textFieldDecoration;

	String getLogo({String logoDarkMode,String logoLightMode}) =>
			_theme != null && _theme.brightness == Brightness.dark ? logoDarkMode : logoLightMode;

	LinearGradient get themGradient =>
			schemeGradient(colorOne: brandColor, colorTwo: brandColor.shade800);

	updateTheme({Color brandColor,Color brandColorDark}) {

		Color themeColor = brandColor ?? _fallbackColor;
		Color themeColorDark = brandColorDark ?? _fallbackColor;

		_themeDark = schemeDark(themeDark: themeColorDark, themeColor: themeColor);
		_themeLight = schemeLight(themeColor: themeColor);
		_theme =
		(_themeMode == ThemeMode.dark) || (_themeMode == ThemeMode.system) ? _themeDark : _themeLight;
		_brandColor = _theme.primaryColor;
		Get.changeTheme(_theme);
		update();
	}

	resetTheme() async {
		_themeDark = schemeDark(themeDark: _fallbackColor);
		_themeLight = schemeLight(themeColor: _fallbackColor);
		_theme = isDarkMode ? _themeDark : _themeLight;
		_brandColor = _fallbackColor;
	}


	setStatusBar() {
		FlutterStatusbarcolor.setStatusBarWhiteForeground(Get.isDarkMode);
		FlutterStatusbarcolor.setNavigationBarColor(barColor);
		FlutterStatusbarcolor.setNavigationBarWhiteForeground(Get.isDarkMode);
	}

	Future<void> setThemeMode(ThemeMode themeMode) async {
		String themeText = themeMode.toString().split('.')[1];
		final prefs = await	StreamingSharedPreferences.instance;
		prefs.setString('theme', themeText);
		_themeMode = themeMode;
		updateTheme();
		setStatusBar();
	}

	getThemeMode() async {
		final prefs = await	StreamingSharedPreferences.instance;
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

Color _textDark = Colors.grey.shade300;
Color _textLight = nearlyBlack;
Color _canvasLight = Colors.white.darkenBy(10);
Color _cardLight = Colors.white.darkenBy(10);
Color _barLight = Colors.white;
Color _canvasDark = Color(0xff121212);
Color _cardDark = Color(0xff121212).lightenBy(10);
Color _barDark = Color(0xff121212).lightenBy(15);
Color _fallbackColor = Color(0xFFB8474F);

ThemeData schemeLight({Color themeColor}) {
	Color brandColor = themeColor ?? _fallbackColor;
	return ThemeData(
		brightness: Brightness.light,
		visualDensity: VisualDensity.adaptivePlatformDensity,
		primarySwatch: generateSwatch(brandColor),
		primaryColor: brandColor,
		primaryColorDark: brandColor,
		accentColor: brandColor,
		textSelectionHandleColor: brandColor,
		primaryColorLight: brandColor.shade400,
		secondaryHeaderColor: _barLight,
		hintColor: Color(0xFF424242),
		canvasColor: _canvasLight,
		cardColor: _cardLight,
		scaffoldBackgroundColor: _canvasLight,
		backgroundColor: _canvasLight,
		dividerColor: Colors.grey.withOpacity(0.45),
		cursorColor: brandColor,
		splashColor: brandColor.withOpacity(0.35),
		hoverColor: brandColor.withOpacity(.35),
		bottomAppBarColor: _barLight,
		textTheme: schemeTextThemeLight,
		primaryTextTheme: schemeTextThemeLight,
		accentTextTheme: schemeTextThemeLight.copyWith(
				button: b_style.copyWith(color: brandColor.shade700.textColor)),
		colorScheme: ColorScheme(
			brightness: Brightness.light,
			primary: brandColor,
			primaryVariant: brandColor,
			secondary: _cardLight.textColor.withOpacity(.75),
			secondaryVariant: _cardLight.textColor.withOpacity(0.8),
			surface: _canvasLight,
			background: _canvasLight,
			error: Colors.redAccent.shade700,
			onSurface: _canvasLight,
			onPrimary: _canvasLight,
			onSecondary: _cardLight,
			onBackground: _canvasLight,
			onError: Colors.redAccent.shade700,
		),
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

ThemeData schemeDark({Color themeColor, Color themeDark}) {
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
		textTheme: schemeTextThemeDark,
		primaryTextTheme: schemeTextThemeDark,
		accentTextTheme: schemeTextThemeLight.copyWith(
				button: b_style.copyWith(color: brandColor.shade700.textColor)),
		colorScheme: ColorScheme(
			brightness: Brightness.dark,
			primary: brandColor,
			primaryVariant: brandColor,
			secondary: _cardDark.textColor.withOpacity(.75),
			secondaryVariant: _cardDark.textColor.withOpacity(0.8),
			surface: _canvasDark,
			background: _canvasDark,
			error: Colors.redAccent.shade700,
			onSurface: _canvasDark,
			onPrimary: _canvasDark,
			onSecondary: _cardDark,
			onBackground: _canvasDark,
			onError: Colors.redAccent.shade700,
		),
		hintColor: Color(0xFF424242),
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

TextTheme get schemeTextThemeDark => TextTheme(
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

TextTheme get schemeTextThemeLight => TextTheme(
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
get _thin => FontWeight.w100;
get _extraLight => FontWeight.w200;
get _light => FontWeight.w300;
get _regular => FontWeight.w400;
get _medium => FontWeight.w500;
get _semiBold => FontWeight.w600;
get _bold => FontWeight.w700;
get _extraBold => FontWeight.w800;
get _black => FontWeight.w900;

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
		fontSize: 22, fontWeight: _regular, textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0));

TextStyle get h6 => GoogleFonts.rubik(
		fontSize: 18, fontWeight: _bold, textStyle: TextStyle(color: nearlyBlack, letterSpacing: 0.15));

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