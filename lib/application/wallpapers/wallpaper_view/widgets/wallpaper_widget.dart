import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../wallpaper_model/wallpaper_model.dart';

Widget wallPaper(Wallpapers? wallpapers) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: StaggeredGridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 6.0,
      mainAxisSpacing: 6.0,
      staggeredTiles: wallpapers!.wallpapers.map((item) {
        return const StaggeredTile.fit(2);
      }).toList(),
      children: wallpapers.wallpapers.map((item) {
        return InkWell(
          onTap: () {
            Modular.to.navigate('/iamge', arguments: item);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const RadialGradient(
                    center: Alignment.bottomRight,
                    radius: 0.5,
                    colors: [Color(0xfff5f8fd), Color(0xfff5f8fd)])),
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
                const Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Overpass',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "${item.description}",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Overpass',
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "photographer",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Overpass',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Text(
                  "${item.photographer}",
                  style: const TextStyle(
                      color: Colors.black54,
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
}
