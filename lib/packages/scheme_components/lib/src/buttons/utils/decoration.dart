import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/shapes/super_ellipse.dart';
import 'package:scheme_theme/scheme_theme.dart';




class SchemeButtonDecoration {
 static SchemeButtonDecoration get to => Get.put(SchemeButtonDecoration());
	ShapeDecoration superEllipseDecoration({List<BoxShadow> boxShadow, LinearGradient gradient,BorderRadius borderRadius}) =>
			ShapeDecoration(
				gradient: gradient,
				shadows: boxShadow ?? flatShadow,
				shape: SuperEllipseShape(
					borderRadius:borderRadius ?? BorderRadius.circular(28),
				),
			);

	BoxDecoration regularThemeDecoration(
			List<BoxShadow> boxShadow, LinearGradient gradient, BorderRadius borderRadius) =>
			BoxDecoration(boxShadow: boxShadow, gradient: gradient, borderRadius: borderRadius);

	ShapeDecoration superEllipseOutline(double borderWidth, Color borderColor,{BorderRadius borderRadius}) => ShapeDecoration(
		shape: SuperEllipseShape(
			side: BorderSide(width: borderWidth, color: borderColor),
			borderRadius:borderRadius ?? BorderRadius.circular(28.0),
		),
	);

	BoxDecoration regularOutline(double borderWidth, Color borderColor) => BoxDecoration(
			border: Border.all(color: borderColor, width: borderWidth),
			borderRadius: BorderRadius.circular(12));

}


