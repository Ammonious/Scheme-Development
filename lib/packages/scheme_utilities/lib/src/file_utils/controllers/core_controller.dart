import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

class SchemeCoreController extends GetController {
  List<FileSystemEntity> availableStorage = List();
  List<FileSystemEntity> recentFiles = List();

  int totalSpace = 0;
  int freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  int usedSpace = 0;
  int usedSDSpace = 0;
  bool loading = true;

  checkSpace() async {
    setLoading(true);
    recentFiles.clear();
    availableStorage.clear();
    List<FileSystemEntity> l = await getExternalStorageDirectories();
    availableStorage.addAll(l);
    update();

    MethodChannel platform = MethodChannel('dev.jideguru.filex/storage');
    var free = await platform.invokeMethod("getStorageFreeSpace");
    var total = await platform.invokeMethod("getStorageTotalSpace");
    setFreeSpace(free);
    setTotalSpace(total);
    setUsedSpace(total - free);
    if (l.length > 1) {
      var freeSD = await platform.invokeMethod("getExternalStorageFreeSpace");
      var totalSD = await platform.invokeMethod("getExternalStorageTotalSpace");
      setFreeSDSpace(freeSD);
      setTotalSDSpace(totalSD);
      setUsedSDSpace(totalSD - freeSD);
    }
    getRecentFiles();
  }

  getRecentFiles() async {
    List<FileSystemEntity> l = await SchemeFileUtils.getRecentFiles(showHidden: false);
    recentFiles.addAll(l);
    setLoading(false);
  }

  void setFreeSpace(value) {
    freeSpace = value;
    update();
  }

  void setTotalSpace(value) {
    totalSpace = value;
    update();
  }

  void setUsedSpace(value) {
    usedSpace = value;
    update();
  }

  void setFreeSDSpace(value) {
    freeSDSpace = value;
    update();
  }

  void setTotalSDSpace(value) {
    totalSDSpace = value;
    update();
  }

  void setUsedSDSpace(value) {
    usedSDSpace = value;
    update();
  }

  void setLoading(value) {
    loading = value;
    update();
  }

  void showToast(title, message) {
    Get.snackbar(title, message, duration: Duration(seconds: 4));
    update();
  }
}
