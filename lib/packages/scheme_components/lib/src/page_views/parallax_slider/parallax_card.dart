import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/cards/controller/scheme_card_controller.dart';
import 'package:scheme_components/src/constants/constants.dart';
import 'package:scheme_components/src/page_views/parallax_slider/model/layared_image_model.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../../../scheme_components.dart';

enum BannerType { single, layered }

class ParallaxCard extends StatelessWidget {

	final Function onTap;
	final double offset;
	final BannerType bannerType;
	final Color cardColor;
	final double cardWidth;
	final double cardHeight;
	final LayeredImage image;

	ParallaxCard(
			{Key key,
				 this.onTap,
				this.bannerType = BannerType.single,
				this.offset, this.cardColor = Colors.white, this.cardWidth, this.cardHeight,@required this.image})
			: super(key: key);
	final double _maxRotation = 20;



	@override
	Widget build(BuildContext context) {
		switch (bannerType) {
			case BannerType.single:
				return parallaxCard;
			default:
				return parallaxCard;
		}
	}


	get parallaxCard => GetBuilder(
		init: CardController(),
		initState: (_) => CardController.to.generatePalette(cardHeight,asset: image.backLayer),
		builder: (s) => Rotation3d(
			rotationY: offset * _maxRotation,
			child: ClipRRect(borderRadius: cardRadius,
			  child: Container(
			  	width: cardWidth,
			  	padding: EdgeInsets.only(left: 8,right: 8),
			  	child: Stack(
			  		alignment: Alignment.center,
			  		children: <Widget>[
			  			// Card background color & decoration
			  			Container(
			  				height: cardHeight,
			  				decoration: BoxDecoration(
			  					color: image.cardColor != null ? image.cardColor : CardController.to.palette != null ? CardController.to.palette.lightMutedColor.color : Colors.white,
			  					borderRadius: cardRadius,
			  					boxShadow: [
			  						BoxShadow(color: Colors.black12, blurRadius: 4 * offset.abs()),
			  						BoxShadow(color: Colors.black12, blurRadius: 10 + 6 * offset.abs()),
			  					],
			  				),
			  			),
			  			// City image, out of card by 15px
			  			Positioned(bottom: 0, child: _buildImage()),
			  			// City information

			  		],
			  	),
			  ),
			),
		)
	);

	Widget _buildImage() {
		double maxParallax = 30;
		double globalOffset = offset * maxParallax * 2;
		double cardPadding = 28;
		double containerWidth = cardWidth - cardPadding;
		return Container(
			height: cardHeight,
			width: containerWidth,
			child: ClipRRect(borderRadius: cardRadius,
			  child: Stack(
			  	alignment: Alignment.bottomCenter,
			  	children: <Widget>[
			  		_buildPositionedLayer(image.backLayer, containerWidth * .8, maxParallax * .1, globalOffset),
			  		_buildPositionedLayer(image.middleLayer, containerWidth * .9, maxParallax * .6, globalOffset),
			  		_buildPositionedLayer(image.frontLayer, containerWidth * .9, maxParallax, globalOffset),
			  	],
			  ),
			),
		);
	}



	Widget _buildPositionedLayer(String path, double width, double maxOffset, double globalOffset) {
		double cardPadding =  48.0;
		double layerWidth = cardWidth - cardPadding;
		return Positioned(
				left: ((layerWidth * .5) - (width / 2) - offset * maxOffset) + globalOffset,
				bottom: 0,
				child: Image.asset(
					path,
					width: width,
					package: 'scheme_components',
				));
	}



}

