import 'dart:io';
import 'package:scheme_automation/pubspec_api.dart';

import '../commons.dart' as commons;
import 'package:path/path.dart' as path;

/// main util boilerplate code.
void buildModule() async {
	copyStockFiles();
}




/// copies util files.
void copyStockFiles() {
	commons.copyFilesRecursive(
			'${commons.scriptRoot}${path.separator}lib${path.separator}scheme_module${path.separator}lib', '.${path.separator}',
			renameBaseDir: '.${path.separator}lib');
}
