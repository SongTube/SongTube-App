// Flutter
import 'package:flutter/material.dart';

class TextFieldTile extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final IconData icon;
  final TextInputType inputType;
  TextFieldTile({
    @required this.textController,
    @required this.labelText,
    @required this.icon,
    @required this.inputType
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      cursorColor: Theme.of(context).accentColor,
      controller: textController,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,
          color: Theme.of(context).iconTheme.color
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0, 
            style: BorderStyle.none,
          ),
        ),
        labelText: labelText,
      ),
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 14,
      ),
    );
  }
}