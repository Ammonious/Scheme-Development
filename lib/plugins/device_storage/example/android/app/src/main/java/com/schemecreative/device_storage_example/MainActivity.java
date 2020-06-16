package com.schemecreative.device_storage_example;

import androidx.annotation.NonNull;

import com.schemecreative.device_storage.DeviceStoragePlugin;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private  String CHANNEL = "device_storage";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), "device_storage");
        methodChannel.setMethodCallHandler(new DeviceStoragePlugin());
    }
}
