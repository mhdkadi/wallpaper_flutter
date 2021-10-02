import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../wallpaper_model/wallpaper_model.dart';

class Image extends StatelessWidget {
  final Wallpaper wallpaper;
  const Image({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: wallpaper.urls['small'],
      child: FittedBox(
        child: SizedBox(
          child: CachedNetworkImage(
            imageUrl: wallpaper.urls['small'],
            placeholder: (context, url) => Container(
              color: const Color(0xfff5f8fd), ////
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
