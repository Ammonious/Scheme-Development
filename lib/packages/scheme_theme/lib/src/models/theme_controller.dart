import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ThemeController extends RxController {

	static ThemeController get to => Get.find();

	static const String darkModeBox = 'theme_mode';

	initHive() async =>  await Hive.initFlutter();
	initHiveTheme(){

	}
	StreamingSharedPreferences prefs;
	StreamingSharedPreferences _prefs;
	get rxPrefs => _prefs.obs;

	Box _themeBox;

	Box get themeBox => _themeBox;

	ThemeMode _themeMode;
	ThemeMode get themeMode => _rxThemeMode.value;

	Rx<Object> get _rxThemeMode => _themeMode.obs;


	saveThemeMode(ThemeMode themeMode)  {
		_themeMode = themeMode;
		initHiveTheme();
		_themeBox.put('theme', themeMode.toString().split('.')[1]);
		Get.changeThemeMode(_themeMode);
	}
	ThemeMode	getThemeMode(){
		String themeText = themeBox.get('theme',defaultValue: 'system');
		try {
			_themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
		} catch (e) {
			_themeMode = ThemeMode.system;
		}

		return _themeMode;
	}
}