// ignore_for_file: avoid_print

import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  _WallpapersStore(this._wallpaperController);
  final WallpaperController _wallpaperController;
  @observable
  Wallpapers? wallpapers;

  @observable
  ObservableFuture? _wallpaperFuture;

  @observable
  String _color = '';
  @observable
  String _searshQuery = '';
  @observable
  String _category = '';
  @observable
  String _order = 'popular';
  @observable
  String _imagetype = 'photo';
  @observable
  int _page = 1;

  @observable
  ObservableList categorieList = ObservableList<TabModle>.of([
    TabModle(categorieName: 'popular', isSellected: true),
    TabModle(categorieName: 'latest', isSellected: false),
    TabModle(categorieName: 'photo', isSellected: false),
    TabModle(categorieName: 'illustration', isSellected: false),
    TabModle(categorieName: 'vector', isSellected: false),
    TabModle(categorieName: 'colors', isSellected: false),
    TabModle(categorieName: 'category', isSellected: false),
  ]);

  @action
  void sellectTab(int index) {
    for (int i = 0; i < categorieList.length; i++) {
      categorieList[i] = TabModle(
        categorieName: categorieList[i].categorieName,
        isSellected: false,
      );
    }
    switch (index) {
      case 0:
        _order = 'popular';
        _imagetype = 'photo';
        _page = 1;

        break;
      case 1:
        _order = 'latest';
        _imagetype = 'photo';
        _page = 1;

        break;
      case 2:
        _order = 'popular';
        _imagetype = 'photo';
        _page = 1;
        break;
      case 3:
        _order = 'popular';
        _imagetype = 'illustration';
        _page = 1;
        break;
      case 4:
        _order = 'popular';
        _imagetype = 'vector';
        _page = 1;
        break;
      case 5:
        _order = 'popular';
        _imagetype = 'photo';
        _searshQuery = '';
        _page = 1;
        break;
      case 6:
        _order = 'popular';
        _imagetype = 'photo';
        _searshQuery = '';
        _page = 1;
    }
    categorieList[index].isSellected = true;
    getWallpaper();
  }

  void onRefresh() async {
    await getWallpaper()
        .onError((_, __) => refreshController.refreshCompleted());

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // await store
    //     .loadMoreWallpaper(page: pageIndex)
    //     .then((_) => pageIndex++)
    //     .onError((_, __) {
    //   _refreshController.loadComplete();
    //   return 0;
    // });
    refreshController.loadComplete();
  }

  @action
  Future<void> getWallpaper() async {
    _wallpaperFuture = ObservableFuture(_wallpaperController.getPhotos(
      searshQuery: _searshQuery,
      imagetype: _imagetype,
      order: _order,
      page: _page,
    ));
    wallpapers = await _wallpaperFuture;
  }

  @action
  void searchText(String search) => _searshQuery = search;

  @computed
  StoreState get state {
    if (_wallpaperFuture == null ||
        _wallpaperFuture!.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _wallpaperFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }
}
