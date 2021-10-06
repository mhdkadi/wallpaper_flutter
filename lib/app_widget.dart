import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'application/authentication/auth_controller/auth_controller.dart';
import 'application/authentication/auth_controller/auth_store.dart';
import 'core/api_services/api_services.dart';
import 'core/consts/thme.dart';
import 'package:provider/provider.dart';

import 'application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => WallpapersStore(
              WallpaperController(apiServices: ApiServices(dio: Dio()))),
        ),
        Provider(
          create: (_) =>
              AuthStore(AuthController(client: ApiServices(dio: Dio()))),
        )
      ],
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
