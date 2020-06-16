
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'locator.iconfig.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> componentLocator() async {
	$initGetIt(locator);
}




// ignore: slash_for_doc_comments
/********************************
 * ? flutter packages pub run build_runner build
 * ? flutter packages pub run build_runner watch

 *********************************/