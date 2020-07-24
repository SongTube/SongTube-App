import 'package:flutter/material.dart';

class PlayingWidget extends StatelessWidget {
  final Function onTap;
  final Widget icon;
  PlayingWidget({
    @required this.onTap,
    @required this.icon
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        padding: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            Text(
              "Playing",
              style: TextStyle(
                fontFamily: "Varela",
                fontWeight: FontWeight.w600
              )
            ),
          ],
        ),
      ),
    );
  }
}