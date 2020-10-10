// Flutter
import 'package:flutter/material.dart';

class MediaLoadingWidget extends StatelessWidget {
  const MediaLoadingWidget();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
              "Getting your Media...",
              style: TextStyle(
                fontFamily: 'YTSans',
                fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }
}