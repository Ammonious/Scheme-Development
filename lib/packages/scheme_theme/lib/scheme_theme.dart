library scheme_theme;

import 'package:get/get.dart';
import 'package:scheme_theme/src/get_scheme_theme.dart';



export 'src/get_scheme_theme.dart';
export 'package:scheme_utilities/scheme_utilities.dart';
export 'src/ui_helper.dart';
export 'src/constant_presets.dart';

export 'src/models/theme_controller.dart';


class GetTheme extends GetController {

static GetScheme get to => Get.put(GetScheme());

}