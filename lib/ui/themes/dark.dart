import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';

ThemeData darkTheme() {
  HSVColor color = HSVColor.fromColor(accentColor);
  HSVColor desaturated = HSVColor.fromAHSV(color.alpha, color.hue, 0.8, color.value);
  accentColor = desaturated.toColor();
  return ThemeData.dark(useMaterial3: false).copyWith(
    shadowColor: ThemeData.dark().shadowColor.withOpacity(0.1),
    brightness: Brightness.light,
    
    primaryColor: accentColor,
    primaryColorDark: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.white
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.white
      ),
      bodyText1: TextStyle(
        color: Colors.white
      ),
      bodyText2: TextStyle(
        color: Colors.white
      ),
      caption: TextStyle(
        color: Colors.white
      ),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 35, 35, 35),
    toggleableActiveColor: accentColor,
    cardColor: const Color(0xFF282828),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: accentColor,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black12
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: accentColor
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: accentColor,
    )
  );
}

ThemeData blackTheme() {
  HSVColor color = HSVColor.fromColor(accentColor);
  HSVColor desaturated = HSVColor.fromAHSV(color.alpha, color.hue, 0.8, color.value);
  accentColor = desaturated.toColor();
  return ThemeData.dark(useMaterial3: false).copyWith(
    canvasColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.white
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.white
      ),
      bodyText1: TextStyle(
        color: Colors.white
      ),
      bodyText2: TextStyle(
        color: Colors.white
      ),
      caption: TextStyle(
        color: Colors.white
      ),
    ),
    toggleableActiveColor: accentColor,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.black,
    primaryColor: accentColor,
    primaryColorLight: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black26,
      labelStyle: TextStyle(
        color: accentColor,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Color.fromARGB(255, 20, 20, 20),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: accentColor
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: accentColor
    )
  );
}