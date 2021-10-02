import 'package:flutter/material.dart';

import '../../wallpaper_model/categorie_model.dart';

class CategorieWidget extends StatelessWidget {
  const CategorieWidget({Key? key, required this.categorie}) : super(key: key);
  final Categorie categorie;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          label: Text(
            categorie.categorieName,
            style: TextStyle(
              color: categorie.isSellected ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor:
              categorie.isSellected ? Colors.blue : Colors.greenAccent[50],
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }
}
