import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useScrollController() => Hook.use(_ScrollControllerHook());

class _ScrollControllerHook extends Hook<ScrollController> {
  const _ScrollControllerHook();

  @override
  ScrollControllerHookState createState() => ScrollControllerHookState();
}

class ScrollControllerHookState extends HookState<ScrollController, _ScrollControllerHook> {
  ScrollController _controller;

  @override
  void initHook() {
    _controller = ScrollController();
  }

  // Build doesn't return a Widget but rather the ScrollController
  @override
  ScrollController build(BuildContext context) => _controller;

  // This is what we came here for
  @override
  void dispose() => _controller.dispose();


}