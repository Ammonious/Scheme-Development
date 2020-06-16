import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/scheme_theme.dart';

class CardDialogBuilder extends StatelessWidget {
	final Widget child;
	final EdgeInsets padding;
	final double maxWidth;
	final double maxHeight;
	CardDialogBuilder({Key key, this.child, this.padding = const EdgeInsets.all(0), this.maxWidth,this.maxHeight }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Dialog(shape: RoundedRectangleBorder(borderRadius: cardRadius),elevation: 16,
			child: Material(color:Colors.transparent,child: Container(
				padding: padding,
				constraints: BoxConstraints(maxWidth: maxWidth ?? Get.width,maxHeight: maxHeight ?? Get.height),

				child: child,
			),),
		);
	}
}