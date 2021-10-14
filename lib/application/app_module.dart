import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/api_services/api_services.dart';
import 'modules/wallpapers_pixabay/wallpaper_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ApiServices(dio: Dio())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: WallpaperModule()),
      ];
}
