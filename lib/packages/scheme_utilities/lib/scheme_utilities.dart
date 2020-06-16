library scheme_utilities;

import 'package:get/get.dart';
import 'package:scheme_utilities/src/animation_utils.dart';
import 'package:scheme_utilities/src/device_utils.dart';
import 'package:scheme_utilities/src/file_utils.dart';
import 'package:scheme_utilities/src/text_style_utils.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

export 'src/scheme_package_utils.dart';
export 'src/double_utils.dart';
export 'src/int_utils.dart';
export 'src/duration_utils.dart';
export 'src/animation_utils.dart';
export 'src/iterable_utils/iterable_object.dart';
export 'src/color_utils/color_utils.dart';
export 'src/file_utils.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'src/animation_utils.dart';
export 'package:lumberdash/lumberdash.dart';
export 'package:colorize_lumberdash/colorize_lumberdash.dart';
export 'src/text_style_utils.dart';
class SchemeUtils extends GetController {

	static SchemeFileUtils get file => Get.put(SchemeFileUtils());
	static SchemeDeviceUtils get device => Get.put(SchemeDeviceUtils());
	static _SchemePrefs get prefs => Get.put(_SchemePrefs());
	static SchemeAnimationUtils get animation => Get.put(SchemeAnimationUtils());
	static SchemeFontUtils get font => Get.put(SchemeFontUtils());

}

class _SchemePrefs extends GetController {

	StreamingSharedPreferences get data => _rxPrefs.value;
	StreamingSharedPreferences _prefs;
	get _rxPrefs => _prefs.obs;
	Future<dynamic>	initPrefs() async => _prefs = await StreamingSharedPreferences.instance;

}
