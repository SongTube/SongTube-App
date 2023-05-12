import 'dart:convert';

import 'package:flutter/material.dart';

class ColorsPalette {

  Color? dominant;
  Color? vibrant;
  ColorsPalette({
    required this.dominant,
    required this.vibrant,
  });

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
