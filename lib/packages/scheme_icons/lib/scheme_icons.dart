library scheme_icons;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'src/constants/evericons.dart';


export 'src/constants/bang_icons.dart';
export 'src/constants/box_icons.dart';
export 'src/constants/flare_icons.dart';
export 'src/constants/lottie_icon.dart';
export 'src/constants/material_color_icons.dart';
export 'src/constants/round.dart';
export 'src/constants/two_tone.dart';
export 'src/constants/unicons.dart';
export 'src/constants/logo_icons.dart';
export 'src/constants/lottie_icon.dart';
export 'src/icon_types/flare_icon.dart';
export 'src/constants/bang_icon_paths.dart';
export 'src/scheme_icon.dart';


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