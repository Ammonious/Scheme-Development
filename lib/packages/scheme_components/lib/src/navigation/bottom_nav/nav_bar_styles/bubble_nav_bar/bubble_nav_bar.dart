

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/navigation/bottom_nav/models/bubble_flip_properties.dart';
import 'package:scheme_components/src/navigation/bottom_nav/nav_bar_styles/bubble_nav_bar/bubble_nav_button.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_data.dart';
import 'package:scheme_theme/scheme_theme.dart';

class BubbleNavBar extends StatelessWidget {
	final Function(int index) onTap;
	final int currentIndex;
	final List<SchemeNavData> items;
	final double height;
	final Color backgroundColor;
	final List<BoxShadow> boxShadow;
	const BubbleNavBar({this.items, this.onTap, this.currentIndex = 0, this.height, this.backgroundColor, this.boxShadow,});

	SchemeNavData get selectedItem => currentIndex >= 0 && currentIndex < items.length ? items[currentIndex] : null;

	@override
	Widget build(BuildContext context) {
		final barColor = backgroundColor ?? Get.theme.bottomAppBarColor ?? Colors.white;
		List<Widget> buttonWidgets = items.map((data) {

			bool isSelected = data == selectedItem;
			int index = items.indexOf(data);

			return BubbleNavButton(
					data:data,
					isSelected: isSelected,
					selectedIndex: items.indexOf(selectedItem),
					index: index,
					barColor: barColor,
					onTap: () => onTap(index),);
		}).toList();

		return AnimatedContainer(
			duration: normalDuration,
			alignment: Alignment.center,
			height: height ?? 72,
			decoration: BoxDecoration(
				color:  barColor,
				boxShadow: boxShadow ??
						bottomBarShadow,
			),
			child: ClippedView(
				child:  Row(
		mainAxisAlignment: MainAxisAlignment.center,
		children: buttonWidgets)
		)
		);
	}
}
 