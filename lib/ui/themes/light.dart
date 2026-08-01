import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';

ThemeData lightTheme() {
  return ThemeData.light(useMaterial3: false).copyWith(
    primaryColor: accentColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
    cardColor: const Color.fromARGB(255, 255, 255, 255),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: accentColor,
      ),
      fillColor: Colors.grey[100]
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: Colors.grey[200],
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: accentColor
    ),
    shadowColor: Colors.black.withOpacity(0.08),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: accentColor,
    )
  );
}