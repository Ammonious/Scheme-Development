import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class MotionBuilder extends StatelessWidget {
	final OpenContainerBuilder closedBuilder;
	final ContainerTransitionType transitionType;
	final Widget destination;
	final bool tappable;
	const MotionBuilder({
		this.closedBuilder,
		this.transitionType, this.destination, this.tappable = false,
	});



	@override
	Widget build(BuildContext context) {
		return OpenContainer(
			openColor: Colors.transparent,
			closedColor: Colors.transparent,
			transitionDuration: Duration(milliseconds: 550),
			transitionType: transitionType ?? ContainerTransitionType.fadeThrough ,
			openBuilder: (BuildContext context, VoidCallback _) => destination,
			tappable: tappable,
			closedBuilder: closedBuilder,
		);
	}
}



