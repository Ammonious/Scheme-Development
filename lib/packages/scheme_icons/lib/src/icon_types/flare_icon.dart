import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import '../icon_maps/flare_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class FlareIconMap extends StatefulWidget {
  final String flareIcon;
  final double iconSize;
  final String flrPath;
  final String animation;
  final FlareIconController controller;

  FlareIconMap({
    this.flrPath,
    this.animation = 'idle',
    this.flareIcon,
    this.iconSize,
                 this.controller,
  });

  @override
  _FlareIconMapState createState() => _FlareIconMapState();
}

class _FlareIconMapState extends State<FlareIconMap>  {

  FlareIconController get controller => widget.controller ?? FlareIconController(flareIcon:widget.flareIcon);
  FlutterActorShape primaryShape;
  FlutterActorShape primaryTwoShape;
  FlutterActorShape accentShape;
  FlutterActorShape accentTwoShape;
  List<FlutterColorFill> fills = List();
  String get flareIcon => widget.flareIcon;

  double get iconSize => widget.iconSize;


  @override
  Widget build(BuildContext context) {
    controller.isActive.value = true;
     return SizedBox(
       height: iconSize,
       width: iconSize,
       child: FlareActor(
         'packages/scheme_icons/assets/rive_icons/unicon_icons.flr',
         fit: BoxFit.contain,
         alignment: Alignment.center,
         callback: (animation) {
           setColorFills();
         },
         controller: controller,
         animation: widget.animation,
         isPaused: widget.animation == 'idle',
         artboard: flareIcon,
       ),
     );
  }



  setColorFills() {

    Color primary = Picaso.paint.primary;
    Color primaryTwo = Picaso.paint.primaryVariant;
    Color accent = Picaso.paint.secondary;
    Color accentTwo = Picaso.paint.secondaryVariant;

    fills.forEach((fill) {
      if (fill.parent.name == 'primary') {
        if (primary.opacity < 1.0) fill.opacity = primary.opacity;
        fill.uiColor = primary;
      } else if (fill.parent.name == 'primary_2') {
        if (primaryTwo.opacity < 1.0) fill.opacity = primaryTwo.opacity;
        fill.uiColor = primaryTwo;
      } else if (fill.parent.name == 'accent') {
        if (accent.opacity < 1.0) fill.opacity = accent.opacity;
        fill.uiColor = accent;
      } else if (fill.parent.name == 'accent_2') {
        if (accentTwo.opacity < 1.0) fill.opacity = accentTwo.opacity;
        fill.uiColor = accentTwo;
      }
    });
  }


}

class FlareIconController extends FlareControls { 
  final String flareIcon;
  final ColorScheme defaultScheme;
  ColorScheme colorScheme;
  FlareIconController({this.flareIcon,this.defaultScheme});
  List<FlutterColorFill> fills = List();

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
     
    if (artboard != null && artboard.name == flareIcon) {
      artboard.nodes.forEach((actor) {
        if (actor != null && actor.children != null) {
          for (var node in actor.children) {
            if (node is FlutterActorShape) {
              FlutterColorFill fill = node?.fill as FlutterColorFill;
              fills.add(fill);
            }
          }
        }
      });
    }
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    setSelectedFills();
    return false;
  }


  @override
  void setViewTransform(Mat2D viewTransform) {}

  setSelectedFills() {

    Color primary = Picaso.paint.primary;
    Color primaryTwo = Picaso.paint.primaryVariant;
    Color accent = Picaso.paint.secondary;
    Color accentTwo = Picaso.paint.secondaryVariant;

    fills.forEach((fill) {
      if (fill.parent.name == 'primary') {
        if (primary.opacity < 1.0) fill.opacity = primary.opacity;
        fill.uiColor = primary;
      } else if (fill.parent.name == 'primary_2') {
        if (primaryTwo.opacity < 1.0) fill.opacity = primaryTwo.opacity;
        fill.uiColor = primaryTwo;
      } else if (fill.parent.name == 'accent') {
        if (accent.opacity < 1.0) fill.opacity = accent.opacity;
        fill.uiColor = accent;
      } else if (fill.parent.name == 'accent_2') {
        if (accentTwo.opacity < 1.0) fill.opacity = accentTwo.opacity;
        fill.uiColor = accentTwo;
      }
    });
  }


}
