import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SchemeDeviceUtils extends GetxController {


Future<String> packageVersion() async => 	await PackageInfo.fromPlatform().then((packageInfo) => packageInfo.version);
	Future<int> androidSystemVersion() async {
		DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
		AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
		return androidInfo.version.sdkInt;
	}

	Future<int> iosSystemVersion() async {
		DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
		IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
		String iosVersion = iosInfo.systemVersion.split('.').first;
		int versionNumber = int.tryParse(iosVersion);
		return versionNumber;

	}

	darkModeSupported() async {
		bool supported = false;
		if (Platform.isAndroid) {
			int androidVersion = await androidSystemVersion();
			supported = androidVersion >= 29;
		} else if (Platform.isIOS) {
			int versionNumber = await iosSystemVersion();
			supported = versionNumber >= 13;
		}
		return supported;
	}


	final isPlatformDark =
			WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

String get	devicePlatform => _getPlatform();
String _getPlatform() {
	if (Platform.isAndroid) {
		return 'Android';
	} else if (Platform.isIOS) {
		return 'iOS';
	}
	return 'Android';
}

}