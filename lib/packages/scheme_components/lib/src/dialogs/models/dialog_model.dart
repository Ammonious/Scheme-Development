
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_components/src/sheets/models/sheet_menu_item.dart';

import 'package:flutter/material.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

class DialogRequest {
  String title;
  String description;
  String confirmLabel;
  String cancelLabel;
  DialogType dialogType;
  SchemeBtnStyle buttonStyle;
  Widget customDialog;
  bool invalidSession;
  bool isKiosk;
  List<MenuItem> menuItems;
  Function(int) onSelection;

  /// CustomDialog Properties
  TransitionType transitionType;
  double maxWidth;

  double maxHeight;
  EdgeInsets padding;

  /// [InputDialog] Properties

  IconData iconData;
  String inputLabel;
  double height;
  double width;
  double textFieldWidth;
  TextCapitalization textCapitalization;
  TextInputType inputType;
  String initialValue;
  Widget image;
  DialogRequest(
      {this.title = '',
      this.description = '',
      this.confirmLabel = 'OK',
      this.cancelLabel,
      this.dialogType = DialogType.alert,
      this.isKiosk = false,
      this.iconData,
      this.image,
      this.inputLabel,
        this.buttonStyle = SchemeBtnStyle.flat,
      this.initialValue,
      this.onSelection,
      this.menuItems,
      this.invalidSession = false,
      this.height = 400,
      this.width = 500,
      this.textFieldWidth = 500,
      this.inputType = TextInputType.text,
      this.textCapitalization = TextCapitalization.none,
      this.customDialog,
      this.transitionType = TransitionType.slideBottom,
      this.maxWidth = 500,
      this.maxHeight,
      this.padding = const EdgeInsets.all(0)});
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;
  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}



enum DialogType { input, currency_input, alert, confirmation, custom, progress, info, sheet }
