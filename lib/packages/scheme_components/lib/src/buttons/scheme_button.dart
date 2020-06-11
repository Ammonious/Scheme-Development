import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_components/src/animations/material_animation_builder.dart';
import 'package:scheme_components/src/buttons/gradient_button.dart';
import 'package:scheme_components/src/buttons/utils/icon_with_label_view.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'utils/button_constants.dart';

class SchemeBtn extends StatelessWidget {
  final SchemeBtnStyle schemeBtnStyle;
  final Function onTap; 
  final String label;
  final double height;
  final double width;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadow;
  final bool superEllipseShape;
  final IconData iconData;
  final Widget icon;
  final Color color;
  final LinearGradient gradient;
  final double iconSize;
  final BorderRadius borderRadius;
  final Widget child;
  final bool enabled;
  final IconAlignment iconAlignment; 
  SchemeBtn._internal(
      {Key key,
      this.onTap,
      this.icon, 
      this.label,
      this.height,
      this.width,
      this.textStyle,
      this.boxShadow,
      this.superEllipseShape,
      this.iconData,
      this.color,
      this.gradient,
      this.iconSize,
      this.borderRadius,
      this.child,
      this.enabled,
      this.schemeBtnStyle, this.iconAlignment, })
      : super(key: key);

  factory SchemeBtn.gradient({ 
    Function onPressed,
    String label,
    double height = 60,
    double width = 120,
    TextStyle textStyle,
    IconAlignment iconAlignment = IconAlignment.left,
    List<BoxShadow> boxShadow = normalShadow,
    bool superEllipseShape = false,
    IconData iconData,
    Color color = Colors.blueAccent,
    LinearGradient gradient,
    double iconSize = 24,
    BorderRadius borderRadius = BorderRadius.zero,
    Widget child,
    Widget icon,
    bool enabled = true,
  }) =>
      SchemeBtn._internal(
        onTap: () => onPressed(), 
        label: label,
        height: height,
        width: width,
        textStyle: textStyle,
        boxShadow: boxShadow,
        superEllipseShape: superEllipseShape,
        iconData: iconData,
        iconSize: iconSize,
        color: color,
        gradient: gradient,
        borderRadius: borderRadius,
        enabled: enabled,
        icon: icon,
        iconAlignment: iconAlignment,
        schemeBtnStyle: SchemeBtnStyle.gradient,
        child: child,
      );

  factory SchemeBtn.flat({
    Function tap,
    String label,
    double height,
    double width,
    TextStyle textStyle,
    IconAlignment iconAlignment,
    IconData iconData,
    Color color,
    double iconSize,
    Widget child,
    Widget icon,
    bool enabled,
  }) =>
      SchemeBtn._internal(
        onTap: () => tap(),
        label: label,
        height: height,
        width: width,
        textStyle: textStyle,
        iconData: iconData,
        iconSize: iconSize,
        color: color,
        enabled: enabled,
        icon: icon,
        iconAlignment: iconAlignment,
        schemeBtnStyle: SchemeBtnStyle.flat,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return schemeButton();
     
  }
  schemeButton(){
    switch (schemeBtnStyle) {
      case SchemeBtnStyle.gradient:
        return gradientBtn;
      case SchemeBtnStyle.flat:
        return flatBtn;
      case SchemeBtnStyle.raised:
        return Material(
          color: Colors.transparent,
        );
    }
  }

  get gradientBtn => SchemeGradientBtn(
        onTap: () => onTap(),
        label: label,
        height: height,
        width: width,
        textStyle: textStyle,
        boxShadow: boxShadow,
        superEllipseShape: superEllipseShape,
        iconData: iconData,
        iconSize: iconSize,
        icon: icon,
        gradient: gradient ?? schemeGradient(color: color),
        borderRadius: borderRadius,
        enabled: enabled,
        iconAlignment: iconAlignment,
        child: child,
      );

  get flatBtn => ButtonTheme(
        height: height,minWidth: width,
        child: FlatButton(
            textColor: color ?? (textStyle != null ? textStyle.color : Colors.blueAccent.shade700),
            child: child == null
                ? IconLabelView(
                    icon: icon,
                    iconSize: iconSize,
                    iconData: iconData,
                    label: label,
                    gradient: gradient,
                    iconAlignment: iconAlignment,
                    color: color,
                    textStyle: textStyle,
                  )
                : child,
            onPressed: () => onTap()),
      );

}

enum SchemeBtnStyle { gradient, flat, raised }
