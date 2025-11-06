import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/src/core/theme/app_images.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      memCacheWidth: 150,
      memCacheHeight: 150,
      fit: fit,
      errorWidget: (context, error, stackTrace) {
        return SizedBox(
          child: Image.asset(AppImages.pokebola, fit: BoxFit.scaleDown),
        );
      },
    );
  }
}
