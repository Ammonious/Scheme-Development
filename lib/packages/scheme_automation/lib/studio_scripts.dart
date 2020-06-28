import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:scheme_automation/commons.dart' as commons;



void buildResponsiveLayoutScript(){

}

void incrementPubspecVersion() async{
	List<String> pubspec = commons.getFileAsLines(commons.pubspecPath);
	pubspec = pubspec.map((line) {
		if (line.contains(RegExp('version'))) {
			var array = line.split('.');
			var topLevel = array.first;
			var midLevel = array.length >= 2 ? array[1] : null;
			var endLevel = array.length >= 3 ?array.last : null;

			var version = _handleVersionIncrement(topLevel, midLevel, endLevel);


			return """$version""";
		} else {
			return line;
		}
	}).toList();

	commons.writeStringToFile(commons.pubspecPath, pubspec.join("\n"));
	stdout.writeln("configured release configs");
}

_handleVersionIncrement(String firstLevel,String midLevel,String endLevel){
	var e =_incrementCheck(endLevel);
	var m = _incrementCheck(midLevel);
	var f = _incrementCheck(firstLevel);
	if(e != null && m != null && e == 0) m++;
	if(m != null && m == 0) f++;

	return 'version: ${f}.${m}.${e}';
}

_incrementCheck(String level){
	if(level != null){
		var i = int.tryParse(level);
		i++;
		if(i == 10) i = 0;
		return i;
	}
	return null;
}

getInputFromUser(){
	stdout.writeln('Enter the name of the page.');
	final input = stdin.readLineSync();
	stdout.writeln('Creating ${input}Page in ${input}_page folder.');
	writeFile(input, 'page.dart.temp');
	writeFile(input, 'page_mobile.dart');
	writeFile(input, 'page_desktop.dart');
	writeFile(input, 'page_tablet.dart');
}


writeFile(String input,String file){
	String fileName = file.split('.').first;
	String mainTemp = getFileAsString('$studioPath$file');
	mainTemp.replaceAll('', '');
}