import 'package:get/get.dart';
import 'package:scheme_components/src/animations/teddy_flare/controllers/teddy_controller.dart';

class FormController extends GetxController {
	static FormController get to => Get.put(FormController());

	String get password => _rxPassword.value ?? '';
	String get username => _rxUser.value ?? '';

	String _password;
	String _username;

	get _rxUser => _username.obs;
	get _rxPassword => _password.obs;
	TeddyController teddyController;


	@override
  void onInit() {
    super.onInit();
    teddyController = TeddyController();

  }



  onUserFieldChanged(String text) => _username = text;

	onPasswordChanged(String text) => _password = text;

}