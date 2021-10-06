import 'package:flutter_modular/flutter_modular.dart';
import 'wallpaper_controller/wallpaper_controller.dart';
import 'wallpaper_controller/wallpaper_store.dart';
import 'wallpaper_view/home.dart';
import 'wallpaper_view/widgets/image.dart';

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
