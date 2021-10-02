import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/wallpapers/wallpaper_controller/wallpaper_store.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No Internet Connection'),
        Consumer<WallpapersStore>(builder: (_, store, __) {
          return ElevatedButton(
            onPressed: () => store.getWallpaper(page: 0),
            child: const Text('Try again'),
          );
        }),
      ],
    );
  }
}
