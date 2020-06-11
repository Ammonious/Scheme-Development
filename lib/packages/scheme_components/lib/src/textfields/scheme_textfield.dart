import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../../scheme_components.dart';
import 'controllers/currency_controller.dart';


enum SchemeFieldStyle {card,underline,neu,outline}

class SchemeTextField extends HookWidget {
	final SchemeFieldStyle fieldStyle;
	final SchemeFieldDecoration decoration;
	final String label;
	final FocusNode focusNode;
	final FocusNode nextFocus;
	final IconData iconData;
	final TextEditingController controller;
	final CurrencyTextFieldController currencyController;
	final TextInputType inputType;
	final TextInputAction inputAction;
	final TextCapitalization textCapitalization;
	final List<TextInputFormatter> inputFormatters;
	final TextStyle textStyle;
	final Color themeColor;
	final Color textColor;
	final Color hintColor;
	final Color backgroundColor;
	final double width;
	final double height;

	/// Whether this should animate on [Focus]
	final bool animateOnFocus;

	final int maxLength;
	final Function(String text) onChange;
	final Function(String text) onSubmit;
	final Function onGainedFocus;
	final bool isPassword;
	final bool enabled;


	SchemeTextField({this.decoration,
		this.animateOnFocus,
		this.width,
		this.height = 72,
		Key key,
		this.textStyle,
		this.maxLength,
		this.inputFormatters,
		this.onGainedFocus,
		this.textCapitalization = TextCapitalization.none,
		this.fieldStyle = SchemeFieldStyle.outline,
		this.label = '',
		this.focusNode,
		this.isPassword = false,
		this.enabled = true,
		this.nextFocus,
		this.iconData,
		this.controller,
		this.currencyController,
		this.inputType = TextInputType.emailAddress,
		this.inputAction = TextInputAction.done,
		this.themeColor = Colors.blue,
		this.textColor = nearlyBlack,
		this.hintColor = Colors.grey,
		this.backgroundColor = Colors.white,
		this.onChange,
		this.onSubmit,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {


		return Material(
			color: Colors.transparent,
			child: Padding(
				padding: EdgeInsets.all(kIsWeb ? 4 : 0),
				child: SizedBox(),
			),
		);
	}

}