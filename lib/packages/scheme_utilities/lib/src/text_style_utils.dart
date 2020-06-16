import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SchemeFontUtils extends GetController{


  Future<ByteData> _fetchFont(String fontPath) async {
    final response = await http.get(fontPath);

    if (response.statusCode == 200) {
      return ByteData.view(response.bodyBytes.buffer);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load font');
    }
  }


  Future<ByteData> _fetchLocalFont(String fileName) async {
	  return rootBundle.load(fileName);
  }
  loadDynamicFont({SchemeFont font}) async {
    FontLoader fontLoader = FontLoader(font.family);
    fontLoader.addFont(_fetchFont(font.path));
    await fontLoader.load();
  }

  /// [fonts] is a [List] of fontFamily names.
  loadDynamicFonts({List<SchemeFont> fonts}) async {
    fonts.forEach((font) async {
      FontLoader loader = FontLoader(font.family);
      loader.addFont(_fetchFont(font.path));
      await loader.load();
    });
  }
}

class SchemeFont {
  final String family;
  final String path;

  SchemeFont({@required this.family, @required this.path});
}
