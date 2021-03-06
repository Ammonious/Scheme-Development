import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TransitionType {
	slideRight,
	slideLeft,
	slideTop,
	slideBottom,
	slideTopFade,
	slideBottomFade,
	slideRightFade,
	slideLeftFade,
	fadeIn,
	zoomIn,
}

class TransitionUtils extends GetxController{

	initTransitionType(TransitionType type) {
		switch (type) {
			case TransitionType.slideRight:
				return slideRight;
			case TransitionType.slideLeft:
				return slideLeft;
			case TransitionType.slideTop:
				return slideTop;
			case TransitionType.slideBottom:
				return slideBottom;
			case TransitionType.slideTopFade:
				return slideTopWithFade;
			case TransitionType.slideBottomFade:
				return slideBottomWithFade;
			case TransitionType.slideRightFade:
				return slideRightWithFade;
			case TransitionType.slideLeftFade:
				return slideLeftWithFade;
			case TransitionType.fadeIn:
				return fadeIn;
			case TransitionType.zoomIn:
				return zoomIn;
			default: return fadeIn;
		}
	}

	  RouteTransitionsBuilder get  slideRight => _slideRight;

	Widget _slideRight(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(-1.0, 0.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: child,
		);
	}

	 RouteTransitionsBuilder get slideLeft => _slideLeft;

 	Widget  _slideLeft(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(1.0, 0.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: child,
		);
	}

	 RouteTransitionsBuilder get slideRightWithFade => _slideRightWithFade;

	Widget _slideRightWithFade(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(-1.0, 0.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: FadeTransition(opacity: animation, child: child),
		);
	}

	 RouteTransitionsBuilder get slideLeftWithFade => _slideLeftWithFade;

	Widget _slideLeftWithFade(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(1.0, 0.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: FadeTransition(opacity: animation, child: child),
		);
	}

	 RouteTransitionsBuilder get slideTop => _slideTop;

	Widget _slideTop(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(0.0, -1.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: child,
		);
	}

	 RouteTransitionsBuilder get slideBottom => _slideBottom;

	Widget _slideBottom(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(0.0, 1.0),
				end: Offset.zero,

			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: child,
		);
	}

	 RouteTransitionsBuilder get slideBottomWithFade => _slideBottomWithFade;

	Widget _slideBottomWithFade(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(0.0, 1.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: FadeTransition(opacity: animation, child: child),
		);
	}

	 RouteTransitionsBuilder  get slideTopWithFade => _slideTopWithFade;

	Widget _slideTopWithFade(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return SlideTransition(
			position: Tween<Offset>(
				begin: const Offset(0.0, -1.0),
				end: Offset.zero,
			).animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn))),
			child: FadeTransition(opacity: animation, child: child),
		);
	}

	  RouteTransitionsBuilder get fadeIn => _fadeIn;

	Widget _fadeIn(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return FadeTransition(opacity: animation, child: child);
	}

	    RouteTransitionsBuilder get zoomIn => _zoomIn;

	Widget _zoomIn(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		return ScaleTransition(scale: animation, child: child);
	}

}