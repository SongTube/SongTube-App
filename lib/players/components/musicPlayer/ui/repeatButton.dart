// Flutter
import 'dart:async';

import 'package:flutter/material.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class MusicPlayerRepeatButton extends StatefulWidget {
  final Color? iconColor;
  final Color? enabledColor;
  MusicPlayerRepeatButton({
    required this.iconColor,
    required this.enabledColor
  });
  @override
  _MusicPlayerRepeatButtonState createState() => _MusicPlayerRepeatButtonState();
}

class _MusicPlayerRepeatButtonState extends State<MusicPlayerRepeatButton> {
  
  // Button Status
  bool? enabled = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 50),
      margin: EdgeInsets.only(left: 8),
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
          EvaIcons.repeatOutline,
          size: 16,
          color: enabled!
            ? widget.enabledColor
            : widget.iconColor!.withOpacity(0.7)
        ),
        onPressed: () async {
          enabled = await (AudioService.customAction("enableRepeat") as FutureOr<bool?>);
          setState(() {});
        }
      ),
    );
  }
}