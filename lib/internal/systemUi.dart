import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';

void setSystemUiColor(BuildContext context) {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context, listen: false);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    Brightness _systemBrightness = Theme.of(context).brightness;
    Brightness _statusBarBrightness = _systemBrightness == Brightness.light
      ? Brightness.dark
      : Brightness.light;
    if (!mediaProvider.fwController.isAttached) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: _statusBarBrightness,
          statusBarIconBrightness: _statusBarBrightness,
          systemNavigationBarColor: Theme.of(context).cardColor,
          systemNavigationBarIconBrightness: _statusBarBrightness,
        ),
      );
    } else {
      double position = mediaProvider.fwController.panelPosition;
      int sdkInt = config.preferences.sdkInt;
      if (position > 0.95) {
        bool mediaBlurBackground = config.useBlurBackground;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarIconBrightness: mediaBlurBackground ? mediaProvider.textColor == Colors.black
              ? Brightness.dark : Brightness.light : _statusBarBrightness,
            systemNavigationBarIconBrightness: mediaBlurBackground ? sdkInt >= 30 ? mediaProvider.textColor == Colors.black
              ? Brightness.dark : Brightness.light : null : _statusBarBrightness,
          ),
        );
      } else if (position < 0.95) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: _statusBarBrightness,
            statusBarIconBrightness: _statusBarBrightness,
            systemNavigationBarColor: Theme.of(context).cardColor,
            systemNavigationBarIconBrightness: _statusBarBrightness,
          ),
        );
      }
    }
  }