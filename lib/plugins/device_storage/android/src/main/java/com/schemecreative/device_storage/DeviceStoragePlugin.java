package com.schemecreative.device_storage;

import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.util.Log;

import androidx.core.content.ContextCompat.*;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static androidx.core.content.ContextCompat.getExternalFilesDirs;

/** DeviceStoragePlugin */
public class DeviceStoragePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private  FlutterPluginBinding flutterPluginBinding;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding;
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "device_storage");
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "device_storage");
    channel.setMethodCallHandler(new DeviceStoragePlugin());
  }

  @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getStorageFreeSpace":
        result.success(getStorageFreeSpace());
        break;
      case "getStorageTotalSpace":
        result.success(getStorageTotalSpace());
        break;
      case "getExternalStorageTotalSpace":
        result.success(getExternalStorageTotalSpace());
        break;
      case "getExternalStorageFreeSpace":
        result.success(getExternalStorageFreeSpace());
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
  public Long getStorageTotalSpace(){
    File path = Environment.getDataDirectory();
    StatFs stat = new StatFs(path.getPath());
    return stat.getTotalBytes();
  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
  public Long getStorageFreeSpace(){
    File path = Environment.getDataDirectory();
    StatFs stat = new StatFs(path.getPath());
    Log.i("Internal", path.getPath());
    return stat.getAvailableBytes();
  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
  public Long getExternalStorageTotalSpace() {
    File[] dirs= getExternalFilesDirs(flutterPluginBinding.getApplicationContext(), null);
    StatFs stat = new StatFs(dirs[1].getPath().split("Android")[0]);
    return stat.getTotalBytes();
  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
  public Long getExternalStorageFreeSpace() {
    File[] dirs = getExternalFilesDirs(flutterPluginBinding.getApplicationContext(), null);
    StatFs stat = new StatFs(dirs[1].getPath().split("Android")[0]);
    return stat.getAvailableBytes();
  }
}

