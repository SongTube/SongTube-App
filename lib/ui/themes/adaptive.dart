import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

ThemeData adaptiveTheme(ColorScheme? data, Brightness brightness) {
  final scheme = data ?? ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  return ThemeData(
    brightness: brightness,
    useMaterial3: true,
    colorScheme: scheme,
    primaryColor: scheme.primary,
    scaffoldBackgroundColor: scheme.background,
    cardColor: scheme.surface,
    dividerColor: scheme.outlineVariant,
    shadowColor: scheme.shadow
  );
}