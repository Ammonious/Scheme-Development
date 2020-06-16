import 'dart:async';

import 'package:flutter/services.dart';

class DeviceStorage {
  static const MethodChannel _channel =
      const MethodChannel('device_storage');

  static Future<int> get storageFreeSpace async => await _channel.invokeMethod("getStorageFreeSpace");

  static Future<int> get storageTotalSpace async => await _channel.invokeMethod("getStorageTotalSpace");


  static Future<int> get externalStorageFreeSpace async => await _channel.invokeMethod("getExternalStorageFreeSpace");


  static Future<int> get externalStorageTotalSpace async => await _channel.invokeMethod("getExternalStorageTotalSpace");

}
