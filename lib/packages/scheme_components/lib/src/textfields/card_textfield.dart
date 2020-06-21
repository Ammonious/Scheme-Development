import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/textfields/controllers/focus_controller.dart';
import 'package:scheme_utilities/scheme_utilities.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_shared/scheme_shared.dart';
import 'controllers/currency_controller.dart';
class CardTextField extends HookWidget {
  final FocusNode textFocus;
  final FocusNode nextFocus;
  final TextEditingController controller;
  final CurrencyTextFieldController currencyController;
  final Color brandColor;
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
    Key key,
    this.label,
    @required this.textFocus,
    this.brandColor = Colors.deepPurpleAccent,
    this.nextFocus,
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
    this.currencyController,
  }) : super(key: key);



  final FocusNotifier focusNotifier = FocusNotifier();

  @override
  Widget build(BuildContext context) {

    final textController = currencyController ?? controller;

    final mainStream = useStream<bool>(focusNotifier.mainStream(textFocus));
    final nextStream = useStream<bool>(focusNotifier.nextStream(nextFocus));

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
              primaryColor: brandColor,
            ),
            child: TextField(
              enabled: enabled,
              focusNode: textFocus,
              maxLength: maxLength,
              autofocus: autoFocus,
              keyboardType: inputType,
              textInputAction: inputAction,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
              onChanged: (text) => onChange != null ? onChange(text) : null,
              onSubmitted: (text) {
                if (nextFocus != null && !disableKeyboard) SchemeUtils.font.fieldFocusChange(textFocus, nextFocus);
                else SchemeUtils.font.dismissKeyboard();

                if (onSubmit != null) onSubmit(text);
              },
              style: textStyle == null
                  ? Get.theme.textTheme.subtitle1.copyWith(color: textColor)
                  : textStyle.copyWith(color: backgroundColor.textColor),
              maxLines: 1,
              cursorColor: brandColor,
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
      icon: Icon(
        iconData,
        color: textFocus.hasFocus ? brandColor : defaultColor,
      ),
      labelStyle: style.copyWith(
          color: textFocus.hasFocus ? brandColor : defaultColor ?? backgroundColor.textColor),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: label ?? '',
    );
  }

  inputNoIcon(style,defaultColor) {

    return InputDecoration(
      labelStyle: style.copyWith(
          color: textFocus.hasFocus ? brandColor : defaultColor ?? backgroundColor.textColor),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: label ?? '',
    );
  }
}