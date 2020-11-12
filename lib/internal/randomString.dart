// Dart
import 'dart:math';

class RandomString {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static const _letters = 'qwertyuiopasdfghjlcvbnm';
  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
  static String getRandomLetter() => String.fromCharCodes(Iterable.generate(
    1, (_) => _letters
    .codeUnitAt(Random().nextInt(_letters.length))
  ));
}