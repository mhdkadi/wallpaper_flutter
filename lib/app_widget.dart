import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => WallpapersStore(WallpaperController()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallpaper App',
        theme: ThemeData(primarySwatch: Colors.blue),
      ).modular(),
    );
  }
}
