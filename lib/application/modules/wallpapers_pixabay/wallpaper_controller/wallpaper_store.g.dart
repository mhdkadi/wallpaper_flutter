// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WallpapersStore on _WallpapersStore, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_WallpapersStore.state'))
          .value;

  final _$wallpapersAtom = Atom(name: '_WallpapersStore.wallpapers');

  @override
  Wallpapers? get wallpapers {
    _$wallpapersAtom.reportRead();
    return super.wallpapers;
  }

  @override
  set wallpapers(Wallpapers? value) {
    _$wallpapersAtom.reportWrite(value, super.wallpapers, () {
      super.wallpapers = value;
    });
  }

  final _$_wallpaperFutureAtom =
      Atom(name: '_WallpapersStore._wallpaperFuture');

  @override
  ObservableFuture<dynamic>? get _wallpaperFuture {
    _$_wallpaperFutureAtom.reportRead();
    return super._wallpaperFuture;
  }

  @override
  set _wallpaperFuture(ObservableFuture<dynamic>? value) {
    _$_wallpaperFutureAtom.reportWrite(value, super._wallpaperFuture, () {
      super._wallpaperFuture = value;
    });
  }

  final _$_colorAtom = Atom(name: '_WallpapersStore._color');

  @override
  String get _color {
    _$_colorAtom.reportRead();
    return super._color;
  }

  @override
  set _color(String value) {
    _$_colorAtom.reportWrite(value, super._color, () {
      super._color = value;
    });
  }

  final _$_searshQueryAtom = Atom(name: '_WallpapersStore._searshQuery');

  @override
  String get _searshQuery {
    _$_searshQueryAtom.reportRead();
    return super._searshQuery;
  }

  @override
  set _searshQuery(String value) {
    _$_searshQueryAtom.reportWrite(value, super._searshQuery, () {
      super._searshQuery = value;
    });
  }

  final _$_categoryAtom = Atom(name: '_WallpapersStore._category');

  @override
  String get _category {
    _$_categoryAtom.reportRead();
    return super._category;
  }

  @override
  set _category(String value) {
    _$_categoryAtom.reportWrite(value, super._category, () {
      super._category = value;
    });
  }

  final _$_orderAtom = Atom(name: '_WallpapersStore._order');

  @override
  String get _order {
    _$_orderAtom.reportRead();
    return super._order;
  }

  @override
  set _order(String value) {
    _$_orderAtom.reportWrite(value, super._order, () {
      super._order = value;
    });
  }

  final _$_imagetypeAtom = Atom(name: '_WallpapersStore._imagetype');

  @override
  String get _imagetype {
    _$_imagetypeAtom.reportRead();
    return super._imagetype;
  }

  @override
  set _imagetype(String value) {
    _$_imagetypeAtom.reportWrite(value, super._imagetype, () {
      super._imagetype = value;
    });
  }

  final _$_pageAtom = Atom(name: '_WallpapersStore._page');

  @override
  int get _page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  final _$categorieListAtom = Atom(name: '_WallpapersStore.categorieList');

  @override
  ObservableList<dynamic> get categorieList {
    _$categorieListAtom.reportRead();
    return super.categorieList;
  }

  @override
  set categorieList(ObservableList<dynamic> value) {
    _$categorieListAtom.reportWrite(value, super.categorieList, () {
      super.categorieList = value;
    });
  }

  final _$getWallpaperAsyncAction =
      AsyncAction('_WallpapersStore.getWallpaper');

  @override
  Future<void> getWallpaper() {
    return _$getWallpaperAsyncAction.run(() => super.getWallpaper());
  }

  final _$_WallpapersStoreActionController =
      ActionController(name: '_WallpapersStore');

  @override
  void sellectTab(int index) {
    final _$actionInfo = _$_WallpapersStoreActionController.startAction(
        name: '_WallpapersStore.sellectTab');
    try {
      return super.sellectTab(index);
    } finally {
      _$_WallpapersStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchText(String search) {
    final _$actionInfo = _$_WallpapersStoreActionController.startAction(
        name: '_WallpapersStore.searchText');
    try {
      return super.searchText(search);
    } finally {
      _$_WallpapersStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
wallpapers: ${wallpapers},
categorieList: ${categorieList},
state: ${state}
    ''';
  }
}
