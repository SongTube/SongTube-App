// Flutter
import 'dart:async';

import 'package:flutter/material.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class MusicPlayerRandomButton extends StatefulWidget {
  final Color? iconColor;
  final Color? enabledColor;
  MusicPlayerRandomButton({
    required this.iconColor,
    required this.enabledColor
  });
  @override
  _MusicPlayerRandomButtonState createState() => _MusicPlayerRandomButtonState();
}

class _MusicPlayerRandomButtonState extends State<MusicPlayerRandomButton> {

  // Button Status
  bool? enabled = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 8),
      duration: Duration(milliseconds: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: enabled! 
              ? widget.enabledColor!.withOpacity(0.3)
              : Colors.transparent,
            spreadRadius: 0.1,
            blurRadius: 15
          )
        ]
      ),
      child: IconButton(
        icon: Icon(
          EvaIcons.shuffle2Outline,
          size: 16,
          color: enabled!
            ? widget.enabledColor
            : widget.iconColor!.withOpacity(0.7)
        ),
        onPressed: () async {
          enabled = await (AudioService.customAction("enableRandom") as FutureOr<bool?>);
          setState(() {});
        }
      ),
    );
  }
}