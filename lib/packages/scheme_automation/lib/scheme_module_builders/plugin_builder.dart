import 'dart:io';
import '../commons.dart' as commons;


/// adds [get_it] to pubspec.yaml
Future<void> buildPlugins() async {
	String pubspec = commons.getFileAsString(commons.pubspecPath);


	if (!pubspec.contains("intl")){
		String plugin = "intl: ${commons.loadConfig()['plugins']['intl']}";
		commons.addDependencies("  $plugin");
	}

	if (!pubspec.contains("date_format")){
		String plugin = "date_format: ${commons.loadConfig()['plugins']['date_format']}";
		commons.addDependencies("  $plugin");
	}
	if (!pubspec.contains("responsive_builder")){
		String plugin = "responsive_builder: ${commons.loadConfig()['plugins']['responsive_builder']}";
		commons.addDependencies("  $plugin");
	}
	if (!pubspec.contains("google_fonts")){
		String plugin = "google_fonts: ${commons.loadConfig()['plugins']['google_fonts']}";
		commons.addDependencies("  $plugin");
	}
	if (!pubspec.contains("get_it") ){
		String plugin = "get_it: ${commons.loadConfig()['plugins']['get_it']}";
		String devPlugin = !pubspec.contains("build_runner") ? "build_runner: ${commons.loadConfig()['dev_plugins']['build_runner']}" : '';
		commons.addDependencies("  $plugin",devDependencies: '  $devPlugin');
	}
	if (!pubspec.contains("injectable")){
		String plugin = "injectable: ${commons.loadConfig()['plugins']['injectable']}";
		String devPlugin = "injectable_generator: ${commons.loadConfig()['dev_plugins']['injectable_generator']}";
		commons.addDependencies("  $plugin",devDependencies:'  $devPlugin');
	}

	if (!pubspec.contains("auto_route")){
		String plugin = "auto_route: ${commons.loadConfig()['plugins']['auto_route']}";
		String devPlugin = "auto_route_generator: ${commons.loadConfig()['dev_plugins']['auto_route_generator']}";
		commons.addDependencies("  $plugin",devDependencies: '  $devPlugin');
	}
	if (!pubspec.contains("scheme_package")){
		String plugin = "scheme_package: ${commons.loadConfig()['plugins']['scheme_package']}";
		commons.addDependencies("  $plugin");
	}
	stdout.writeln("scheme plugins added.");
}