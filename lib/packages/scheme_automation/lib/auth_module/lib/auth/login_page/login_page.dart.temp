import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'login_page_mobile.dart';
import 'login_page_desktop.dart';
import 'login_page_tablet.dart';


class LoginPage extends StatelessWidget {
	LoginPage({Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ScreenTypeLayout(mobile: OrientationLayoutBuilder(
			portrait: (context) => mobile(), landscape: (context) => mobile(),),
			tablet: OrientationLayoutBuilder(
				portrait: (context) => tablet(), landscape: (context) => desktop(),),
			desktop: desktop(),);
	}

	mobile() {
		return LoginPageMobile();
	}

	tablet() {
		return LoginPageTablet();
	}

	desktop() {
		return LoginPageDesktop();
	}
}