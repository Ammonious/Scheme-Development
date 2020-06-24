import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ThemeController extends RxController {

	static ThemeController get to => Get.find();

	static const String darkModeBox = 'theme_mode';
 
	StreamingSharedPreferences prefs;
	StreamingSharedPreferences _prefs;
	get rxPrefs => _prefs.obs;
 

	ThemeMode _themeMode;
	ThemeMode get themeMode => _rxThemeMode.value;

	Rx<Object> get _rxThemeMode => _themeMode.obs;


	saveThemeMode(ThemeMode themeMode)  {
		_themeMode = themeMode;  
		Get.changeThemeMode(_themeMode);
	}
	Future<ThemeMode>	getThemeMode() async{
		StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
		String themeText = prefs.getString('theme',defaultValue: 'system').getValue();
		try {
			_themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
		} catch (e) {
			_themeMode = ThemeMode.system;
		}

		return _themeMode;
	}
}