import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scheme_components/src/decorations/services/lottie_controller.dart';

enum LottieType { file, network, asset }

class SchemeLottie extends HookWidget {
  final LottieType lottieType;
  final String src;
  final bool animate;
  final bool reverse;
  final bool repeat;
  final double height;
  final double width;
  final BoxFit fit;
  final String package;
  final AlignmentGeometry alignment;

  SchemeLottie._internal(
      {Key key,
      this.lottieType,
      this.src,
      this.animate,
      this.reverse,
      this.repeat,
      this.height,
      this.width,
      this.fit,
      this.alignment,
      this.package})
      : super(key: key);

  factory SchemeLottie.network({String src}) => SchemeLottie._internal(
        lottieType: LottieType.network,
        src: src,
      );

  factory SchemeLottie.file({String src}) => SchemeLottie._internal(
        lottieType: LottieType.file,
        src: src,
      );

  factory SchemeLottie.asset({
    @required String src,
    double width = 100,
    double height = 100,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool animate = false,
    bool reverse = false,
    bool repeat = false,
    String package,
  }) =>
      SchemeLottie._internal(
        lottieType: LottieType.asset,
        src: src,
        width: width,
        height: height,
        fit: fit,
        animate: animate,
        reverse: reverse,
        repeat: repeat,
        alignment: alignment,
        package: package,
      );
  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();
    final controller = useAnimationController(vsync: ticker);
    return Builder(
      builder: (context) => GetBuilder(
          init: LottieController(),
          initState: (_) => LottieController.to.controller = controller,
          builder: (s) => schemeLottie()),
    );
  }

  schemeLottie() {
    switch (lottieType) {
      case LottieType.file:
        return lottieFile;
      case LottieType.network:
        return lottieNetwork;
      case LottieType.asset:
        return lottieAsset;
    }
  }

  get lottieAsset => LottieBuilder.asset(
        src,
        controller: LottieController.to.controller,
        height: height,
        width: width,
        alignment: alignment,
        animate: animate,
        repeat: repeat,
        reverse: reverse,
        fit: fit,
        package: package ?? 'scheme_components',
      );
  get lottieNetwork => LottieBuilder.network(
        src,
        controller: LottieController.to.controller,
        height: height,
        width: width,
        alignment: alignment,
        animate: animate,
        repeat: repeat,
        reverse: reverse,
        fit: fit,
      );

  get lottieFile => LottieBuilder.file(
        File(src),
        controller: LottieController.to.controller,
        height: height,
        width: width,
        alignment: alignment,
        animate: animate,
        repeat: repeat,
        reverse: reverse,
        fit: fit,
      );
}
