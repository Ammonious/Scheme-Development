

import 'package:flutter/material.dart';

class LayeredImage {

	 String get backLayer => images.first;
	 String get middleLayer => images[1];
	 String get frontLayer => images.last;
	 final Color cardColor;
	final List images;
  LayeredImage(this.images,{this.cardColor});

}

const  List newYorkParallax = [
	_Res.ny_back,
	_Res.ny_mid,
	_Res.ny_front
];

const  List budapestParallax = [
	_Res.budapest_back,
	_Res.budapest_middle,
	_Res.budapest_front
];


const  List pisaParallax = [
	_Res.pisa_back,
	_Res.pisa_middle,
	_Res.pisa_front
];


const  List londonParallax = [
	_Res.london_back,
	_Res.london_middle,
	_Res.london_front
];

class _Res {
	static const String london_middle = "assets/other/london_middle.png";
	static const String ny_back = "assets/other/ny_back.png";
	static const String ny_mid = "assets/other/ny_mid.png";
	static const String pisa_middle = "assets/other/pisa_middle.png";
	static const String pisa_back = "assets/other/pisa_back.png";
	static const String budapest_middle = "assets/other/budapest_middle.png";
	static const String pisa_front = "assets/other/pisa_front.png";
	static const String budapest_back = "assets/other/budapest_back.png";
	static const String london_back = "assets/other/london_back.png";
	static const String budapest_front = "assets/other/budapest_front.png";
	static const String london_front = "assets/other/london-front.png";
	static const String ny_front = "assets/other/ny_front.png";
}