import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/core/wrapper/wrapper.dart';
import 'application/authentication/auth_controller/auth_controller.dart';
import 'application/authentication/auth_controller/auth_store.dart';
import 'application/wallpapers/wallpaper_view/home.dart';

import 'application/authentication/auth_view/authentication_view.dart';

import 'application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'core/api_services/api_services.dart';

import 'application/wallpapers/wallpaper_view/widgets/image.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ApiServices(dio: Dio())),
        Bind.factory((i) => AuthController(client: i())),
        Bind.factory((i) => WallpaperController(apiServices: i())),
        Bind.lazySingleton((i) => WallpapersStore(i())),
        Bind.lazySingleton((i) => AuthStore(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/authenticationView',
          child: (context, args) => const AuthenticationView(),
        ),
        ChildRoute(
          '/',
          child: (context, args) => const Wrapper(),
        ),
        ChildRoute(
          '/homeScreen',
          child: (context, args) => const HomePage(),
        ),
        ChildRoute(
          '/imageScreen',
          child: (context, args) => Image(
            wallpaper: args.data,
          ),
        ),
      ];
}
