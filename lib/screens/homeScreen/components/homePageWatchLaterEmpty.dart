import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageWatchLaterEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(150)
                  ),
                ),
              ),
              Container(
                child: Icon(EvaIcons.clockOutline,
                  size: 120),
              )
            ],
          ),
          SizedBox(height: 32),
          Text(
            "Your Watch Later is empty!",
            style: TextStyle(
              fontFamily: 'YTSans',
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
          )
        ],
      )
    );
  }
}