

import '../commons.dart' as commons;
import 'package:path/path.dart' as path;

/// main App Theme boilerplate code.
void buildModule() async {
	copyStockFiles();
}


/// copies util files.
void copyStockFiles() {
	commons.copyFilesRecursive(
			'${commons.scriptRoot}${path.separator}lib${path.separator}scheme_module${path.separator}common${path.separator}dialog_utils', '.${path.separator}',
			renameBaseDir: '.${path.separator}lib');
}
