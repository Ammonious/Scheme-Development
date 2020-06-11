import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  final Widget child;
  final Color closedColor;
  final bool tappable;
  final ContainerTransitionType transitionType;
  const OpenContainerWrapper(
      {Key key,
      this.child,
      this.closedBuilder,
      this.transitionType,
      this.closedColor = Colors.white,
      this.tappable = false})
      : super(key: key);

  final OpenContainerBuilder closedBuilder;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: transitionType,
      closedColor: closedColor,
      openBuilder: (BuildContext context, VoidCallback _) => child,
      tappable: tappable,
      closedBuilder: closedBuilder,
    );
  }
}
