import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';

class ColorsPalette {

  Color? dominant;
  Color? vibrant;
  ColorsPalette({
    required this.dominant,
    required this.vibrant,
  }) {
    int factor = 60;
    int redDiff = ((dominant?.red ?? 0) - (vibrant?.red ?? 0)).abs();
    int greenDiff = ((dominant?.green ?? 0) - (vibrant?.green ?? 0)).abs();
    int blueDiff = ((dominant?.blue ?? 0) - (vibrant?.blue ?? 0)).abs();
    if ((redDiff + greenDiff + blueDiff) < factor) {
      vibrant = text;
    }
    if (vibrant != null && vibrant!.computeLuminance() < 0.3) {
      vibrant = HSLColor.fromColor(vibrant!).withLightness(0.6).toColor();
    }
    if (vibrant == Colors.white) {
      vibrant = accentColor;
    }
    vibrant ??= accentColor;
  }

  Color get text => dominant!.computeLuminance() > 0.2 ? Colors.black : Colors.white;

  ColorsPalette copyWith({
    Color? dominant,
    Color? vibrant,
  }) {
    return ColorsPalette(
      dominant: dominant ?? this.dominant,
      vibrant: vibrant ?? this.vibrant,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dominant': dominant?.value,
      'vibrant': vibrant?.value,
    };
  }

  factory ColorsPalette.fromMap(Map<String, dynamic> map) {
    return ColorsPalette(
      dominant: Color(map['dominant']),
      vibrant: map['vibrant'] != null ? Color(map['vibrant']) : Color(map['dominant']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorsPalette.fromJson(String source) => ColorsPalette.fromMap(json.decode(source));

  @override
  String toString() => 'ColorsPalette(dominant: $dominant, vibrant: $vibrant)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ColorsPalette &&
      other.dominant == dominant &&
      other.vibrant == vibrant;
  }

  @override
  int get hashCode => dominant.hashCode ^ vibrant.hashCode;
}
