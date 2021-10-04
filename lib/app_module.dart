import 'package:flutter_modular/flutter_modular.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'application/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'application/wallpapers/wallpaper_model/wallpaper_api_services.dart';

import 'application/wallpapers/wallpaper_view/home.dart';
import 'application/wallpapers/wallpaper_view/widgets/image.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ApiServices()),
        Bind.factory((i) => WallpaperController(apiServices: i())),
        Bind.lazySingleton((i) => WallpapersStore(i()))
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
