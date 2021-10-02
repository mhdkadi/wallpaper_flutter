import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/core/consts/thme.dart';
import 'package:provider/provider.dart';

import 'application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => WallpapersStore(WallpaperController()),
      child: AdaptiveTheme(
          light: lightTheme(),
          dark: darkTheme(),
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Wallpaper App',
              theme: theme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.system,
            ).modular();
          }),
    );
  }
}
