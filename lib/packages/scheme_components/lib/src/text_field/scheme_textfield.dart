import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_components/src/hooks/currency_controller_hook.dart';
import 'package:scheme_components/src/text_field/card_textfield.dart';
import 'package:scheme_components/src/text_field/controllers/scheme_textfield_controller.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'package:get/get.dart';
import 'controllers/currency_controller.dart';
import 'package:scheme_icons/scheme_icons.dart';

enum SchemeInputStyle { card, underline, neu, outline }
enum SchemeInputFormatter {text,currency}

class SchemeInput extends HookWidget {
  SchemeInputStyle fieldStyle;
  SchemeInputFormatter fieldFormatter;
  String label;
  FocusNode focusNode;
  FocusNode nextFocus;
  IconData iconData;
  Widget icon;
  TextInputType inputType;
  TextInputAction inputAction;
  TextCapitalization textCapitalization;
  List<TextInputFormatter> inputFormatters;
  TextStyle textStyle;
  Color color;
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
  SchemeFieldController controller;

  SchemeInput({
		this.controller,
		this.fieldFormatter = SchemeInputFormatter.text,
    this.animateOnFocus = true,
		this.icon,
    this.width,
    this.height = 72,
    this.textStyle,
    this.maxLength,
    this.inputFormatters,
    this.onGainedFocus,
    this.textCapitalization = TextCapitalization.none,
    this.fieldStyle = SchemeInputStyle.outline,
    this.label = '',
    this.isPassword = false,
    this.enabled = true,
    this.iconData,
    this.inputType = TextInputType.emailAddress,
    this.inputAction = TextInputAction.done,
    this.color = Colors.blue,
    this.textColor = nearlyBlack,
    this.hintColor = Colors.grey,
    this.backgroundColor = Colors.white,
  });


  @override
  Widget build(BuildContext context) {

    controller.currentFocus = useFocusNode();
    controller.currencyController = useCurrencyTextFieldController();
    controller.textController = useTextEditingController();


    switch (fieldStyle) {
      case SchemeInputStyle.card:
        return CardTextField(
					label: label,
					color: color,
					);
      case SchemeInputStyle.underline:
        // TODO: Handle this case.
        break;
      case SchemeInputStyle.neu:
        // TODO: Handle this case.
        break;
      case SchemeInputStyle.outline:
        // TODO: Handle this case.
        break;
    }
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SchemeFieldController>('controller', controller));
  }
}
