import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../wallpaper_model/wallpaper_model.dart';

class Image extends StatelessWidget {
  final _store = Modular.get<WallpapersStore>();
  final Wallpaper wallpaper;
  Image({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);
  SnackBar _snackBar(Widget content) {
    return SnackBar(
      content: content,
    );
  }

  void download(BuildContext context) {
    _store
        .downloadPhote(
      imageId: wallpaper.wallpaperId,
      url: wallpaper.downloadLink,
    )
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_snackBar(Text('photo_downloaded'.tr())));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_snackBar(Text('photo_download_error'.tr())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blue,
        spacing: 5,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(
                Icons.download,
              ),
              onTap: () {
                download(context);
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
      body: Center(
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
    );
  }
}
