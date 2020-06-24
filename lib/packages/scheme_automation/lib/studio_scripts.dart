import 'dart:io';

import 'package:scheme_automation/commons.dart';


void buildResponsiveLayoutScript(){

}

getInputFromUser(){
	stdout.writeln('Enter the name of the page.');
	String input = stdin.readLineSync();
	stdout.writeln('Creating ${input}Page in ${input}_page folder.');
	writeFile(input, 'page.dart');
	writeFile(input, 'page_mobile.dart');
	writeFile(input, 'page_desktop.dart');
	writeFile(input, 'page_tablet.dart');
}


writeFile(String input,String file){
	String fileName = file.split('.').first;
	String mainTemp = getFileAsString('$studioPath$file');
	mainTemp.replaceAll('', '');
}