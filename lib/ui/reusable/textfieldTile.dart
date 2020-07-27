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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            offset: Offset(0, 3), //(x,y)
            blurRadius: 6.0,
            spreadRadius: 0.01 
          )
        ]
      ),
      child: TextField(
        keyboardType: inputType,
        cursorColor: Theme.of(context).accentColor,
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,
            color: Theme.of(context).iconTheme.color
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}