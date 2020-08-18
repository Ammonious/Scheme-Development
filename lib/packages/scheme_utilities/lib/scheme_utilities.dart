library scheme_utilities;

import 'package:get/get.dart';
import 'package:scheme_utilities/src/animation_utils.dart';
import 'package:scheme_utilities/src/device_utils.dart';
import 'package:scheme_utilities/src/file_utils/file_utils.dart';
import 'package:scheme_utilities/src/text_style_utils.dart';
import 'package:scheme_utilities/src/transition_utils.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

export 'src/scheme_package_utils.dart';
export 'src/double_utils.dart';
export 'src/int_utils.dart';
export 'src/duration_utils.dart';
export 'src/animation_utils.dart';
export 'src/iterable_utils/iterable_object.dart';
export 'src/color_utils/picaso_utils.dart';
export 'src/file_utils/file_utils_index.dart';
export 'src/animation_utils.dart';
export 'src/text_style_utils.dart';
export 'src/transition_utils.dart';
export 'src/color_utils/color_thief.dart';
export 'src/color_utils/color_extensions.dart';
export 'src/color_utils/color_utils.dart';
export 'src/string_utils/string_index.dart';
export 'src/permission_utils.dart';
export 'src/base_utilities/index.dart';

class SchemeUtils extends GetxController {

	static SchemeFileUtils get file => Get.put(SchemeFileUtils());
	static SchemeDeviceUtils get device => Get.put(SchemeDeviceUtils());
	static SchemeAnimationUtils get animation => Get.put(SchemeAnimationUtils());
	static SchemeFontUtils get font => Get.put(SchemeFontUtils());
	static TransitionUtils get transition => Get.put(TransitionUtils());
}


