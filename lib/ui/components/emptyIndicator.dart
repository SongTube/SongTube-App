// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/ui/animations/showUp.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator();
  @override
  Widget build(BuildContext context) {
    return ShowUpTransition(
      duration: Duration(milliseconds: 600),
      delay: Duration(milliseconds: 400),
      forward: true,
      slideSide: SlideFromSlide.TOP,
      child: Container(
        height: 30,
        margin: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(3,3),
              blurRadius: 8,
              spreadRadius: 1
            )
          ]
        ),
        child: Center(
          child: Text(
            Languages.of(context).labelEmpty,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Product Sans',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}