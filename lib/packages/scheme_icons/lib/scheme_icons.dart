library scheme_icons;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'src/icon_types/flare_icon.dart';
export 'src/scheme_icon.dart';
export 'src/constants/icon_index.dart';

class SchemeIconUtils extends GetController{
	static SchemeIconUtils get to => Get.put(SchemeIconUtils());


	getAssetsFromFolder(String iconFolder) async {
		final manifestContent = await DefaultAssetBundle.of(Get.context).loadString('AssetManifest.json');

		final Map<String, dynamic> manifestMap = json.decode(manifestContent);
		return  manifestMap.keys
				.where((String key) => key.contains(iconFolder))
				.toList();
	}

}