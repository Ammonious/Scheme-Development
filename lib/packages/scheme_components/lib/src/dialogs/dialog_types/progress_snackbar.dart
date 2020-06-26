
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

class ProgressSnackbar extends GetxController {
	static ProgressSnackbar get to => Get.find();
  SnackPosition position;
  String title;
  String message;
	GetBar _progress;
	GetBar get progress => _progress;
	ProgressSnackbar();

	@override
	void onInit() {
		super.onInit();
		_progress = _initProgress();
	}


  dismissProgress() => progress.dismiss();

  ProgressSnackbar.customizedSnackbar({SnackPosition position, String title, String message}){
  	Get.put(this);
  	this.position = position;
  	this.title = title;
  	this.message = message;
	  _progress = _initProgress();

	}


  showProgress() =>  progress.show();


  _initProgress() =>
	   GetBar(titleText: Text(
		  title ?? 'Please wait..',
		  style: Picaso.jot.headline6,
	  ),
		  messageText: Text(
			  message ?? 'Loading information.',
			  style: Picaso.jot.subtitle1,
		  ),
		  overlayBlur: 0.1,
		  maxWidth: 400,
		  backgroundColor: Get.isDarkMode ? Color(0xff121212).lightenBy(10) : Get.theme.cardColor,
		  overlayColor: Colors.black.withOpacity(0.15),
		  isDismissible: false,
		  margin: EdgeInsets.all(8),
		  borderRadius: 8.0,
		  animationDuration: normalDuration,
		  boxShadows: [BoxShadow(blurRadius: 2.50, color: Colors.black38, offset: Offset.zero)],
		  snackPosition: position ?? SnackPosition.TOP,
		  showProgressIndicator: true,
		  progressIndicatorBackgroundColor: Get.theme.primaryColor.withOpacity(0.2),
		  progressIndicatorValueColor: AlwaysStoppedAnimation(
				  Picaso.paint.primary),
	  );

}
