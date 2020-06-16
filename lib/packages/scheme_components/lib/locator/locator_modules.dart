
import 'package:injectable/injectable.dart';
import 'package:scheme_components/src/dialogs/dialog_service.dart';

@module
abstract class LocatorServiceModules {
	@lazySingleton
	DialogService get dialogService;
}