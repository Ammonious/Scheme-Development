import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FocusNotifier extends ChangeNotifier {


	final _focusStreamSubject = PublishSubject<bool>();
	final _nextFocusStreamSubject = PublishSubject<bool>();


	Stream<bool> mainStream(FocusNode focusNode) {
		focusNode.addListener(() => _focusStreamSubject.add(focusNode.hasFocus));
		return _focusStreamSubject;
	}

	Stream<bool> nextStream(FocusNode focusNode) {

		if(focusNode != null){
			focusNode.addListener(() => _nextFocusStreamSubject.add(focusNode.hasFocus));
		}
		return _nextFocusStreamSubject;
	}

}