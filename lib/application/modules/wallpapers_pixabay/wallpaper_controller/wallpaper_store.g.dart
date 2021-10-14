// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WallpapersStore on _WallpapersStore, Store {
  Computed<StoreState?>? _$storStateComputed;

  @override
  StoreState? get storState =>
      (_$storStateComputed ??= Computed<StoreState?>(() => super.storState,
              name: '_WallpapersStore.storState'))
          .value;

  final _$wallpapersAtom = Atom(name: '_WallpapersStore.wallpapers');

  @override
  Either<Failure, Wallpapers>? get wallpapers {
    _$wallpapersAtom.reportRead();
    return super.wallpapers;
  }

  @override
  set wallpapers(Either<Failure, Wallpapers>? value) {
    _$wallpapersAtom.reportWrite(value, super.wallpapers, () {
      super.wallpapers = value;
    });
  }

  final _$_stateAtom = Atom(name: '_WallpapersStore._state');

  @override
  StoreState? get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(StoreState? value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
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

  final _$loadMoreWallpaperAsyncAction =
      AsyncAction('_WallpapersStore.loadMoreWallpaper');

  @override
  Future<void> loadMoreWallpaper({required int page}) {
    return _$loadMoreWallpaperAsyncAction
        .run(() => super.loadMoreWallpaper(page: page));
  }

  final _$searshWallpaperAsyncAction =
      AsyncAction('_WallpapersStore.searshWallpaper');

  @override
  Future<void> searshWallpaper({required String searshQuery}) {
    return _$searshWallpaperAsyncAction
        .run(() => super.searshWallpaper(searshQuery: searshQuery));
  }

  final _$downloadPhoteAsyncAction =
      AsyncAction('_WallpapersStore.downloadPhote');

  @override
  Future<dynamic> downloadPhote(
      {required String imageId, required String url}) {
    return _$downloadPhoteAsyncAction
        .run(() => super.downloadPhote(imageId: imageId, url: url));
  }

  final _$getWallpaperAsyncAction =
      AsyncAction('_WallpapersStore.getWallpaper');

  @override
  Future<void> getWallpaper({required int page}) {
    return _$getWallpaperAsyncAction.run(() => super.getWallpaper(page: page));
  }

  final _$_WallpapersStoreActionController =
      ActionController(name: '_WallpapersStore');

  @override
  void sellectCategorie(int index) {
    final _$actionInfo = _$_WallpapersStoreActionController.startAction(
        name: '_WallpapersStore.sellectCategorie');
    try {
      return super.sellectCategorie(index);
    } finally {
      _$_WallpapersStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setWllpapers(Either<Failure, Wallpapers> _wallpapers) {
    final _$actionInfo = _$_WallpapersStoreActionController.startAction(
        name: '_WallpapersStore._setWllpapers');
    try {
      return super._setWllpapers(_wallpapers);
    } finally {
      _$_WallpapersStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setState(StoreState state) {
    final _$actionInfo = _$_WallpapersStoreActionController.startAction(
        name: '_WallpapersStore._setState');
    try {
      return super._setState(state);
    } finally {
      _$_WallpapersStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
wallpapers: ${wallpapers},
categorieList: ${categorieList},
storState: ${storState}
    ''';
  }
}
