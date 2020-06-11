import 'package:get/get.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_constants.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_data.dart';

class SchemeNavController extends GetController {

	static SchemeNavController get to => Get.put(SchemeNavController());
	int lastIndex;
	int get currentIndex => _rxCurrentIndex.value;
	int _currentIndex = 0;
	get _rxCurrentIndex => _currentIndex.obs;



	void selectIndex(int index,SchemeNavData item,{Function(String route) navigateTo,Function(int index) onPositionChanged}) {
		lastIndex = currentIndex;
		_currentIndex = index;
		update();
		if(navigateTo != null) navigateTo(item.route);
		if(onPositionChanged != null) onPositionChanged(index);
	}

	CustomAnimationControl get control => _rxControl.value;
	CustomAnimationControl _control;
	Rx<Object> get _rxControl => _control.obs;

	bool get isSelected => _rxIsSelected.value;
	bool _isSelected = false;
	BoolX get _rxIsSelected => _isSelected.obs;

	startAnimIfSelectedChanged(bool selected){
		_isSelected = selected;
		_isSelected
				? _control = CustomAnimationControl.PLAY
				: _control = CustomAnimationControl.PLAY_REVERSE;
	}

	initFlipButtonIcon(SchemeNavStyle barStyle){
		switch(barStyle){
		  case SchemeNavStyle.neu:
		  case SchemeNavStyle.bubble:
		    // TODO: Handle this case.
		    break;
		}
	}
}