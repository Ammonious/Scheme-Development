import 'package:flutter/material.dart';
import 'package:scheme_components/src/page_views/carousel_slider/carousel_slider.dart';
import 'package:scheme_components/src/page_views/parallax_slider/model/layared_image_model.dart';
import 'package:scheme_components/src/page_views/parallax_slider/parallax_card.dart';
import 'package:scheme_theme/scheme_theme.dart';

class ParallaxSlider extends StatefulWidget {
  final List<LayeredImage> items;
  final double itemWidth;
  final double itemHeight;
  final Function(int index) onTap;
  const ParallaxSlider({
    Key key,
    this.items, this.onTap, this.itemWidth, this.itemHeight,
  }) : super(key: key);

  @override
  ParallaxSliderState createState() => ParallaxSliderState();
}

class ParallaxSliderState extends State<ParallaxSlider>
    with SingleTickerProviderStateMixin {
  final double _maxRotation = 20;

  double get itemWidth   => widget.itemWidth ?? screenWidth;
  double get itemHeight   => widget.itemHeight ?? 250;
  List<LayeredImage> get items => widget.items ?? List();
  Function(int index) get onTap => widget.onTap;



  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  //int _focusedIndex = 0;

  AnimationController _tweenController;
  Tween<double> _tween;
  Animation<double> _tweenAnim;

  @override
  Widget build(BuildContext context) {
    Widget listContent = Container(
      child: CarouselSlider.builder(
	      itemCount: items.length,
        options: CarouselOptions(
          viewportFraction: 0.85,
          aspectRatio: 16 / 9,
        ),
        itemBuilder: (context, index) => ParallaxCard(
          image: items[index],
          offset: _normalizedOffset,
	        cardWidth: itemWidth,
	        cardHeight: itemHeight,
	        onTap: () => onTap(index),
        ),
      ),
    );

    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }

  

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController.stop();
      }
    }
    return true;
  }

  void _handleAutoScroll() {
    Future.delayed(Duration(milliseconds: 350), () => _startOffsetTweenToZero());
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) {
    setState(() {
      _normalizedOffset = value;
    });
  }

  //Tweens our offset from the current value, to 0
  void _startOffsetTweenToZero() {
    //The first time this runs, setup our controller, tween and animation. All 3 are required to control an active animation.
    int tweenTime = 1000;
    if (_tweenController == null) {
      //Create Controller, which starts/stops the tween, and rebuilds this widget while it's running
      _tweenController =
          AnimationController(vsync: this, duration: Duration(milliseconds: tweenTime));
      //Create Tween, which defines our begin + end values
      _tween = Tween<double>(begin: -1, end: 0);
      //Create Animation, which allows us to access the current tween value and the onUpdate() callback.
      _tweenAnim =
          _tween.animate(new CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut))
            //Set our offset each time the tween fires, triggering a rebuild
            ..addListener(() {
              _setOffset(_tweenAnim.value);
            });
    }
    //Restart the tweenController and inject a new start value into the tween
    _tween.begin = _normalizedOffset;
    _tweenController.reset();
    _tween.end = 0;
    _tweenController.forward();
  }
}
