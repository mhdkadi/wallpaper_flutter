import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../core/widgets/no_results.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../wallpaper_controller/wallpaper_store.dart';

Widget wallPaper(WallpapersStore store) {
  return Observer(builder: (context) {
    return store.wallpapers!.wallpapers.isEmpty
        ? const NoResults()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StaggeredGridView.count(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
              staggeredTiles: store.wallpapers!.wallpapers.map((item) {
                return const StaggeredTile.fit(2);
              }).toList(),
              children: store.wallpapers!.wallpapers.map((item) {
                return InkWell(
                  onTap: () {
                    Modular.to.pushNamed('/imageScreen', arguments: item);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: item.urls["small"],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: item.urls["small"],
                              placeholder: (context, url) => const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20, top: 20),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'description'.tr(),
                          style: const TextStyle(
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "${item.description}",
                            style: TextStyle(
                                color: Theme.of(context).shadowColor,
                                fontFamily: 'Overpass',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'photographer'.tr(),
                          style: const TextStyle(
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${item.photographer}",
                          style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  });
}
