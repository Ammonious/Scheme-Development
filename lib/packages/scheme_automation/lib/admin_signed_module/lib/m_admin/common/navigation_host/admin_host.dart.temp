import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'admin_host_mobile.dart';
import 'admin_host_desktop.dart';
import 'admin_host_tablet.dart';


class AdminHost extends StatelessWidget {
	AdminHost({Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ScreenTypeLayout(mobile: OrientationLayoutBuilder(
			portrait: (context) => mobile(), landscape: (context) => mobile(),),
			tablet: OrientationLayoutBuilder(
				portrait: (context) => tablet(), landscape: (context) => desktop(),),
			desktop: desktop(),);
	}

	mobile() {
		return AdminHostMobile();
	}

	tablet() {
		return AdminHostTablet();
	}

	desktop() {
		return AdminHostDesktop();
	}
}