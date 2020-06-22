import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'user_host_mobile.dart';
import 'user_host_desktop.dart';
import 'user_host_tablet.dart';


class UserHost extends StatelessWidget {
	UserHost({Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ScreenTypeLayout(mobile: OrientationLayoutBuilder(
			portrait: (context) => mobile(), landscape: (context) => mobile(),),
			tablet: OrientationLayoutBuilder(
				portrait: (context) => tablet(), landscape: (context) => desktop(),),
			desktop: desktop(),);
	}

	mobile() {
		return UserHostMobile();
	}

	tablet() {
		return UserHostTablet();
	}

	desktop() {
		return UserHostDesktop();
	}
}