// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AppTheme {
  static ThemeData white(Color accent) {
    return ThemeData.light().copyWith(
      accentColor: accent,
      toggleableActiveColor: accent,
      primaryColor: accent,
      iconTheme: IconThemeData(
        color: Colors.grey[700]
      ),
      textTheme: TextTheme(
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
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 247),
      cardColor: Color.fromARGB(255, 255, 255, 255),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: accent,
        ),
        fillColor: Colors.grey[100]
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.grey[200],
      ),
      textSelectionHandleColor: accent,
    );
  }

  static ThemeData dark(Color accent) {
    HSVColor color = HSVColor.fromColor(accent);
    HSVColor desaturated = HSVColor.fromAHSV(color.alpha, color.hue, 0.68, color.value);
    return ThemeData.dark().copyWith(
      accentColor: desaturated.toColor(),
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      textTheme: TextTheme(
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
      toggleableActiveColor: accent,
      cardColor: Color.fromARGB(255, 60, 60, 60),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: accent,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black12
      ),
      textSelectionHandleColor: accent,
    );
  }

  static ThemeData black(Color accent) {
    HSVColor color = HSVColor.fromColor(accent);
    HSVColor desaturated = HSVColor.fromAHSV(color.alpha, color.hue, 0.68, color.value);
    return ThemeData.dark().copyWith(
      canvasColor: Colors.black,
      accentColor: desaturated.toColor(),
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      textTheme: TextTheme(
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

      toggleableActiveColor: accent,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Color.fromARGB(255, 20, 20, 20),
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black26,
        labelStyle: TextStyle(
          color: accent,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Color.fromARGB(255, 20, 20, 20),
      ),
      textSelectionHandleColor: accent,
    );
  }
}
