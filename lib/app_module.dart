import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_model/wallpaper_api_services.dart';

import 'application/wallpapers/wallpaper_view/home.dart';
import 'application/wallpapers/wallpaper_view/widgets/image.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ApiServices()),
        Bind.lazySingleton((i) => WallpaperController(apiServices: i())),
        Bind.singleton((i) => WallpapersStore(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
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
