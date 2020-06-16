import 'package:flutter/material.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_utilities/src/file_utils/model/file_categories.dart';

class FileConstants {
  //App related strings 

  //Colors for theme
  static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Color(0xff2B2B2B);
  static Color lightAccent = Color(0xff597ef7);
  static Color darkAccent = Color(0xff597ef7);
  static Color lightBG = Color(0xfff3f4f9);
  static Color darkBG = Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    FileCategory(
        title: 'Downloads',
        icon: SchemeIcon.color(asset: MdcIcons.download),
        path: '',
        color: Colors.purpleAccent.shade700),
    FileCategory(
        title: 'Images',
        icon: SchemeIcon.color(asset: MdcIcons.photo_gallery),
        path: '',
        color: Colors.blueAccent.shade700),
    FileCategory(
        title: 'Videos',
        icon: SchemeIcon.color(asset: MdcIcons.file_type_video),
        path: '',
        color: Colors.tealAccent.shade700),
    FileCategory(
        title: 'Audio',
        icon: SchemeIcon.color(asset: MdcIcons.file_type_audio),
        path: '',
        color: Colors.pinkAccent.shade700),
    FileCategory(
        title: 'Documents & Others',
        icon: SchemeIcon.color(asset: MdcIcons.file),
        path: '',
        color: Colors.yellowAccent.shade700),
    FileCategory(
        title: 'Apps',
        icon: SchemeIcon.svg(asset: Unicons.android),
        path: '',
        color: Colors.greenAccent.shade700),
  ];

  static List sortList = [
    "File name (A to Z)",
    "File name (Z to A)",
    "Date (oldest first)",
    "Date (newest first)",
    "Size (largest first)",
    "Size (Smallest first)",
  ];
}
