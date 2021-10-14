import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/widgets/no_results.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/no_internet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../wallpaper_controller/wallpaper_store.dart';
import 'widgets/categorie_widget.dart';
import 'widgets/wallpaper_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, WallpapersStore>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int pageIndex = 2;
  @override
  void initState() {
    _tabController = TabController(
      length: 10,
      vsync: this,
      initialIndex: 0,
    );
    store.getWallpaper(page: 1);
    super.initState();
  }

  void onRefresh() async {
    await store
        .getWallpaper(page: 1)
        .onError((_, __) => _refreshController.refreshCompleted());
    _searchController.text = '';
    store.sellectCategorie(0);
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    await store
        .loadMoreWallpaper(page: pageIndex)
        .then((_) => pageIndex++)
        .onError((_, __) {
      _refreshController.loadComplete();
      return 0;
    });
    _refreshController.loadComplete();
  }

  void searshWallpaper(String searshQuery) async {
    store.sellectCategorie(0);
    await store.searshWallpaper(searshQuery: searshQuery);
  }

  void sellectCategorie(int index) async {
    store.sellectCategorie(index);
    await store.searshWallpaper(
        searshQuery: store.categorieList[index].categorieName);
    _searchController.text = '';
  }

  Widget test() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: store.categorieList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => sellectCategorie(index),
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
          //SizedBox(
          // height: 590,
          // child:
          // SmartRefresher(
          //   controller: _refreshController,
          //   onRefresh: onRefresh,
          //   onLoading: onLoading,
          //   enablePullDown: true,
          //   enablePullUp: true,
          //   child:
          Observer(
            builder: (_) {
              switch (store.storState!) {
                case StoreState.initial:
                  return const NoInternetConnection();
                case StoreState.loading:
                  return const Loading();
                case StoreState.loaded:
                  return store.wallpapers!.fold(
                    (failure) => const NoResults(),
                    (wallpapers) => wallPaper(wallpapers, context),
                  );
              }
            },
          ),
          // ),
          //),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: TabBar(
                labelPadding: const EdgeInsets.all(0),
                isScrollable: true,
                indicatorColor: Colors.white,
                controller: _tabController,
                tabs: List<Widget>.generate(store.categorieList.length,
                    (int index) {
                  return Tab(
                    icon:
                        CategorieWidget(categorie: store.categorieList[index]),
                  );
                })),
            pinned: true,
            floating: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              background: Column(
                children: [
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Wallpaper',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Flutter',
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
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
                            onSubmitted: searshWallpaper,
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'searsh'.tr(),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => searshWallpaper(_searchController.text),
                          child: const Icon(
                            Icons.search,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          test()
        ],
      ),
    );
  }
}
