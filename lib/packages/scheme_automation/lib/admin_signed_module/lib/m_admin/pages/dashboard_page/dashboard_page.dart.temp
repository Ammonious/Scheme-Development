import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dashboard_page_mobile.dart';
import 'dashboard_page_desktop.dart';
import 'dashboard_page_tablet.dart';


class DashboardPage extends StatelessWidget  {
	DashboardPage({Key key}) : super(key: key);



	@override
	Widget build(BuildContext context) {
		return ScreenTypeLayout(mobile: OrientationLayoutBuilder(
			portrait: (context) => mobile(), landscape: (context) => mobile(),),
			tablet: OrientationLayoutBuilder(
				portrait: (context) => tablet(), landscape: (context) => desktop(),),
			desktop: desktop(),);
	}

	mobile() {
		return DashboardPageMobile();
	}

	tablet() {
		return DashboardPageTablet();
	}

	desktop() {
		return DashboardPageDesktop();
	}

}