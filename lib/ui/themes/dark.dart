import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';

ThemeData darkTheme() {
  HSVColor color = HSVColor.fromColor(accentColor);
  HSVColor desaturated = HSVColor.fromAHSV(color.alpha, color.hue, 0.8, color.value);
  return ThemeData.dark().copyWith(
    brightness: Brightness.light,
    primaryColor: desaturated.toColor(),
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
    scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
    toggleableActiveColor: desaturated.toColor(),
    cardColor: const Color.fromARGB(255, 30, 30, 30),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: desaturated.toColor(),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black12
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: desaturated.toColor()
    ),
    shadowColor: Colors.black.withOpacity(0.2),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: desaturated.toColor(),
    )
  );
}

ThemeData blackTheme() {
  HSVColor color = HSVColor.fromColor(accentColor);
  HSVColor desaturated = HSVColor.fromAHSV(color.alpha, color.hue, 0.8, color.value);
  return ThemeData.dark().copyWith(
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
    toggleableActiveColor: desaturated.toColor(),
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.black,
    primaryColor: desaturated.toColor(),
    primaryColorLight: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black26,
      labelStyle: TextStyle(
        color: desaturated.toColor(),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Color.fromARGB(255, 20, 20, 20),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: desaturated.toColor()
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: desaturated.toColor()
    )
  );
}