import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/text_field/controllers/focus_controller.dart';
import 'package:scheme_utilities/scheme_utilities.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'controllers/currency_controller.dart';
import 'controllers/scheme_textfield_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CardTextField extends HookWidget {
  SchemeFieldController controller;
  final Color color;
  final IconData iconData;
  final String label;
  final bool isPassword;
  final bool enabled;
  final bool showIcon;
  final bool disableKeyboard;
  final bool autoFocus;
  final TextInputType inputType;
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Widget icon;
  final int maxLength;
  final Function onGainedFocus;
  final TextInputAction inputAction;
  final Function(String text) onSubmit;
  final Function(String text) onChange;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final List<BoxShadow> boxShadow;
  final double height;
  CardTextField({
    this.icon,
    this.label,
    this.color = Colors.deepPurpleAccent,
    this.controller,
    this.boxShadow,
    this.iconData,
    this.isPassword = false,
    this.enabled = true,
    this.disableKeyboard = false,
    this.autoFocus = false,
    this.inputType = TextInputType.visiblePassword,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.textStyle,
    this.maxLength,
    this.onSubmit,
    this.onChange,
    this.onGainedFocus,
    this.inputAction = TextInputAction.done,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.height = 72,
    this.showIcon = false,
  });



  final FocusNotifier focusNotifier = FocusNotifier();

  @override
  Widget build(BuildContext context) {

    final textController = controller.currencyController ?? controller.textController;


    Color defaultColor = textStyle != null ? textStyle.color : backgroundColor.textColor;
    TextStyle style = textStyle ?? Get.theme.textTheme.subtitle1 ?? TextStyle(fontSize:16);

    return Material(color: Colors.transparent,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: boxShadow ??
                normalShadow,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Theme(
            data: Get.theme.copyWith(
              primaryColor: color,
            ),
            child: TextField(
              enabled: enabled,
              focusNode: controller.currentFocus,
              maxLength: maxLength,
              autofocus: autoFocus,
              keyboardType: inputType,
              textInputAction: inputAction,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
              onChanged: (text) => onChange != null ? onChange(text) : null,
              onSubmitted: (text) {
               bool dismiss = Get.focusScope.nextFocus();
                if(dismiss) SchemeUtils.font.dismissKeyboard();
                else controller.currentFocus = Get.focusScope.nearestScope.parent;
                if (onSubmit != null) onSubmit(text);
              },
              style: textStyle == null
                  ? Get.theme.textTheme.subtitle1.copyWith(color: textColor)
                  : textStyle.copyWith(color: backgroundColor.textColor),
              maxLines: 1,
              cursorColor: color,
              controller: textController,
              decoration: showIcon ? inputWithIcon(style,defaultColor) : inputNoIcon(style,defaultColor),
              obscureText: isPassword,
            ),
          ),
        ),
      ),
    );
  }

  inputWithIcon(style,defaultColor) {
    return InputDecoration(
      icon: icon ?? Icon(
        iconData,
        color: Get.focusScope.parent.hasFocus ? color : defaultColor,
      ),
      labelStyle: style.copyWith(
          color: Get.focusScope.parent.hasFocus ? color : defaultColor ?? backgroundColor.textColor),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: label ?? '',
    );
  }

  inputNoIcon(style,defaultColor) {

    return InputDecoration(
      labelStyle: style.copyWith(
          color: Get.focusScope.parent.hasFocus ? color : defaultColor ?? backgroundColor.textColor),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: label ?? '',
    );
  }
}