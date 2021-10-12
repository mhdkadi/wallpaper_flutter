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
              color: categorie.isSellected
                  ? Theme.of(context).splashColor
                  : Theme.of(context).primaryColor,
            ),
          ),
          backgroundColor: categorie.isSellected
              ? Theme.of(context).highlightColor
              : Theme.of(context).cardColor,
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }
}
