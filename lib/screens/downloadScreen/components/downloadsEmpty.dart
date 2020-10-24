// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/ui/animations/showUp.dart';

class NoDownloads extends StatelessWidget {
  const NoDownloads();
  @override
  Widget build(BuildContext context) {
    return ShowUpTransition(
      duration: Duration(milliseconds: 400),
      delay: Duration(milliseconds: 200),
      forward: true,
      slideSide: SlideFromSlide.BOTTOM,
      child: Container(
        height: 30,
        width: double.infinity,
        color: Theme.of(context).accentColor,
        child: Center(
          child: Text(
            "Empty",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'YTSans'
            ),
          ),
        ),
      ),
    );
  }
}