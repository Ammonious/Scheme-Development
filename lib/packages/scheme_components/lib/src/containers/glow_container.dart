import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlowView extends StatelessWidget {
	const GlowView({
		Key key,
		this.height,
		this.width,
		this.color,
		this.alignment,
		this.borderRadius,
		this.border,
		this.shape,
		this.offset,
		this.spreadRadius,
		this.blurRadius,
		this.animationDuration,
		this.animationCurve = Curves.linear,
	}) : super(key: key);

	final double height;
	final double width;
	final Color color;
	final BorderRadiusGeometry borderRadius;
	final AlignmentGeometry alignment;
	final BoxBorder border;
	final BoxShape shape;

	//animation
	final Duration animationDuration;
	final Curve animationCurve;

	final Offset offset;
	final double spreadRadius;
	final double blurRadius;

	@override
	Widget build(BuildContext context) {
		final theme = Get.theme ?? Theme.of(context);
		return AnimatedContainer(
			height: height,
			width: width,
			alignment: alignment,
			duration: animationDuration ?? const Duration(milliseconds: 300),
			curve: animationCurve ?? Curves.linear,
			decoration: BoxDecoration(
				color: color ?? theme.primaryColor ?? kDefaultColor,
				borderRadius: borderRadius,
				boxShadow: [
					BoxShadow(
						color: color ?? theme.primaryColor ?? kDefaultColor,
						offset: offset  ?? kDefaultOffset,
						blurRadius: blurRadius ?? kDefaultBlurRadius,
						spreadRadius: spreadRadius ?? kDefaultSpreadRadius,
					),
				],
				border: border,
				shape: shape ?? BoxShape.rectangle,
			),
		);
	}
}

const Color kDefaultColor = Color(0x1e000000);
const double kDefaultBlurRadius = 6.0;
const Offset kDefaultOffset = Offset(0, 2);
const double kDefaultSpreadRadius = 0.0;