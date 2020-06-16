
import 'package:flutter/material.dart';
import 'package:scheme_components/locator/locator.dart';
import 'package:scheme_components/scheme_components.dart';
import 'package:scheme_components/src/dialogs/models/dialog_model.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../dialog_service.dart';

class CustomAlertDialog extends StatelessWidget {
	final DialogRequest request;
	final DialogService _dialogService = locator();
CustomAlertDialog({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
	  var isConfirmationDialog = request.dialogType == DialogType.confirmation;
    return Material(color:Colors.transparent,child: AlertDialog(
	    backgroundColor: Picaso.paint.card,
	    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
	    title: Text(
		    request.title,
		    style: Picaso.jot.headline6,
	    ),
	    content: Text(
		    request.description,
		    style: Picaso.jot.bodyText1,
	    ),
	    actions: <Widget>[
		    if (isConfirmationDialog)
			    SchemeBtn.style(
				    height: 36,
				    schemeBtnStyle: request.buttonStyle,
				    label: request.cancelLabel,
				    color: Colors.grey,
				    textStyle: Picaso.jot.button,
				    onTap: () => _dialogService.dialogComplete(request,DialogResponse(confirmed: false)),
			    ),
		    SchemeBtn.style(
			    height: 36,
			    schemeBtnStyle: request.buttonStyle,
			    color: Picaso.paint.primary,
			    textStyle: Picaso.jot.button,
			    label: request.confirmLabel,
			    onTap: () => _dialogService.dialogComplete(request,DialogResponse(confirmed: true)),
		    ),
	    ],
    ),);
  }
}
