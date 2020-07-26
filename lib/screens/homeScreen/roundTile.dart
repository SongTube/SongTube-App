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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            offset: Offset(0, 3), //(x,y)
            blurRadius: 6.0,
            spreadRadius: 0.01 
          )
        ]
      ),
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