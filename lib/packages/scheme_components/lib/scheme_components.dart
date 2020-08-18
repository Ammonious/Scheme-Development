library scheme_components;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'src/text_views/link_text.dart';
export 'src/page_views/carousel_slider/carousel_slider.dart';
export 'src/styles/scheme_field_style.dart';


export 'src/animations/material_animation_builder.dart';

export 'src/app_bar/scheme_app_bar.dart';
export 'src/decorations/scheme_decorations.dart';
export 'src/navigation/scheme_navigation.dart';
export 'src/styles/scheme_styles.dart';
export 'src/builders/scheme_builder.dart';

export 'src/animations/icon_rotate.dart';
export 'src/animations/index.dart';
export 'src/hooks/index.dart';
export 'src/animations/teddy_flare/teddy_form_builder.dart';
export 'src/compat/scheme_compat.dart';
export 'src/page_views/scheme_page_views.dart';
export 'src/pickers/scheme_pickers.dart';
export 'src/sheets/scheme_bottom_sheets.dart';
export 'src/loading/loader_index.dart';
export 'src/scrolling/index.dart';
export 'src/text_views/index.dart';
export 'src/images/index.dart';
export 'src/containers/index.dart';
export 'src/buttons/index.dart';
export 'src/text_field/index.dart';
export 'src/shapes/index.dart';
export 'src/keyboard/index.dart';
export 'src/selection/index.dart';
export 'src/progress/index.dart';

class SchemeComponentUtils extends GetxController{
static SchemeComponentUtils get to => Get.put(SchemeComponentUtils());



}





