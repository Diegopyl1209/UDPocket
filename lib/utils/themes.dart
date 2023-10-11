import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData.light(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: const Color.fromRGBO(235, 239, 242, 1),
  primaryTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: "Intel",
      ),
  cardTheme: const CardTheme(color: Colors.white),
  textTheme: ThemeData.light().textTheme.apply(bodyColor: Colors.black),
  colorScheme: const ColorScheme.light(
    primary: Colors.red,
    secondary: Colors.redAccent,
    background: Color.fromRGBO(235, 239, 242, 1),
    onBackground: Colors.black,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color.fromRGBO(20, 20, 23, 1),
    indicatorColor: Colors.redAccent,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    labelTextStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
    iconTheme: MaterialStatePropertyAll(IconThemeData(color: Colors.white)),
  ),
);

ThemeData darkMode = ThemeData.dark(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryTextTheme: ThemeData.dark().textTheme.apply(
        fontFamily: "Intel",
      ),
  cardTheme: const CardTheme(color: Color.fromRGBO(30, 30, 33, 1)),
  textTheme: ThemeData.dark().textTheme.apply(bodyColor: Colors.white),
  colorScheme: const ColorScheme.dark(
    primary: Colors.red,
    secondary: Colors.redAccent,
    background: Color(0xFF303030),
    onBackground: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF303030),
    shadowColor: Colors.transparent,
    indicatorColor: Colors.redAccent,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    labelTextStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
    iconTheme: MaterialStatePropertyAll(IconThemeData(color: Colors.white)),
  ),
);
