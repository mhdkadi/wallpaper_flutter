import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black26,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      brightness: Brightness.dark,
      splashColor: Colors.black,
      primarySwatch: Colors.blue,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black26,
      shadowColor: Colors.white60,
      cardColor: Colors.white38,
      highlightColor: Colors.blue,
      backgroundColor: Colors.black26);
}

ThemeData lightTheme() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      brightness: Brightness.light,
      splashColor: Colors.white,
      primarySwatch: Colors.blue,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      shadowColor: Colors.black54,
      cardColor: Colors.blueGrey[50],
      highlightColor: Colors.blue,
      backgroundColor: Colors.white);
}
