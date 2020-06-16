
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_components/src/dialogs/models/dialog_model.dart';
import 'package:scheme_components/src/text_views/auto_size_text.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart' hide SchemeTextField;

class InformationDialog extends StatelessWidget {
  final String title;
  final String body;
  final String buttonLabel;
  final bool isKiosk;
  final Function onDismiss;
  final Widget image;
  DialogRequest request;
  InformationDialog(
      {Key key,
      this.title = '',
      this.body = '',
      this.isKiosk = false,
      this.buttonLabel = 'OK',
      this.onDismiss, this.image,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: cardRadius,
      child: Container(width: screenWidth - 0,
        constraints:
            BoxConstraints(maxWidth:screenWidth, minWidth: 300,maxHeight: 500,minHeight: 300),
        decoration:
            BoxDecoration(color: Picaso.paint.card, borderRadius: cardRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24),
            SizedBox(height: 70,width: 70,child: image ?? Container(),),
            Padding(
              padding: const EdgeInsets.only(left:8,right: 8),
              child: Column(
                children: [
                  SizedBox(height: 24,),
                  Text(
                    title,textAlign: TextAlign.center,
                    style: Picaso.jot.headline5,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AutoSizeText(
                    body,textAlign: TextAlign.center,
                    style: Picaso.jot.bodyText1,
                  )
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(padding: EdgeInsets.only(right: 12,bottom: 12),
              child: Row(mainAxisSize: MainAxisSize.max, children: [Expanded(child: SizedBox(),),
                SchemeBtn.style(
                  schemeBtnStyle: request.buttonStyle,
                  color: Picaso.paint.primary,
                  height: 38,
                  width: 80,
                  textStyle: Picaso.jot.button,
                  label: buttonLabel,
                  onTap: () => onTap(),
                )
              ],),
            )
          ],
        ),
      ),
    );
  }

  onTap() {
    Get.back();
    if (onDismiss != null) onDismiss();
  }
}
