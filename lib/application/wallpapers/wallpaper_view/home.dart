import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    _wallpapersStore = Provider.of<WallpapersStore>(context, listen: false);
    _wallpapersStore!.getWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Consumer<WallpapersStore>(builder: (context, store, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'searchText',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        store.sellectCategorie(0);
                        store.searshWallpaper(
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
                      splashColor: Colors.white,
                      onTap: () {
                        store.sellectCategorie(index);
                        store.searshWallpaper(
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
              const Text(
                "Discover new photos",
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 590,
                child: Observer(builder: (_) {
                  switch (_wallpapersStore!.state) {
                    case StoreState.initial:
                      return const NoInternetConnection();
                    case StoreState.loading:
                      return const Loading();
                    case StoreState.loaded:
                      return wallPaper(store.wallpapers);
                  }
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
