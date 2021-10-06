import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../application/modules/wallpapers/wallpaper_controller/wallpaper_store.dart';
import 'package:provider/provider.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('no_internet'.tr()),
        Consumer<WallpapersStore>(builder: (_, store, __) {
          return ElevatedButton(
            onPressed: () => store.getWallpaper(page: 0),
            child: Text('try_again'.tr()),
          );
        }),
      ],
    );
  }
}
