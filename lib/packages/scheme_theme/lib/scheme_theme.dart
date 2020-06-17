library scheme_theme;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'package:scheme_utilities/scheme_utilities.dart';
export 'src/ui_helper.dart';
export 'src/models/theme_controller.dart';
export 'src/picaso/picaso.dart';
export 'src/constant_presets.dart';
export 'src/theme_changer/theme_changer_index.dart';

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