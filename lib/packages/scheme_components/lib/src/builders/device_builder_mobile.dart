import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/builders/scheme_builder_controller.dart';
import 'package:scheme_theme/scheme_theme.dart';

class SchemeBuilderMobile extends StatelessWidget {
  final Widget toolbar;
  final Widget bottomBar;
  final Widget Function(SchemeBuilderController controller) builder;
  final bool enableScrollAnimation;
  final bool isNavigation;
  SchemeBuilderMobile(
      {Key key, this.toolbar, this.builder, this.bottomBar, this.enableScrollAnimation = false, this.isNavigation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GetBuilder<SchemeBuilderController>(
        init: SchemeBuilderController(),
        initState: (_) =>
            SchemeBuilderController.to.initController(enableScrollAnimation: enableScrollAnimation),
        builder: (model) => Stack(
          children: [
            if (toolbar != null)
              Align(
                alignment: Alignment.topCenter,
                child: toolbar,
              ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(
                    top: !isNavigation ? appbarWithPadding : 0, bottom: bottomBar != null && !isNavigation ? bottomBarWithPadding : 0),
                child: isNavigation ? builder(model) : SingleChildScrollView(
                  controller: model.scrollController ?? ScrollController(),
                  child: builder(model),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
