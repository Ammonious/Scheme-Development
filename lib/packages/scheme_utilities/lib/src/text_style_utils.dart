import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SchemeFontUtils extends GetController{


  fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(Get.context).requestFocus(nextFocus);
  }

  dismissKeyboard() =>
      FocusScope.of(Get.context).requestFocus(FocusNode());


  // Adapted these helpful functions from:
// https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/text_field_test.dart

// Returns first render editable
  RenderEditable findRenderEditable(RenderObject root) {
    RenderEditable renderEditable;
    void recursiveFinder(RenderObject child) {
      if (child is RenderEditable) {
        renderEditable = child;
        return;
      }
      child.visitChildren(recursiveFinder);
    }

    root.visitChildren(recursiveFinder);
    return renderEditable;
  }

  List<TextSelectionPoint> globalize(
      Iterable<TextSelectionPoint> points, RenderBox box) {
    return points.map<TextSelectionPoint>((TextSelectionPoint point) {
      return TextSelectionPoint(
        box.localToGlobal(point.point),
        point.direction,
      );
    }).toList();
  }

  Offset getCaretPosition(RenderBox box) {
    final RenderEditable renderEditable = findRenderEditable(box);
    if (!renderEditable.hasFocus) {
      return null;
    }
    final List<TextSelectionPoint> endpoints = globalize(
      renderEditable.getEndpointsForSelection(renderEditable.selection),
      renderEditable,
    );
    return endpoints[0].point + const Offset(0.0, -2.0);
  }


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
