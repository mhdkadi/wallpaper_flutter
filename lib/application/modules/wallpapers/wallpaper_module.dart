import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/modules/wallpapers/wallpaper_controller/wallpaper_controller.dart';
import 'package:flutter_modular_mobx/application/modules/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'package:flutter_modular_mobx/application/modules/wallpapers/wallpaper_view/home.dart';
import 'package:flutter_modular_mobx/application/modules/wallpapers/wallpaper_view/widgets/image.dart';

class WallpaperModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => WallpaperController(apiServices: i())),
        Bind.lazySingleton((i) => WallpapersStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/imageScreen',
            child: (context, args) => Image(wallpaper: args.data)),
      ];
}