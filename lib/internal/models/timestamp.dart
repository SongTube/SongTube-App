// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:songtube/internal/media_utils.dart';

class Timestamp {

  final String text;
  final Duration duration;
  Timestamp({
    required this.text,
    required this.duration,
  });
  
  // Remove unnecesary symbols
  static String _removeToxicSymbols(String string) {
    return string
      .replaceAll('Container.', '')
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '')
      .replaceAll('\n', '')
      .replaceAll('!', '')
      .replaceAll('[', '')
      .replaceAll(']', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('¡', '');
  }
  

  // Parse duration from String
  static Duration _parseDuration(String text) {
    final string = _removeToxicSymbols(text);
    final durationList = string.split(':');
    final Duration duration;
    if (durationList.length == 2) {
      final minutes = int.parse(durationList.first);
      final seconds = int.parse(durationList[1]);
      duration = Duration(minutes: minutes, seconds: seconds);
    } else {
      final hours = int.parse(durationList.first);
      final minutes = int.parse(durationList[1]);
      final seconds = int.parse(durationList[2]);
      duration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    }
    return duration;
  }

  // Process comment to extract timestamps
  static List<dynamic> parseStringForTimestamps(String message) {
    final parsedStrings = <dynamic>[];
    // Split our message into separate words in a list
    final strings = message.replaceAll('　', ' ').split(' ');
    for (var item in strings) {
      item = item.toString();
      // If this word contains ":", this might be a timestamp
      if (item.contains(':')) {
        // Some words might not be separated by a empty space but by a new line, in this case we need to split
        // our word again, count and save the new lines, then we check if we have a timestamp
        if (item.contains('\n')) {
          final newLineItems = item.split('\n');
          // Case where we have some text and a possible timestamp with a new line separating them
          if (newLineItems.length == 2) {
            final newLineCount = '\n'.allMatches(item);
            // First item
            var firstItem = newLineItems.first;
            for (var _ in newLineCount) {
              firstItem = '$firstItem\n';
            }
            try {
              final duration = _parseDuration(firstItem);
              parsedStrings.add(Timestamp(text: firstItem, duration: duration));
            } catch (_) {
              parsedStrings.add(firstItem);
            }
            // Second Item
            final secondItem = newLineItems.last;
            try {
              final duration = _parseDuration(secondItem);
              parsedStrings.add(Timestamp(text: secondItem, duration: duration));
            } catch (_) {
              parsedStrings.add(secondItem);
            }
          // Case where we have a clusterfuck of text separated with new lines only
          } else {
            for (var newLineItem in newLineItems) {
              try {
                final duration = _parseDuration(newLineItem);
                parsedStrings.add(Timestamp(text: '$newLineItem\n', duration: duration));
              } catch (_) {
                parsedStrings.add('$newLineItem\n');
              }
            }
          }
        } else {
          try {
            final duration = _parseDuration(item);
            parsedStrings.add(Timestamp(text: item, duration: duration));
          } catch (_) {
            parsedStrings.add(item);
          }
        }
      } else {
        parsedStrings.add(item);
      }
    }
    return parsedStrings;
  }

}
