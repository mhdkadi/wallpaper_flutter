import 'package:flutter_modular/flutter_modular.dart';

import 'application/wallpapers/wallpaper_view/home.dart';
import 'application/wallpapers/wallpaper_view/widgets/image.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

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
