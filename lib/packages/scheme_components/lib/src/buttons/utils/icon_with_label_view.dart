import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_components/src/text_views/auto_size_text.dart';

import 'package:scheme_utilities/scheme_utilities.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'button_constants.dart';

class IconLabelView extends StatelessWidget {
  final IconAlignment iconAlignment;
  final Widget icon;
  final String label;
  final IconData iconData;
  final double iconSize;
  final LinearGradient gradient;
  final TextStyle textStyle;
  final Color color;
  IconLabelView(
      {Key key,
      this.icon,
      this.label,
      this.iconData,
      this.iconSize,
      this.gradient,
      this.textStyle,
      this.color,
      this.iconAlignment = IconAlignment.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  	final textColor = gradient != null ? gradient.colors.last.textColor : color.shade900.textColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        if (iconAlignment == IconAlignment.left) compView,
        AutoSizeText(
          label,
          maxLines: 1,
          style: style(textColor),
        ),
        if (iconAlignment == IconAlignment.right) compView,
      ],
    );
  }


    style(textColor) => textStyle == null ? GoogleFonts.rubik(fontSize: 15,fontWeight: FontWeight.w700, color: textColor) : textStyle;
  get compView => icon != null ? iconView : iconData != null ? iconDateView : SizedBox.shrink();

  get iconView => Visibility(
        visible: icon != null,
        child: Container(margin: margin, child: icon),
      );

  get alignRight => iconAlignment == IconAlignment.right;

  get margin => EdgeInsets.only(right: alignRight ? 0 : 10, left: alignRight ? 10 : 0);

  get iconDateView => Visibility(
        visible: iconData != null,
        child: Container(
          margin: margin,
          child: Icon(
            iconData,
            size: iconSize,
            color: gradient != null ? gradient.colors[1].textColor : color.shade900.textColor,
          ),
        ),
      );
}
