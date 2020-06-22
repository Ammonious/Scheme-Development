import 'package:flutter/material.dart';

class NavItemMobile extends StatelessWidget {
	final Widget child;
	final String label;
	final Function(Widget child) onTap;
	NavItemMobile({Key key, this.child, this.label, this.onTap}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Material(color: Colors.transparent,);
	}
}
