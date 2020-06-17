import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scheme_utilities/scheme_utilities.dart';

String paddingToCode(EdgeInsets padding) {
  padding ??= EdgeInsets.zero;
  return 'EdgeInsets.only('
      'top:${padding.top},'
      'bottom:${padding.bottom},'
      'left:${padding.left}, '
      'right:${padding.right}'
      ')';
}

Map<String, dynamic> paddingToMap(EdgeInsets padding) {
  padding ??= EdgeInsets.zero;
  return {
    'top': padding.top.toInt(),
    'right': padding.right.toInt(),
    'bottom': padding.bottom.toInt(),
    'left': padding.left.toInt(),
  };
}

EdgeInsetsGeometry paddingFromMap(Map<String, dynamic> data) => EdgeInsets.only(
      left: (data['left'] as int).toDouble(),
      top: (data['top'] as int).toDouble(),
      right: (data['right'] as int).toDouble(),
      bottom: (data['bottom'] as int).toDouble(),
    );




Map<String, dynamic> borderRadiusToMap(BorderRadiusGeometry radius) {
  final borderRadius = radius as BorderRadius;
  return <String, dynamic>{
    'topLeft': {'x': borderRadius.topLeft.x, 'y': borderRadius.topLeft.y},
    'topRight': {'x': borderRadius.topRight.x, 'y': borderRadius.topRight.y},
    'bottomLeft': {
      'x': borderRadius.bottomLeft.x,
      'y': borderRadius.bottomLeft.y
    },
    'bottomRight': {
      'x': borderRadius.bottomRight.x,
      'y': borderRadius.bottomRight.y
    },
  };
}

String borderSideToCode(BorderSide side) {
  return 'BorderSide(color: ${colorToCode(side.color)}, width: ${side.width}, style: ${side.style}, )';
}

Map<String, dynamic> borderSideToMap(BorderSide side) {
  return <String, dynamic>{
    'color': side.color.value,
    'width': side.width.toStringAsFixed(0),
    'style': max(0, BorderStyle.values.indexOf(side.style)),
  };
}

BorderRadius borderRadiusFromMap(Map<String, dynamic> data) {
  return BorderRadius.only(
    topLeft: Radius.circular(data['topLeft']['x']),
    topRight: Radius.circular(data['topRight']['x']),
    bottomLeft: Radius.circular(data['bottomLeft']['x']),
    bottomRight: Radius.circular(data['bottomRight']['x']),
  );
}

BorderSide borderSideFromMap(dynamic data) {
  if (data == null || data == 'none') return BorderSide.none;
  return BorderSide(
    color: Color(data['color']),
    width: double.parse(data['width']) ?? 1.0,
    style: BorderStyle.values[max(0, data['style'])],
  );
}
