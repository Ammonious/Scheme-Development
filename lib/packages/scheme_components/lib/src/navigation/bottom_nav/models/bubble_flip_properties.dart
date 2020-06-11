//Takes a x,y or z rotation, in degrees, and rotates. Good for spins & 3d flip effects
import 'package:flutter/material.dart';
import 'dart:math';


//Hides the overflow of a child, preventing the Flutter framework from throwing errors
class ClippedView extends StatelessWidget {
	final Widget child;
	final Axis clipDirection;

	const ClippedView({Key key, this.child, this.clipDirection = Axis.horizontal}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			physics: NeverScrollableScrollPhysics(),
			scrollDirection: clipDirection,
			child: child,
		);
	}
}