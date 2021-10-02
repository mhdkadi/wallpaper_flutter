// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
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
    Categorie(categorieName: 'All', isSellected: true),
    Categorie(categorieName: 'Citys', isSellected: false),
    Categorie(categorieName: 'Wild Life', isSellected: false),
    Categorie(categorieName: 'Motivation', isSellected: false),
    Categorie(categorieName: 'Nature', isSellected: false),
    Categorie(categorieName: 'Cars', isSellected: false),
    Categorie(categorieName: 'Programming', isSellected: false),
    Categorie(categorieName: 'Bikes', isSellected: false),
    Categorie(categorieName: 'cats', isSellected: false),
    Categorie(categorieName: 'love', isSellected: false),
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
