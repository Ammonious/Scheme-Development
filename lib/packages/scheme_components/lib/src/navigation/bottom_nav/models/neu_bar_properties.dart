import 'package:flutter/material.dart';
import 'package:scheme_components/src/styles/scheme_field_style.dart';

class NeuProperties {
	final double bevel;
	final double borderRadius;
	final BoxBorder border;
	final BoxShape shape;
	final CurveType curveType;
	final bool showSubtitleText;

	const NeuProperties({
		                           this.bevel = 12.0,
		                           this.borderRadius = 15.0,
		                           this.border,
		                           this.shape = BoxShape.rectangle,
		                           this.curveType = CurveType.concave,
		                           this.showSubtitleText = false,
	                           });
}