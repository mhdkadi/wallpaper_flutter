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
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: store.categorieList.length,
      vsync: this,
      initialIndex: 0,
    );
    store.getWallpaper();
    super.initState();
  }

  Widget test() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'discover'.tr(),
            style: const TextStyle(
                fontFamily: 'Overpass',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 14),
          Observer(builder: (context) {
            return SizedBox(
              height: store.state != StoreState.loaded ? 650 : null,
              child: Observer(
                builder: (_) {
                  switch (store.state) {
                    case StoreState.initial:
                      return const NoInternetConnection();
                    case StoreState.loading:
                      return const Loading();
                    case StoreState.loaded:
                      if (store.wallpapers!.wallpapers.isEmpty) {
                        return const NoResults();
                      } else {
                        return wallPaper(store.wallpapers!, context);
                      }
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SmartRefresher(
          controller: store.refreshController,
          onRefresh: store.onRefresh,
          onLoading: store.onLoading,
          enablePullDown: true,
          enablePullUp: true,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                bottom: TabBar(
                    onTap: store.sellectTab,
                    labelPadding: const EdgeInsets.all(0),
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    controller: _tabController,
                    tabs: List<Widget>.generate(store.categorieList.length,
                        (int index) {
                      return Observer(builder: (context) {
                        return Tab(
                          icon: CategorieWidget(
                              categorie: store.categorieList[index]),
                        );
                      });
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
                                onChanged: store.searchText,
                                onSubmitted: (value) => store.getWallpaper(),
                                decoration: InputDecoration(
                                  hintText: 'searsh'.tr(),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => store.getWallpaper(),
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
              test(),
            ],
          ),
        ),
      ),
    );
  }
}
