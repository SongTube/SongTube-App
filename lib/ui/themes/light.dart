import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    toggleableActiveColor: accentColor,
    primaryColor: accentColor,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.black
      ),
      bodyText1: TextStyle(
        color: Colors.black
      ),
      bodyText2: TextStyle(
        color: Colors.black
      ),
      caption: TextStyle(
        color: Colors.black
      ),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
    cardColor: const Color.fromARGB(255, 255, 255, 255),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: accentColor,
      ),
      fillColor: Colors.grey[100]
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.grey[200],
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: accentColor
    ),
    shadowColor: Colors.black.withOpacity(0.08),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: accentColor,
    )
  );
}