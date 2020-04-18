import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData white(Color accent) {
    return ThemeData.light().copyWith(
      accentColor: accent,
      toggleableActiveColor: accent,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 247),
      cardColor: Color.fromARGB(255, 255, 255, 255)
    );
  }

  static ThemeData dark(Color accent) {
    return ThemeData.dark().copyWith(
      accentColor: accent,
      toggleableActiveColor: accent,
      cardColor: Color.fromARGB(255, 60, 60, 60),
    );
  }

  static ThemeData black(Color accent) {
    return ThemeData.dark().copyWith(
      accentColor: accent,
      toggleableActiveColor: accent,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Color.fromARGB(255, 20, 20, 20),
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
    );
  }
}
