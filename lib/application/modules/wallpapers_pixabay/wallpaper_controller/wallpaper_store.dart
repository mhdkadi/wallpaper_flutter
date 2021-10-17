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
    _page = 1;
    _order = 'popular';
    _imagetype = 'photo';
    switch (index) {
      case 1:
        _order = 'latest';
        break;
      case 3:
        _imagetype = 'illustration';
        break;
      case 4:
        _imagetype = 'vector';
        break;
      case 5:
        _searshQuery = '';
        break;
      case 6:
        _searshQuery = '';
    }
    categorieList[index].isSellected = true;
    if (index != 5 || index != 6) {
      getWallpaper();
    }
  }

  void onRefresh() async {
    _page = 1;
    await getWallpaper()
        .onError((_, __) => refreshController.refreshCompleted());

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    Wallpapers? tempMore;
    _page++;
    _wallpaperController
        .getPhotos(
      searshQuery: _searshQuery,
      imagetype: _imagetype,
      order: _order,
      page: _page,
    )
        .then((value) {
      tempMore = value;
      Wallpapers temp = wallpapers!;
      Wallpapers temp1 = wallpapers!;
      Wallpapers temp2 = tempMore!;
      temp.wallpapersList = temp1.wallpapersList + temp2.wallpapersList;
      wallpapers = temp;
      refreshController.loadComplete();
    }).onError((_, __) {
      refreshController.loadComplete();
    });
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
