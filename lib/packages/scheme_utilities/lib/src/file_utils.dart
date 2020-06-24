import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_extend/share_extend.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as i;
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'image_utils/image_cache_manager.dart';

class SchemeFileUtils  extends GetController{

	static SchemeFileUtils get to => Get.put(SchemeFileUtils());

	Future<File> saveFile(String filename,{String pathKey}) async {
		StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
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

		StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
		final file = await getImageFromNetwork(url);
		Directory dir = await getApplicationDocumentsDirectory();
		String pathName = p.join(dir.path, imageType);
		i.Image image = i.decodeImage(file.readAsBytesSync());

		await saveToPrefs(imageType, pathName);
		return File('$pathName.png')
			..writeAsBytesSync(i.encodePng(image));

	}

	saveToPrefs(imageType,pathName) async {
		StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;

		prefs.setString(imageType, '$pathName.png');
	}

	Future<File> getFile({String fileName}) async {
		StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
		final directory = await getApplicationDocumentsDirectory();

		return File(prefs.getString(fileName,defaultValue: directory.path).getValue());
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

	/// Get mime information of a file
	static String getMime(String path) {
		File file = File(path);
		String mimeType = mime(file.path);
		return mimeType;
	}

	/// Return all available Storage path
	static Future<List<Directory>> getStorageList() async {
		List<Directory> paths = await getExternalStorageDirectories();
		List<Directory> filteredPaths = List<Directory>();
		for (Directory dir in paths) {
			filteredPaths.add(removeDataDirectory(dir.path));
		}
		return filteredPaths;
	}

	static Directory removeDataDirectory(String path) {
		return Directory(path.split("Android")[0]);
	}

	static Future<List<FileSystemEntity>> getFilesInPath(String path) async {
		Directory dir = Directory(path);
		return dir.listSync();
	}

	static Future<List<FileSystemEntity>> getAllFiles({bool showHidden}) async {
		List<Directory> storages = await getStorageList();
		List<FileSystemEntity> files = List<FileSystemEntity>();
		for (Directory dir in storages) {
			files.addAll(await getAllFilesInPath(dir.path, showHidden: showHidden));
		}
		return files;
	}

	static Future<List<FileSystemEntity>> getRecentFiles(
			{bool showHidden}) async {
		List<FileSystemEntity> files = await getAllFiles(showHidden: showHidden);
		files.sort((a, b) => File(a.path)
				.lastAccessedSync()
				.compareTo(File(b.path).lastAccessedSync()));
		return files.reversed.toList();
	}

	static Future<List<FileSystemEntity>> searchFiles(String query,
			{bool showHidden}) async {
		List<Directory> storage = await getStorageList();
		List<FileSystemEntity> files = List<FileSystemEntity>();
		for (Directory dir in storage) {
			List fs = await getAllFilesInPath(dir.path, showHidden: showHidden);
			for (FileSystemEntity fs in fs) {
				if (basename(fs.path).toLowerCase().contains(query.toLowerCase())) {
					files.add(fs);
				}
			}
		}
		return files;
	}

	/// Get all files
	static Future<List<FileSystemEntity>> getAllFilesInPath(String path,
			{bool showHidden}) async {
		List<FileSystemEntity> files = List<FileSystemEntity>();
		Directory d = Directory(path);
		List<FileSystemEntity> l = d.listSync();
		for (FileSystemEntity file in l) {
			if (FileSystemEntity.isFileSync(file.path)) {
				if (!showHidden) {
					if (!basename(file.path).startsWith(".")) {
						files.add(file);
					}
				} else {
					files.add(file);
				}
			} else {
				if (!file.path.contains("/storage/emulated/0/Android")) {
//          print(file.path);
					if (!showHidden) {
						if (!basename(file.path).startsWith(".")) {
							files.addAll(
									await getAllFilesInPath(file.path, showHidden: showHidden));
						}
					} else {
						files.addAll(
								await getAllFilesInPath(file.path, showHidden: showHidden));
					}
				}
			}
		}
//    print(files);
		return files;
	}

	static String formatTime(String iso) {
		DateTime date = DateTime.parse(iso);
		DateTime now = DateTime.now();
		DateTime yDay = DateTime.now().subtract(Duration(days: 1));
		DateTime dateFormat = DateTime.parse(
				"${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}T00:00:00.000Z");
		DateTime today = DateTime.parse(
				"${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}T00:00:00.000Z");
		DateTime yesterday = DateTime.parse(
				"${yDay.year}-${yDay.month.toString().padLeft(2, "0")}-${yDay.day.toString().padLeft(2, "0")}T00:00:00.000Z");

		if (dateFormat == today) {
			return "Today ${DateFormat("HH:mm").format(DateTime.parse(iso))}";
		} else if (dateFormat == yesterday) {
			return "Yesterday ${DateFormat("HH:mm").format(DateTime.parse(iso))}";
		} else {
			return "${DateFormat("MMM dd, HH:mm").format(DateTime.parse(iso))}";
		}
	}

	static List<FileSystemEntity> sortList(
			List<FileSystemEntity> list, int sort) {
		switch (sort) {
			case 0:
				if (list.toString().contains("Directory")) {
					list
						..sort((f1, f2) => basename(f1.path)
								.toLowerCase()
								.compareTo(basename(f2.path).toLowerCase()));
					return list
						..sort((f1, f2) => f1
								.toString()
								.split(":")[0]
								.toLowerCase()
								.compareTo(f2.toString().split(":")[0].toLowerCase()));
				} else {
					return list
						..sort((f1, f2) => basename(f1.path)
								.toLowerCase()
								.compareTo(basename(f2.path).toLowerCase()));
				}
				break;

			case 1:
				list.sort((f1, f2) => basename(f1.path)
						.toLowerCase()
						.compareTo(basename(f2.path).toLowerCase()));
				if (list.toString().contains("Directory")) {
					list
						..sort((f1, f2) => f1
								.toString()
								.split(":")[0]
								.toLowerCase()
								.compareTo(f2.toString().split(":")[0].toLowerCase()));
				}
				return list.reversed.toList();
				break;

			case 2:
				return list
					..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
							FileSystemEntity.isFileSync(f2.path)
							? File(f1.path)
							.lastModifiedSync()
							.compareTo(File(f2.path).lastModifiedSync())
							: 1);
				break;

			case 3:
				list
					..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
							FileSystemEntity.isFileSync(f2.path)
							? File(f1.path)
							.lastModifiedSync()
							.compareTo(File(f2.path).lastModifiedSync())
							: 1);
				return list.reversed.toList();
				break;

			case 4:
				list
					..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
							FileSystemEntity.isFileSync(f2.path)
							? File(f1.path).lengthSync().compareTo(File(f2.path).lengthSync())
							: 0);
				return list.reversed.toList();
				break;

			case 5:
				return list
					..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
							FileSystemEntity.isFileSync(f2.path)
							? File(f1.path).lengthSync().compareTo(File(f2.path).lengthSync())
							: 0);
				break;

			default:
				return list..sort();
		}
	}

	static List<T> map<T>(List list, Function handler) {
		List<T> result = [];
		for (var i = 0; i < list.length; i++) {
			result.add(handler(i, list[i]));
		}

		return result;
	}
}