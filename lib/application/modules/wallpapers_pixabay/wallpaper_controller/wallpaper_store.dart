// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_modular_mobx/core/api_services/api_services.dart';
import 'package:mobx/mobx.dart';

import '../wallpaper_model/categorie_model.dart';
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
  Either<Failure, Wallpapers>? wallpapers;

  @observable
  StoreState? _state;

  @observable
  ObservableList categorieList = ObservableList<Categorie>.of([
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
  ]);

  @action
  void sellectCategorie(int index) {
    for (int i = 0; i < categorieList.length; i++) {
      categorieList[i] = Categorie(
          categorieName: categorieList[i].categorieName, isSellected: false);
    }
    categorieList[index].isSellected = true;
  }

  @action
  Future<void> loadMoreWallpaper({required int page}) async {
    try {
      Either<Failure, Wallpapers>? tempMore;
      await Task(() => _wallpaperController.getPhotos(page: page))
          .attempt()
          .map((either) => either.leftMap((obj) => obj as Failure))
          .run()
          .then((value) {
        tempMore = value;
      });
      Wallpapers? temp = wallpapers!.toOption().toNullable()!;
      Wallpapers temp1 = wallpapers!.toOption().toNullable()!;
      Wallpapers temp2 = tempMore!.toOption().toNullable()!;

      temp.wallpapersList = temp1.wallpapersList + temp2.wallpapersList;
      wallpapers = Right(temp);
    } on DioError {
      print('DioError');
    }
  }

  @action
  Future<void> searshWallpaper({required String searshQuery}) async {
    try {
      if (searshQuery.isNotEmpty && searshQuery != 'All') {
        _setState(StoreState.loading);
        await Task(() => _wallpaperController.searshPhotos(
                  page: 1,
                  searshQuery: searshQuery,
                ))
            .attempt()
            .map((either) => either.leftMap((obj) => obj as Failure))
            .run()
            .then((value) => _setWllpapers(value));
        _setState(StoreState.loaded);
      } else {
        getWallpaper(page: 0);
      }
    } on DioError {
      print('DioError');
    }
  }

  @action
  Future downloadPhote({
    required String imageId,
    required String url,
  }) async {
    await _wallpaperController.downloadPhoto(imageId: imageId, url: url);
  }

  @action
  Future<void> getWallpaper({required int page}) async {
    _setState(StoreState.loading);
    await Task(() => _wallpaperController.getPhotos(page: page))
        .attempt()
        .map((either) => either.leftMap((obj) => obj as Failure))
        .run()
        .then((value) => _setWllpapers(value));

    _setState(StoreState.loaded);
  }

  @action
  void _setWllpapers(Either<Failure, Wallpapers> _wallpapers) =>
      wallpapers = _wallpapers;

  @action
  void _setState(StoreState state) {
    _state = state;
  }

  @computed
  StoreState? get storState => _state;
}
