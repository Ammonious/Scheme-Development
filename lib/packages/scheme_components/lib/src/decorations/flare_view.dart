import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class SchemeFlare extends StatelessWidget with FlareController {
  final String asset;
  final String package;
  final double height;
  final double width;
  final String animation;
  final BoxFit fit;
  /// default [false]. If  a flare file has multiple artboards select true. i.e. an icon pack.
  final hasMultipleArtboards;
  /// [primary] key in a [ActorNode] as setup.
  final Color primary;
  /// [primary_2] key in a [ActorNode] as setup.
  final Color primaryVariant;
  /// [accent] key in a [ActorNode] as setup.
  final Color secondary;

  /// [accent_2] key in a [ActorNode] as setup.
  final Color secondaryVariant;
  final bool isPaused;
  SchemeFlare(
      {Key key,
      this.asset,
      this.package,
      this.height,
      this.width,
      this.animation,
      this.primary,
      this.secondary,
      this.primaryVariant,
      this.secondaryVariant, this.hasMultipleArtboards = false, this.fit = BoxFit.contain, this.isPaused = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: height ?? double.minPositive,
        width: width ?? double.minPositive,
        child: FlareActor(
          'packages/scheme_components/$asset',
          animation: animation,
          fit: fit,
          alignment: Alignment.center,
          isPaused: isPaused,
          controller: this,
        ),
      ),
    );
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    // advance is called whenever the flare artboard is about to update (before it draws).
    List fills = List();

    if (artboard.name == asset) {
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
    fills.forEach((fill) {
      if (fill.parent.name == 'primary') {
        if (primary != null )fill.uiColor = primary;
      } else if (fill.parent.name == 'primary_2') {
        if (primaryVariant != null) fill.uiColor = primaryVariant;
      } else if (fill.parent.name == 'accent') {
        if (secondary != null) fill.uiColor = secondary;
      } else if (fill.parent.name == 'accent_2') {
        if (secondaryVariant != null)  fill.uiColor = secondaryVariant;
      }
    });
    return false;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    // TODO: implement initialize



  }

  @override
  void setViewTransform(Mat2D viewTransform) {

  }
}
