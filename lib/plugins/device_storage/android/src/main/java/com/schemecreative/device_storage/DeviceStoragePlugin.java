package com.schemecreative.device_storage;

import android.content.Context;
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
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static androidx.core.content.ContextCompat.getExternalFilesDirs;

/** DeviceStoragePlugin */
public class DeviceStoragePlugin implements FlutterPlugin, MethodCallHandler {

  private MethodChannel channel;
     Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    setupMethodChannel(binding.getBinaryMessenger(),binding.getApplicationContext());
  }

  public static void registerWith(Registrar registrar) {
    DeviceStoragePlugin plugin = new DeviceStoragePlugin();
    plugin.setupMethodChannel(registrar.messenger(),registrar.context());

  }


  private void setupMethodChannel(BinaryMessenger messenger, Context context) {
    this.context = context;
    channel = new MethodChannel(messenger, "device_storage");
    final MethodCallHandlerImpl handler =
            new MethodCallHandlerImpl(context.getContentResolver(), context.getPackageManager());
    channel.setMethodCallHandler(handler);
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
    File[] dirs= getExternalFilesDirs(context, null);
    StatFs stat = new StatFs(dirs[1].getPath().split("Android")[0]);
    return stat.getTotalBytes();
  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
  public Long getExternalStorageFreeSpace() {
    File[] dirs = getExternalFilesDirs(context, null);
    StatFs stat = new StatFs(dirs[1].getPath().split("Android")[0]);
    return stat.getAvailableBytes();
  }
}

