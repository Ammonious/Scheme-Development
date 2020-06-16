library scheme_theme;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/src/get_scheme_theme.dart';



export 'src/get_scheme_theme.dart';
export 'package:scheme_utilities/scheme_utilities.dart';
export 'src/ui_helper.dart';
export 'src/constant_presets.dart';
export 'src/picaso/picaso_color.dart';
export 'src/picaso/picaso_theme.dart';
export 'src/picaso/picaso_text_theme.dart';
export 'src/models/theme_controller.dart';

extension FontWeightExt on FontWeight {

	/// Thin, the least thick
	static final FontWeight thin = FontWeight.w100;

	/// Extra-light
	static final FontWeight extraLight = FontWeight.w200;

	/// Light
	static final FontWeight light = FontWeight.w300;

	/// Normal / regular / plain
	static final FontWeight normal = FontWeight.w400;

	/// Medium
	static final FontWeight medium = FontWeight.w500;

	/// Semi-bold
	static final FontWeight semiBold = FontWeight.w600;


	/// Extra-bold
	static final FontWeight extraBold = FontWeight.w800;

	/// Black, the most thick
	static final FontWeight black = FontWeight.w900;



}


abstract class Weight   {

	/// Thin, the least thick
	static final FontWeight thin = FontWeight.w100;

	/// Extra-light
	static final FontWeight extraLight = FontWeight.w200;

	/// Light
	static final FontWeight light = FontWeight.w300;

	/// Normal / regular / plain
	static final FontWeight normal = FontWeight.w400;

	/// Medium
	static final FontWeight medium = FontWeight.w500;

	/// Semi-bold
	static final FontWeight semiBold = FontWeight.w600;


	/// Extra-bold
	static final FontWeight extraBold = FontWeight.w800;

	/// Black, the most thick
	static final FontWeight black = FontWeight.w900;

}