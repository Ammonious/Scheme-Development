import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheme_components/src/constants/constants.dart';
import 'package:scheme_shared/scheme_shared.dart';
import 'fake_html.dart' if (dart.library.html) 'dart:html' as html;
import 'fake_ui.dart' if (dart.library.html) 'dart:ui' as ui;

class PlatformSvg {
	static final Random _random = Random();

	static Widget string(String svgString,
			{double width = 24, double height = 24, String hashCode}) {
		if (kIsWeb) {
			hashCode ??= String.fromCharCodes(
					List<int>.generate(128, (i) => _random.nextInt(256)));
			ui.platformViewRegistry.registerViewFactory('img-svg-$hashCode',
							(int viewId) {
						final String base64 = base64Encode(utf8.encode(svgString));
						final String base64String = 'data:image/svg+xml;base64,$base64';
						final html.ImageElement element = html.ImageElement(
								src: base64String, height: width.toInt(), width: width.toInt());
						return element;
					});
			return Container(
				width: width,
				height: width,
				alignment: Alignment.center,
				child: HtmlElementView(
					viewType: 'img-svg-$hashCode',
				),
			);
		}
		return SvgPicture.string(svgString);
	}

	static Widget asset(String assetName,
			{double width = 24,
				double height = 24,
				BoxFit fit = BoxFit.contain,
				Color color,
				String package,
				String semanticsLabel}) {
		if (kIsWeb) {
			String hashCode = assetName.replaceAll('/', '-').replaceAll('.', '-');
			return FutureBuilder(
					future: rootBundle.loadString(assetName),
					builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
						if (snapshot.hasData) {
							return string(snapshot.data,
									width: width, height: height, hashCode: hashCode);
						} else if (snapshot.hasError) {
							return Container(
								width: width,
								height: width,
							);
						} else {
							return Container(
								width: width,
								height: width,
							);
						}
					});
		}

		return SvgPicture.asset(assetName,
				width: width,
				height: height,
				fit: fit,
				color: color,
				package: 'scheme_icons',
				semanticsLabel: semanticsLabel);
	}
}