import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/no_internet.dart';
import '../wallpaper_controller/wallpaper_store.dart';
import 'widgets/categorie_widget.dart';
import 'widgets/wallpaper_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  WallpapersStore? _wallpapersStore;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int pageIndex = 2;
  @override
  void initState() {
    _wallpapersStore = Provider.of<WallpapersStore>(context, listen: false);
    _wallpapersStore!.getWallpaper(page: 0);
    super.initState();
  }

  void onRefresh({required WallpapersStore store}) async {
    await store
        .getWallpaper(page: 0)
        .onError((_, __) => _refreshController.refreshCompleted());
    _searchController.text = '';
    store.sellectCategorie(0);
    _refreshController.refreshCompleted();
  }

  void onLoading({required WallpapersStore store}) async {
    await store
        .loadMoreWallpaper(page: pageIndex)
        .then((_) => pageIndex++)
        .onError((_, __) {
      _refreshController.loadComplete();
      return 0;
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Consumer<WallpapersStore>(builder: (_, store, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) async {
                          store.sellectCategorie(0);
                          await store.searshWallpaper(searshQuery: value);
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'searsh'.tr(),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        store.sellectCategorie(0);
                        await store.searshWallpaper(
                            searshQuery: _searchController.text);
                      },
                      child: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: store.categorieList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        store.sellectCategorie(index);
                        await store.searshWallpaper(
                            searshQuery:
                                store.categorieList[index].categorieName);
                        _searchController.text = '';
                      },
                      child: Observer(builder: (context) {
                        return CategorieWidget(
                            categorie: store.categorieList[index]);
                      }),
                    );
                  },
                ),
              ),
              Text(
                'discover'.tr(),
                style: const TextStyle(
                    fontFamily: 'Overpass',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 590,
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    onRefresh(store: store);
                  },
                  onLoading: () {
                    onLoading(store: store);
                  },
                  enablePullDown: true,
                  enablePullUp: true,
                  child: Observer(builder: (_) {
                    switch (_wallpapersStore!.state) {
                      case StoreState.initial:
                        return const NoInternetConnection();
                      case StoreState.loading:
                        return const Loading();
                      case StoreState.loaded:
                        return wallPaper();
                    }
                  }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
