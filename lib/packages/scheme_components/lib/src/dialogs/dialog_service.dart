import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:scheme_components/src/builders/card_dialog_builder.dart';
import 'package:scheme_components/src/builders/time_dismiss_builder.dart';
import 'package:scheme_components/src/sheets/bottom_sheet_menu.dart';
import 'package:scheme_components/src/sheets/models/sheet_menu_item.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'dialog_types/alert_dialog.dart';
import 'dialog_types/information_dialog.dart';
import 'dialog_types/progress_snackbar.dart';
import 'models/dialog_model.dart';

/// register as [lazySingleton in [locatorModules]
class DialogService {

  Completer<DialogResponse> _dialogCompleter;

  dialogWrapper(Widget child, bool enableTimer) => TimeDismissBuilder.periodic(
        Duration(seconds: 60),
        enabled: enableTimer,
        child: child,
        onFire: () => Get.back(),
      );

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future _getDialog(DialogRequest request) {
    bool confirmed = false;
    switch (request.dialogType) {
      case DialogType.input:
      case DialogType.currency_input:
      case DialogType.confirmation:
      case DialogType.alert:
        return Get.dialog(dialogWrapper(CustomAlertDialog(request: request), request.isKiosk));
      case DialogType.custom:
        return Get.dialog(dialogWrapper(
            CardDialogBuilder(
              child: request.customDialog,
              maxWidth: request.maxWidth,
              maxHeight: request.maxHeight,
              padding: request.padding,
            ),
            request.isKiosk));
      case DialogType.progress:
        return null;
      case DialogType.info:
        return Get.dialog(dialogWrapper(
            InformationDialog(
              image: request.image,
              title: request.title,
              body: request.description,
              buttonLabel: request.confirmLabel,
              isKiosk: request.isKiosk,
            ),
            request.isKiosk));
      case DialogType.sheet:
        return Get.bottomSheet(
            dialogWrapper(
                BottomSheetMenu(
                  title: request.title,
                  menuItems: request.menuItems,
                  dialogType: request.dialogType,
                  onSelection: (index) => _bottomSheetSelection(request, index, confirmed),
                ),
                request.isKiosk),
            backgroundColor: Colors.transparent,
            elevation: 0,
            isScrollControlled: true,
            enableDrag: true,
            isDismissible: true,
            shape: RoundedRectangleBorder(borderRadius: topCardRadius));
      default:
        return Get.dialog(CustomAlertDialog(request: request));
    }
  }

  Future<DialogResponse> showDialog(
      {String title,
      String body,
      String buttonLabel = 'OK',
      DialogType dialogType,
      bool invalidSession = false, }) {
    _dialogCompleter = Completer<DialogResponse>();
    _getDialog(DialogRequest(
        title: title,
        description: body,
        confirmLabel: buttonLabel,
        invalidSession: invalidSession,
        dialogType: DialogType.alert));
    return _dialogCompleter.future;
  }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog(
      {String title,
      String body,
      String confirmationLabel = 'OK',
      String cancelLabel = 'Cancel',
       }) {
    _dialogCompleter = Completer<DialogResponse>();
    _getDialog(DialogRequest(
        title: title,
        description: body,
        confirmLabel: confirmationLabel,
        dialogType: DialogType.confirmation,
        cancelLabel: cancelLabel, ));
    return _dialogCompleter.future;
  }

  Future<DialogResponse> showInputDialog(
      {String title,
      String fieldLabel,
      IconData icon,
      String confirmationLabel = 'OK',
      String cancelLabel = 'Cancel', }) {
    _dialogCompleter = Completer<DialogResponse>();
    _getDialog(DialogRequest(
        title: title,
        confirmLabel: confirmationLabel,
        dialogType: DialogType.input,
        iconData: icon,
        cancelLabel: cancelLabel, ));
    return _dialogCompleter.future;
  }

  Future<DialogResponse> showInformationDialog(
      {String title,
      String body,
      String imagePath,
      String confirmationLabel = 'OK',
      String cancelLabel = 'Cancel',
       }) {
    _dialogCompleter = Completer<DialogResponse>();
    _getDialog(DialogRequest(
        title: title,
        description: body,
        confirmLabel: confirmationLabel,
        dialogType: DialogType.confirmation,
        cancelLabel: cancelLabel, ));
    return _dialogCompleter.future;
  }

  Future<DialogResponse> showCustomDialog({Widget child}) {
    _dialogCompleter = Completer<DialogResponse>();
    _getDialog(DialogRequest(dialogType: DialogType.custom, customDialog: child));
    return _dialogCompleter.future;
  }

  Future showBottomSheet(
      {String title, List<MenuItem> menuItems, Function(int selectedIndex) onSelection}) {
    _dialogCompleter = Completer<DialogResponse>();
    _getDialog(DialogRequest(
        dialogType: DialogType.sheet,
        title: title,
        menuItems: menuItems,
        onSelection: (index) => onSelection(index)));
    return _dialogCompleter.future;
  }

  hideProgressDialog() => snackbar.dismissProgress();

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogRequest request, DialogResponse response) async {
    StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
    Get.back();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }

  _bottomSheetSelection(DialogRequest request, int index, bool confirmed) {
    confirmed = true;
    dialogComplete(request, DialogResponse(confirmed: true));
    if (request.onSelection != null) request.onSelection(index);
  }

  ProgressSnackbar _snackbar;
  ProgressSnackbar get snackbar => _snackbar;

  showProgressDialog() {
    _snackbar = Get.put(ProgressSnackbar());
    _snackbar.showProgress();
  }






}
