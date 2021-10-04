import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'application/wallpapers/wallpaper_model/wallpaper_api_services.dart';
import 'core/consts/thme.dart';
import 'package:provider/provider.dart';

import 'application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) =>
          WallpapersStore(WallpaperController(apiServices: ApiServices())),
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
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            ).modular();
          }),
    );
  }
}
