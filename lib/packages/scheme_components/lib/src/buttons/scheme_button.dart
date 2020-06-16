import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_components/src/animations/material_animation_builder.dart';
import 'package:scheme_components/src/buttons/gradient_button.dart';
import 'package:scheme_components/src/buttons/utils/icon_with_label_view.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'utils/button_constants.dart';

class SchemeBtn extends StatelessWidget {
  SchemeBtnStyle schemeBtnStyle;
  Function onTap;
  String label;
  double height;
  double width;
  TextStyle textStyle;
  List<BoxShadow> boxShadow;
  bool superEllipseShape;
  IconData iconData;
  Widget icon;
  Color color;
  LinearGradient gradient;
  double iconSize;
  BorderRadius borderRadius;
  Widget child;
  bool enabled;
  IconAlignment iconAlignment;

  SchemeBtn.style({
    this.onTap,
    this.icon,
    this.label,
    this.height = 60,
    this.width = 120,
    this.textStyle,
    this.boxShadow = normalShadow,
    this.superEllipseShape,
    this.iconData,
    this.color = Colors.blueAccent,
    this.gradient,
    this.iconSize,
    this.borderRadius = BorderRadius.zero,
    this.child,
    this.enabled = true,
    this.schemeBtnStyle = SchemeBtnStyle.flat,
    this.iconAlignment = IconAlignment.left,
  });

  SchemeBtn.gradient({
    this.onTap,
    this.label,
    this.height = 60,
    this.width = 120,
    this.textStyle,
    this.iconAlignment = IconAlignment.left,
    this.boxShadow = normalShadow,
    this.superEllipseShape = false,
    this.iconData,
    this.color = Colors.blueAccent,
    this.gradient,
    this.iconSize = 24,
    this.borderRadius = BorderRadius.zero,
    this.child,
    this.icon,
    this.enabled = true,
  }) : schemeBtnStyle = SchemeBtnStyle.gradient;



  SchemeBtn.flat({
    this.onTap,
    this.label,
    this.height = 60,
    this.width = 120,
    this.textStyle,
    this.iconAlignment = IconAlignment.left,
    this.iconData,
    this.color = Colors.blueAccent,
    this.iconSize,
    this.child,
    this.icon,
    this.enabled = true,
  }) : schemeBtnStyle = SchemeBtnStyle.flat;




  @override
  Widget build(BuildContext context) {
    return schemeButton();
  }

  schemeButton() {
    switch (schemeBtnStyle) {
      case SchemeBtnStyle.gradient:
        return SchemeGradientBtn(
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
      case SchemeBtnStyle.flat:
        return ButtonTheme(
          height: height,
          minWidth: width,
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
      case SchemeBtnStyle.raised:
        return Material(
          color: Colors.transparent,
        );
    }
  }


}

enum SchemeBtnStyle { gradient, flat, raised }
