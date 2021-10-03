import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_model/wallpaper_api_services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../wallpaper_model/wallpaper_model.dart';

class Image extends StatelessWidget {
  final _store = Modular.get<WallpapersStore>();
  final Wallpaper wallpaper;
  Image({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        spacing: 5,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(
                Icons.download,
              ),
              onTap: () {
                _store
                    .downloadPhote(
                  imageId: wallpaper.wallpaperId,
                  url: wallpaper.downloadLink,
                )
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('photo_downloaded'.tr()),
                    ),
                  );
                });
              }),
          SpeedDialChild(
              child: const Icon(
                Icons.share,
              ),
              onTap: () {}),
          SpeedDialChild(
            child: const Icon(
              Icons.wallpaper,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: wallpaper.urls['small'],
              child: FittedBox(
                child: SizedBox(
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.urls['small'],
                    placeholder: (context, url) => Container(
                      color: const Color(0xfff5f8fd),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Column(),
          ),
        ],
      ),
    );
  }
}
