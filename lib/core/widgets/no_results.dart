import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const SizedBox(
            width: 200,
            height: 200,
            child: Image(image: AssetImage("assets/images/no_results.png")),
          ),
          Text('no_results'.tr()),
        ],
      ),
    );
  }
}
