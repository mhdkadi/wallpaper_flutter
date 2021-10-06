import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/modules/wallpapers/wallpaper_module.dart';
import '../core/api_services/api_services.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ApiServices(dio: Dio())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: WallpaperModule()),
      ];
}
