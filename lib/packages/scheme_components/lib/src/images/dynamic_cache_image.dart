import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

class DynamicCachingImage extends StatelessWidget {
  ///The id is used to specify the path to which the image is cached.
  final String imageId;
  final String url;
  final double height;
  final double width;
  final BoxFit fit;
  final Duration cacheDuration;
  DynamicCachingImage({Key key, this.imageId, this.url, this.height, this.width, this.fit, this.cacheDuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FadeInImage(
        height: height ?? screenWidth,
        width: width ?? screenWidth,
        fadeInCurve: Curves.easeInOut,
        fit: fit ?? BoxFit.contain,

        image: _DynamicCachingImage(imageId: imageId, imageUrl: url), placeholder: AssetImage('assets/other/placeholder.png',package: 'scheme_components'),
      ),
    );
  }


  _imageBuilder(BuildContext context, ImageProvider provider) {
    return _DynamicCachingImage(imageId: imageId, imageUrl: url);
  }
}

/// Stores your in cache after the first download.
///
/// The value of [imageId] and [imageUrl] cannot be null.
class _DynamicCachingImage extends ImageProvider<_DynamicCachingImage> {
  _DynamicCachingImage({
    @required this.imageId,
    @required this.imageUrl,
    this.isCaching = true,
    this.scale = 1.0,
  });

  ///The id used to store the image file, is used in the path.
  final String imageId;

  ///The url used to download the first time.
  final String imageUrl;

  /// Enable or disable image caching
  final bool isCaching;

  /// Enable or disable image caching
  final double scale;

  Future<Codec> _getImage() async {
    try {
      File file = await this._findImage(this.imageId);
      if (file == null) {
        final dir = (await getTemporaryDirectory()).path;
        final request = await HttpClient().getUrl(Uri.parse(this.imageUrl));
        final response = await request.close();
        final bytes = await consolidateHttpClientResponseBytes(response);
        if (bytes.length > 0) {
          File("$dir/${this.imageId}").writeAsBytesSync(bytes);
          return PaintingBinding.instance.instantiateImageCodec(bytes);
        } else {
          return null;
        }
      } else {
        return PaintingBinding.instance.instantiateImageCodec(await file.readAsBytes());
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<File> _findImage(String imgKey) async {
    try {
      final dir = (await getTemporaryDirectory()).path;
      bool hasFile = await File("$dir/$imgKey").exists();
      if (hasFile) {
        return File("$dir/$imgKey");
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  ImageStreamCompleter load(_DynamicCachingImage key, decode) {
    return MultiFrameImageStreamCompleter(
        codec: key._getImage(),
        scale: key.scale,
        informationCollector: () sync* {
          yield DiagnosticsProperty<ImageProvider>('Image provider: $this \n Image key: $key', this,
              style: DiagnosticsTreeStyle.errorProperty);
        });
  }

  @override
  Future<_DynamicCachingImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_DynamicCachingImage>(this);
  }
}
