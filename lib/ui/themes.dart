// Flutter
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData white(Color accent) {
    return ThemeData.light().copyWith(
      accentColor: accent,
      toggleableActiveColor: accent,
      primaryColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.grey[700]
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.black87
        ),
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 247),
      cardColor: Color.fromARGB(255, 255, 255, 255),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.redAccent,
        ),
        fillColor: Colors.grey[100]
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.grey[200],
      ),
      textSelectionHandleColor: Colors.redAccent,
    );
  }

  static ThemeData dark(Color accent) {
    return ThemeData.dark().copyWith(
      accentColor: accent,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.white
        ),
      ),
      toggleableActiveColor: accent,
      cardColor: Color.fromARGB(255, 60, 60, 60),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.redAccent,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black12
      ),
      textSelectionHandleColor: Colors.redAccent,
    );
  }

  static ThemeData black(Color accent) {
    return ThemeData.dark().copyWith(
      canvasColor: Colors.black,
      accentColor: accent,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      textTheme: TextTheme(
        body1: TextStyle(
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
          color: Colors.redAccent,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Color.fromARGB(255, 20, 20, 20),
      ),
      textSelectionHandleColor: Colors.redAccent,
    );
  }
}
