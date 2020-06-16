import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:device_storage/device_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheme_icons/scheme_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _storageFreeSpace = 0;
  int _storageTotalSpace;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    int storageFreeSpace;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      storageFreeSpace = await DeviceStorage.storageFreeSpace;
      storageFreeSpace = await DeviceStorage.storageTotalSpace;
    } on PlatformException {
      storageFreeSpace = 12;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _storageFreeSpace = storageFreeSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Storage'),
        ),
        body: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [SchemeIcon.color(asset: MdcIcons.database), Text('Free Space: $_storageFreeSpace\n',style: GoogleFonts.varelaRound(fontSize: 24,fontWeight: FontWeight.w400),)],
              ),
              SizedBox(height: 24,),
              Row(
                children: [SchemeIcon.color(asset: MdcIcons.database), Text('Total Space: $_storageTotalSpace\n',style: GoogleFonts.varelaRound(fontSize: 24,fontWeight: FontWeight.w400),)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
