import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:meta/meta.dart'; 

import 'color_conversion.dart';
import 'pigment.dart';  

class PicasoColorizer {
	Color originalColor;
	Color _color;

	PicasoColorizer(Color color) {
		this.originalColor =
				Color.fromARGB(color.alpha, color.red, color.green, color.blue);
		this._color =
				Color.fromARGB(color.alpha, color.red, color.green, color.blue);
	}

	factory PicasoColorizer.fromRGB(
			{@required int r, @required int g, @required int b, int a = 100}) {
		return PicasoColorizer(Color.fromARGB(a, r, g, b));
	}

	factory PicasoColorizer.fromHSL(HslColor hsl) {
		return PicasoColorizer(hslToColor(hsl));
	}

	factory PicasoColorizer.fromHSV(HSVColor hsv) {
		return PicasoColorizer(hsv.toColor());
	}

	factory PicasoColorizer.fromString(String string) {
		return PicasoColorizer(PicasoInternal.fromString(string));
	}

	Color get complimentary => complement().color;

	bool isDarkerThan(Color anotherColor) {
		PicasoColorizer(_color);
		return PicasoColorizer(_color).getBrightness() <
				PicasoColorizer(anotherColor).getBrightness();
	}

	bool get colorIsBlack  => _color.blue == 0 && _color.red == 0 && _color.green == 0;

	bool isDark() {
		return this.getBrightness() < 128.0;
	}

	bool isLight() {
		return !this.isDark();
	}

	double getBrightness() {
		return (_color.red * 299 + _color.green * 587 + _color.blue * 114) / 1000;
	}

	double getLuminance() {
		return _color.computeLuminance();
	}

	PicasoColorizer setAlpha(int alpha) {
		_color.withAlpha(alpha);
		return this;
	}

	PicasoColorizer setOpacity(double opacity) {
		_color.withOpacity(opacity);
		return this;
	}

	HSVColor toHsv() {
		return colorToHsv(_color);
	}

	HslColor toHsl() {
		final hsl = rgbToHsl(
			r: _color.red.toDouble(),
			g: _color.green.toDouble(),
			b: _color.blue.toDouble(),
		);
		return HslColor(
				h: hsl.h * 360, s: hsl.s, l: hsl.l, a: _color.alpha.toDouble());
	}

	PicasoColorizer clone() {
		return PicasoColorizer(_color);
	}

	PicasoColorizer lighten([int amount = 10]) {
		final hsl = this.toHsl();
		hsl.l += amount / 100;
		hsl.l = clamp01(hsl.l);
		return PicasoColorizer.fromHSL(hsl);
	}

	PicasoColorizer brighten([int amount = 10]) {
		final color = Color.fromARGB(
			_color.alpha,
			Math.max(0, Math.min(255, _color.red - (255 * -(amount / 100)).round())),
			Math.max(
					0, Math.min(255, _color.green - (255 * -(amount / 100)).round())),
			Math.max(0, Math.min(255, _color.blue - (255 * -(amount / 100)).round())),
		);
		return PicasoColorizer(color);
	}

	PicasoColorizer darken([int amount = 10]) {
		final hsl = this.toHsl();
		hsl.l -= amount / 100;
		hsl.l = clamp01(hsl.l);
		return PicasoColorizer.fromHSL(hsl);
	}

	PicasoColorizer tint([int amount = 10]) {
		return this.mix(input: Color.fromRGBO(255, 255, 255, 1.0));
	}

	PicasoColorizer shade([int amount = 10]) {
		return this.mix(input: Color.fromRGBO(0, 0, 0, 1.0));
	}

	PicasoColorizer desaturate([int amount = 10]) {
		final hsl = this.toHsl();
		hsl.s -= amount / 100;
		hsl.s = clamp01(hsl.s);
		return PicasoColorizer.fromHSL(hsl);
	}

	PicasoColorizer saturate([int amount = 10]) {
		final hsl = this.toHsl();
		hsl.s += amount / 100;
		hsl.s = clamp01(hsl.s);
		return PicasoColorizer.fromHSL(hsl);
	}

	PicasoColorizer greyscale() {
		return desaturate(100);
	}

	PicasoColorizer spin(double amount) {
		final hsl = this.toHsl();
		final hue = (hsl.h + amount) % 360;
		hsl.h = hue < 0 ? 360 + hue : hue;
		return PicasoColorizer.fromHSL(hsl);
	}

	PicasoColorizer mix({@required Color input, int amount = 50}) {
		final int p = (amount / 100).round();
		final color = Color.fromARGB(
				(input.alpha - _color.alpha) * p + _color.alpha,
				(input.red - _color.red) * p + _color.red,
				(input.green - _color.green) * p + _color.green,
				(input.blue - _color.blue) * p + _color.blue);
		return PicasoColorizer(color);
	}

	PicasoColorizer complement() {
		final hsl = this.toHsl();
		hsl.h = (hsl.h + 180) % 360;
		return PicasoColorizer.fromHSL(hsl);
	}


	Color get color {
		return _color;
	}
}