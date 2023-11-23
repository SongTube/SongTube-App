import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:songtube/providers/app_settings.dart';

TextStyle defaultFontStyle = AppSettings.useSystemFontFamiliy
  ? const TextStyle()
  : GoogleFonts.poppins();

TextStyle tabBarTextStyle(BuildContext context, {double opacity = 0.7, bool bold = true, Color? color}) {
  return defaultFontStyle.copyWith(
    fontSize: 13,
    color: color ?? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
    letterSpacing: 0.6
  );
}

TextStyle headerTextStyle(BuildContext context, {double opacity = 1, bool bold = true}) {
  return defaultFontStyle.copyWith(
    fontSize: 18,
    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: bold ? FontWeight.w600 : FontWeight.normal
  );
}

TextStyle bigTextStyle(BuildContext context, {double opacity = 1, bool bold = true}) {
  return defaultFontStyle.copyWith(
    fontSize: 30,
    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: bold ? FontWeight.w900 : FontWeight.normal
  );
}

TextStyle textStyle(BuildContext context, {double opacity = 1, bool bold = true}) {
  return defaultFontStyle.copyWith(
    fontSize: 19,
    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: bold ? FontWeight.w600 : FontWeight.normal
  );
}

TextStyle subtitleTextStyle(BuildContext context, {double opacity = 1, bool bold = false}) {
  return defaultFontStyle.copyWith(
    fontSize: 15,
    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: bold ? FontWeight.w600 : FontWeight.normal
  );
}

TextStyle smallTextStyle(BuildContext context, {double opacity = 1, bool bold = false}) {
  return defaultFontStyle.copyWith(
    fontSize: 13,
    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: FontWeight.normal
  );
}

TextStyle tinyTextStyle(BuildContext context, {double opacity = 1, bool bold = false}) {
  return defaultFontStyle.copyWith(
    fontSize: 11,
    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(opacity),
    fontWeight: bold ? FontWeight.w600 : FontWeight.normal
  );
}