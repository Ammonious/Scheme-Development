import 'package:flutter/material.dart';

import 'bubbled_background.dart';
import 'flare_view.dart';
import 'lottie_view.dart';

class DecorationBuilder extends StatelessWidget {
  final BubbleBackground bubbleBackground;
  final SchemeLottie lottie;
  final SchemeFlare schemeFlare;
  final Widget child;
  final Color backgroundColor;
  DecorationBuilder({Key key, this.bubbleBackground,this.backgroundColor, this.child, this.lottie,this.schemeFlare}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: Stack(fit: StackFit.passthrough,
        children: [
          if (bubbleBackground != null)
            Positioned(top: 0, left: 0, right: 0, bottom: 0, child: bubbleBackground),
          if(lottie != null) Align(alignment: lottie.alignment,child: lottie),
          if(schemeFlare != null) Positioned(top: 0, left: 0, right: 0, bottom: 0,child: schemeFlare),
          if (child != null) Positioned.fill(child: Builder(builder: (context) => child,)),
        ],
      ),
    );
  }
}
