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

  final _$categorieListAtom = Atom(name: '_WallpapersStore.categorieList');

  @override
  List<Categorie> get categorieList {
    _$categorieListAtom.reportRead();
    return super.categorieList;
  }

  @override
  set categorieList(List<Categorie> value) {
    _$categorieListAtom.reportWrite(value, super.categorieList, () {
      super.categorieList = value;
    });
  }

  final _$_wallpapersFutureAtom =
      Atom(name: '_WallpapersStore._wallpapersFuture');

  @override
  ObservableFuture<Wallpapers>? get _wallpapersFuture {
    _$_wallpapersFutureAtom.reportRead();
    return super._wallpapersFuture;
  }

  @override
  set _wallpapersFuture(ObservableFuture<Wallpapers>? value) {
    _$_wallpapersFutureAtom.reportWrite(value, super._wallpapersFuture, () {
      super._wallpapersFuture = value;
    });
  }

  final _$getWallpaperAsyncAction =
      AsyncAction('_WallpapersStore.getWallpaper');

  @override
  Future<void> getWallpaper() {
    return _$getWallpaperAsyncAction.run(() => super.getWallpaper());
  }

  final _$searshWallpaperAsyncAction =
      AsyncAction('_WallpapersStore.searshWallpaper');

  @override
  Future<void> searshWallpaper({required String searshQuery}) {
    return _$searshWallpaperAsyncAction
        .run(() => super.searshWallpaper(searshQuery: searshQuery));
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
  String toString() {
    return '''
wallpapers: ${wallpapers},
categorieList: ${categorieList},
state: ${state}
    ''';
  }
}
