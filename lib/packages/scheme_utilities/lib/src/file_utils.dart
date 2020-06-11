import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as i;
import 'package:path/path.dart' as p;
import 'package:share_extend/share_extend.dart';

import 'image_utils/image_cache_manager.dart';

class SchemeFileUtils  extends GetController{

	static SchemeFileUtils get to => Get.put(SchemeFileUtils());

	Future<File> saveFile(String filename,{String pathKey}) async {
		await Hive.initFlutter();
		Directory dir = await getApplicationDocumentsDirectory();
		String pathName = p.join(dir.path, filename);
		await saveToPrefs(pathKey ?? filename, pathName);
		return File(pathName);
	}

	Future<File> getImageFromNetwork(String url) async {

		File file = await ImageCacheManager().getSingleFile(url);
		return file;
	}

	Future<File> saveImage(String url,String imageType) async {

		await Hive.initFlutter();
		final file = await getImageFromNetwork(url);
		Directory dir = await getApplicationDocumentsDirectory();
		String pathName = p.join(dir.path, imageType);
		i.Image image = i.decodeImage(file.readAsBytesSync());

		await saveToPrefs(imageType, pathName);
		return File('$pathName.png')
			..writeAsBytesSync(i.encodePng(image));

	}

	saveToPrefs(imageType,pathName) async {
		await Hive.initFlutter();

		var box = Hive.box('scheme_file_storage');
	await	Hive.openBox('scheme_file_storage');
		box.put(imageType, '$pathName.png');
	}

	Future<File> getFile({String fileName}) async {
		final directory = await getApplicationDocumentsDirectory();
		await Hive.initFlutter();
		var box = await Hive.openBox('scheme_file_storage');

		return File(box.get(fileName,defaultValue: directory.path));
	}

	Future<void> saveShareFile(String fileName,{String sheetTitle,String message}) async {
		File file = await saveFile(fileName);
		return ShareExtend.share(file.path, "image");
	}

	Future<void> shareFile(File file,{String sheetTitle,String message}) async => ShareExtend.share(file.path, "image");


	Future<dynamic> copyClipboard(String text) => Clipboard.setData(
			ClipboardData(text: text));

	Future<String> get localPath async {
		final directory = await getApplicationDocumentsDirectory();
		return directory.path;
	}

	Future<File> savePDFFromURL(String url,String name) async {
		final filename = '${name}.pdf';
		var request = await HttpClient().getUrl(Uri.parse(url));
		var response = await request.close();
		var bytes = await consolidateHttpClientResponseBytes(response);
		String dir = (await getApplicationDocumentsDirectory()).path;
		File file =  File('$dir/$filename');
		await saveToPrefs(name, file.path);
		await file.writeAsBytes(bytes);
		return file;
	}

}