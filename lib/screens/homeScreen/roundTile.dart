// Flutter
import 'package:flutter/material.dart';

class RoundTile extends StatelessWidget {
  final Icon icon;
  final Text text;
  final Function onPressed;
  RoundTile({
    @required this.icon,
    @required this.text,
    this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            this.icon,
            SizedBox(height: 2),
            this.text
          ],
        ),
      ),
    );
  }
}