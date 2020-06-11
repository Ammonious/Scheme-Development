library scheme_components;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'src/text_views/link_text.dart';
export 'src/buttons/scheme_button.dart';
export 'src/buttons/utils/decoration.dart';
export 'src/page_views/carousel_slider/carousel_slider.dart';
export 'src/buttons/utils/button_constants.dart';
export 'src/styles/scheme_field_style.dart';


export 'src/animations/material_animation_builder.dart';

export 'src/app_bar/scheme_app_bar.dart';
export 'src/decorations/scheme_decorations.dart';
export 'src/navigation/scheme_navigation.dart';
export 'src/styles/scheme_styles.dart';
export 'src/builders/scheme_builder.dart';

export 'src/animations/icon_rotate.dart';
export 'src/animations/scheme_animations.dart';
export 'src/hooks/scheme_hooks.dart';
export 'src/animations/teddy_flare/teddy_form_builder.dart';
export 'src/compat/scheme_compat.dart';
export 'src/page_views/scheme_page_views.dart';

class SchemeComponentUtils extends GetController{
static SchemeComponentUtils get to => Get.put(SchemeComponentUtils());


}




