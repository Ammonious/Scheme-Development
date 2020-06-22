import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_theme/src/theme_changer/controllers/animated_theme_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'clippers/theme_switcher_clipper_bridge.dart';
import 'clippers/theme_switcher_circle_clipper.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AnimatedThemeBuilder extends HookWidget {
  AnimatedThemeBuilder({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  //one more key to save drawer state
  final _globalKey = Get.key;
  final ThemeAnimController get = Get.put(ThemeAnimController());



  @override
  Widget build(BuildContext context) {
    get.controller = useAnimationController(duration: Duration(seconds: 1));

    var theme = Get.theme;
    var children = <Widget>[];
    if (get.oldTheme == null || get.oldTheme == theme) {
      children.add(_getPage(theme));
    } else {
      children.addAll([
        RawImage(image: ThemeProvider.instanceOf(context).image),
        AnimatedBuilder(
          animation: get.controller,
          child: _getPage(theme),
          builder: (_, child) {
            return ClipPath(
              clipper: ThemeSwitcherClipperBridge(
                clipper: ThemeProvider.instanceOf(context).clipper ??
                    const ThemeSwitcherCircleClipper(),
                offset: get.switcherOffset,
                sizeRate: get.controller.value,
              ),
              child: child,
            );
          },
        )
      ]);
    }
    return GetBuilder<ThemeAnimController>(
      didUpdateWidget: (c,state) {
        var theme = Get.theme;
        if(!get.busy && theme != get.oldTheme) {
        get.busy = true;
        get.getSwitcherCoordinates(
              ThemeProvider.instanceOf(context).switcherGlobalKey);
        get.controller.reset();
        get.controller.forward().then(
                (_) {
        get.busy = false;
              get.oldTheme = theme;
            },
          );
        }
    },builder: (c) => Material(
      child: Stack(
        children: children,
      ),
    ),);
  }

  Widget _getPage(ThemeData brandTheme) {
    return Theme(
      key: _globalKey,
      data: brandTheme,
      child: child,
    );
  }


}
