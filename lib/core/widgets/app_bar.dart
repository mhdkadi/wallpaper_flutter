import 'package:flutter/material.dart';

AppBar appBar = AppBar(
  elevation: 0.0,
  backgroundColor: Colors.white,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        'Wallpaper',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      Text(
        'Flutter',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    ],
  ),
);
