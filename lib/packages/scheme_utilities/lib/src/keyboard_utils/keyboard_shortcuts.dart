



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BasicShortcut {
	creation,
	previousPage,
	nextPage,
	save,
}
class SchemeKeyUtils {


	Widget customGlobal;
	String customTitle;
	IconData customIcon;

	void initShortCuts(Widget homePage,
			{Widget helpGlobal, String helpTitle, IconData helpIcon}) {
		customGlobal = helpGlobal;
		customTitle = helpTitle;
		customIcon = helpIcon;
	}


	Set<LogicalKeyboardKey> shortcut(BasicShortcut basicShortcut) {
		switch (basicShortcut) {
			case BasicShortcut.creation:
				return {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyN};
			case BasicShortcut.previousPage:
				return {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.arrowLeft};
			case BasicShortcut.nextPage:
				return {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.arrowRight};
			case BasicShortcut.save:
				return {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyS};
			default:
				return {};
		}
	}
}