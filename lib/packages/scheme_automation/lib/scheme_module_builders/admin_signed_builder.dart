import '../commons.dart' as commons;
import 'package:path/path.dart' as path;

/// main App Theme boilerplate code.
void buildModule() async {
	copyStockFiles();
}


/// copies util files.
void copyStockFiles() {
	commons.copyFilesRecursive(
			'${commons.scriptRoot}${path.separator}lib${path.separator}admin_signed_module${path.separator}lib', '.${path.separator}',
			renameBaseDir: '.${path.separator}lib');
}