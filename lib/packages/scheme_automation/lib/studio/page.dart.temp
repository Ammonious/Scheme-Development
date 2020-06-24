import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'FILE_NAME_mobile.dart';
import 'FILE_NAME_desktop.dart';
import 'FILE_NAME_tablet.dart';

class ClassName extends StatelessWidget {
	ClassName({Key key}) : super(key: key);

@override
Widget build(BuildContext context) {
	return ScreenTypeLayout(
		mobile: OrientationLayoutBuilder(
			portrait: (context) => mobile(),
			landscape: (context) => mobile(),
		),
		tablet: OrientationLayoutBuilder(
			portrait: (context) => tablet(),
			landscape: (context) => desktop(),
		),
		desktop: desktop(),
	);
}

mobile(){
	return ${CamelCaseName}Mobile();
}
tablet(){
	return ${CamelCaseName}Tablet();
}
desktop(){
	return ${CamelCaseName}Desktop();
}
}