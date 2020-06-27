
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

/// QUICK AND EASY

class SchemePermission {
	static SchemePermission get to => Get.put(SchemePermission());


	Future<PermissionStatus> requestStoragePermission() async {
		PermissionStatus status = await Permission.storage.status;
		switch (status) {
			case PermissionStatus.undetermined:
			// TODO: We didn't ask for permission yet.
				return await Permission.storage.request();
			case PermissionStatus.granted:
			case PermissionStatus.denied:
			case PermissionStatus.restricted:
			case PermissionStatus.permanentlyDenied:
				return status;
			default:
				return status;
		}
	}


}