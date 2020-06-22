import 'package:flutter/material.dart';
import '../../common/dialog_utils/dialog_service.dart';
import '../../common/locator/locator.dart';

class BaseModel extends ChangeNotifier {
	final DialogService _dialogService = locator<DialogService>();
	bool _busy = false;
	bool get busy => _busy;

	void setBusy(bool value) {
	if(value) _dialogService.hideProgressDialog();
	else _dialogService.showProgressDialog();
	}
}