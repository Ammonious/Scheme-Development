import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_components/src/animations/teddy_flare/controllers/form_controller.dart';
import 'package:scheme_components/src/textfields/tracking_text_input.dart';

class TeddyFormBuilder extends StatelessWidget {
  final Widget Function(String username, String password) loginButton;
  TeddyFormBuilder({
    Key key,
    this.loginButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormController>(
      init: FormController(),
      builder: (s) => Material(
        color: Colors.transparent,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: FlareActor(
                    FlareRes.teddy,
                    shouldClip: false,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                    controller: s.teddyController,
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TrackingTextInput(
                            label: "Email",
                            hint: "What's your email address?",
                            onTextChanged: s.onUserFieldChanged,
                            onCaretMoved: (Offset caret) {
                              s.teddyController.lookAt(caret);
                            }),
                        TrackingTextInput(
                          label: "Password",
                          hint: "Try 'bears'...",
                          isObscured: true,
                          onCaretMoved: (Offset caret) {
                            s.teddyController.coverEyes(caret != null);
                            s.teddyController.lookAt(null);
                          },
                          onTextChanged: s.onPasswordChanged,
                        ),
                        loginButton(s.username, s.password)
                      ],
                    )),
                  )),
            ]),
      ),
    );
  }
}
