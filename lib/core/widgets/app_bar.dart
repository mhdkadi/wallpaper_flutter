import 'package:flutter/material.dart';

AppBar appbar(BuildContext context) {
  return AppBar(
    //elevation: 0.0,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Wallpaper'),
            Text(
              'Flutter',
              style: TextStyle(color: Theme.of(context).highlightColor),
            ),
          ],
        ),
        const SizedBox(height: 30)
      ],
    ),
  );
}
