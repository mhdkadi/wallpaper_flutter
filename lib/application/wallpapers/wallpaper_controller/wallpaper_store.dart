// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../wallpaper_model/categorie_model.dart';
import 'package:mobx/mobx.dart';

import '../wallpaper_model/wallpaper_model.dart';
import 'wallpaper_controller.dart';

part 'wallpaper_store.g.dart';

class WallpapersStore extends _WallpapersStore with _$WallpapersStore {
  WallpapersStore(WallpaperController weatherRepository)
      : super(weatherRepository);
}

enum StoreState { initial, loading, loaded }

abstract class _WallpapersStore with Store {
  _WallpapersStore(this._wallpaperController);
  final WallpaperController _wallpaperController;
  @observable
  Wallpapers? wallpapers;

  @observable
  List<Categorie> categorieList = [
    Categorie(categorieName: 'categories.all'.tr(), isSellected: true),
    Categorie(categorieName: 'categories.citys'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.wild_life'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.motivation'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.nature'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.cars'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.programming'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.bikes'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.cats'.tr(), isSellected: false),
    Categorie(categorieName: 'categories.love'.tr(), isSellected: false),
  ];

  @observable
  ObservableFuture<Wallpapers>? _wallpapersFuture;

  @computed
  StoreState get state {
    if (_wallpapersFuture == null ||
        _wallpapersFuture!.status == FutureStatus.rejected) {
      return StoreState.initial;
    } else if (_wallpapersFuture!.status == FutureStatus.pending) {
      return StoreState.loading;
    } else {
      return StoreState.loaded;
    }
  }

  @action
  Future<void> getWallpaper({required int page}) async {
    try {
      _wallpapersFuture =
          ObservableFuture(_wallpaperController.getPhotos(page: page));
      wallpapers = await _wallpapersFuture;
    } on DioError {
      print('DioError');
    }
  }

  @action
  void sellectCategorie(int index) {
    List<Categorie> categorieList2 = categorieList;
    for (int i = 0; i < categorieList.length; i++) {
      categorieList2[i] = Categorie(
          categorieName: categorieList[i].categorieName, isSellected: false);
    }
    categorieList2[index].isSellected = true;
    categorieList = categorieList2;
  }

  @action
  Future<void> loadMoreWallpaper({required int page}) async {
    try {
      Wallpapers newWallpapers = wallpapers!;
      Wallpapers? morewallpapers =
          await _wallpaperController.getPhotos(page: page);
      newWallpapers.wallpapersList =
          wallpapers!.wallpapersList + morewallpapers.wallpapersList;
      wallpapers = newWallpapers;
    } on DioError {
      print('DioError');
    }
  }

  @action
  Future<void> searshWallpaper({required String searshQuery}) async {
    try {
      if (searshQuery.isNotEmpty && searshQuery != 'All') {
        _wallpapersFuture = ObservableFuture(_wallpaperController.searshPhotos(
            page: 1, searshQuery: searshQuery));
        wallpapers = await _wallpapersFuture;
      } else {
        getWallpaper(page: 0);
      }
    } on DioError {
      print('DioError');
    }
  }
}
