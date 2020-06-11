import 'package:flutter/material.dart';
import 'package:scheme_components/src/buttons/utils/decoration.dart';
import 'package:scheme_components/src/text_views/auto_size_text.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

import '../../scheme_components.dart';
import 'utils/icon_with_label_view.dart';

class SchemeGradientBtn extends StatelessWidget {
  final Function onTap;
  final String label;
  final double height;
  final double width;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadow;
  final bool superEllipseShape;
  final IconData iconData;
  final LinearGradient gradient;
  final double iconSize;
  final BorderRadius borderRadius;
  final Widget child;
  final Widget icon;
  final bool enabled;
  final IconAlignment iconAlignment;
  SchemeGradientBtn(
      {Key key,
     @required this.onTap,
        @required  this.icon,
        @required  this.label,
        @required  this.height,
        @required  this.width,
        @required  this.textStyle,
        @required  this.boxShadow,
        @required  this.superEllipseShape,
        @required this.iconData,
        @required  this.gradient,
        @required  this.iconSize,
        @required  this.borderRadius,
        @required  this.child,
        @required  this.enabled,
        @required   this.iconAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: normalDuration,
      height: height,
      width: width,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.4),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          onTap: () => onTap != null && enabled ? onTap() : () {},
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Center(child: child == null ? IconLabelView(
              icon: icon,
              iconSize: iconSize,
              iconData: iconData,
              label: label,
              gradient: gradient,
              iconAlignment: iconAlignment,
              textStyle: textStyle,
            ) : child),
          ),
        ),
      ),
    );
  }

  get decoration => superEllipseShape
      ? SchemeButtonDecoration.to.superEllipseDecoration(
          boxShadow: boxShadow, gradient: gradient ?? _gradient, borderRadius: borderRadius)
      : SchemeButtonDecoration.to.regularThemeDecoration(
          boxShadow, gradient ?? _gradient, borderRadius ?? BorderRadius.circular(12));

  get _gradient =>
      schemeGradient(colorOne: Colors.blueAccent.shade700, colorTwo: Colors.blueAccent.shade900);

}
