import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/text_styles.dart';

class TextFieldTile extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final IconData icon;
  final TextInputType inputType;
  final Color? fillColor;
  final Color? vibrantColor;
  final bool bottomLine;
  const TextFieldTile({
    required this.textController,
    required this.labelText,
    required this.icon,
    required this.inputType,
    this.fillColor,
    this.vibrantColor,
    this.bottomLine = false,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    return Semantics(
      label: labelText,
      child: TextField(
        keyboardType: inputType,
        cursorColor: Theme.of(context).primaryColor,
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: AppAnimatedIcon(icon,
            size: 20,
            color: vibrantColor,
          ),
          filled: true,
          fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: bottomLine ? 1 : 0,
              style: BorderStyle.solid,
              color: Theme.of(context).dividerColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(15)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: bottomLine ? 2 : 0,
              style: BorderStyle.solid,
              color: mediaProvider.currentColors.vibrant!
            ),
          ),
          labelText: labelText,
          labelStyle: smallTextStyle(context, opacity: 0.7)
        ),
        style: smallTextStyle(context)
      ),
    );
  }
}