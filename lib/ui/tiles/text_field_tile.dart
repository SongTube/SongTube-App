import 'package:flutter/material.dart';
import 'package:songtube/ui/text_styles.dart';

class TextFieldTile extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final IconData icon;
  final TextInputType inputType;
  final Color? fillColor;
  const TextFieldTile({
    required this.textController,
    required this.labelText,
    required this.icon,
    required this.inputType,
    this.fillColor,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Semantics(
        label: labelText,
        child: TextField(
          keyboardType: inputType,
          cursorColor: Theme.of(context).primaryColor,
          controller: textController,
          decoration: InputDecoration(
            prefixIcon: Icon(icon,
              color: Theme.of(context).primaryColor
            ),
            filled: true,
            fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
              ),
            ),
            labelText: labelText,
            labelStyle: tinyTextStyle(context, opacity: 0.7)
          ),
          style: smallTextStyle(context)
        ),
      ),
    );
  }
}