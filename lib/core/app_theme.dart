import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF262C66),
  iconTheme: const IconThemeData(
    color: Color(0xFF262C66),
  ),
  indicatorColor: const Color(0xFF262C66),
  scaffoldBackgroundColor: const Color(0xFF262C66),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF262C66),
    elevation: 10,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 30,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF262C66),
  ),
  useMaterial3: true,
);
