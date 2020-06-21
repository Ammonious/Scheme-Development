import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../../scheme_components.dart';
import 'controllers/currency_controller.dart';
import 'package:scheme_icons/scheme_icons.dart';

enum SchemeFieldType {card,underline,neu,outline}

class SchemeTextField extends HookWidget {
	 SchemeFieldType fieldStyle;
	 String label;
	 FocusNode focusNode;
	 FocusNode nextFocus;
	 IconData iconData;
	 TextEditingController controller;
	 CurrencyTextFieldController currencyController;
	 TextInputType inputType;
	 TextInputAction inputAction;
	 TextCapitalization textCapitalization;
	 List<TextInputFormatter> inputFormatters;
	 TextStyle textStyle;
	 Color themeColor;
	 Color textColor;
	 Color hintColor;
	 Color backgroundColor;
	 double width;
	 double height;
	/// Whether this should animate on [Focus]
	 bool animateOnFocus;

	 int maxLength;
	 Function(String text) onChange;
	 Function(String text) onSubmit;
	 Function onGainedFocus;
	 bool isPassword;
	 bool enabled;
 
	SchemeTextField({ 
		this.animateOnFocus,
		this.width,
		this.height = 72,
		Key key,
		this.textStyle,
		this.maxLength,
		this.inputFormatters,
		this.onGainedFocus,
		this.textCapitalization = TextCapitalization.none,
		this.fieldStyle = SchemeFieldType.outline,
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