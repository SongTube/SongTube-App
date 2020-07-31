// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:shimmer/shimmer.dart';
import 'package:songtube/ui/animations/showUp.dart';

class ShimmerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ShowUpTransition(
          delay: Duration(milliseconds: 100),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              margin: EdgeInsets.all(16),
              height: 208,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor
              ),
            ),
          ),
        ),
        ShowUpTransition(
          delay: Duration(milliseconds: 200),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              margin: EdgeInsets.only(right: 36, left: 36, bottom: 4),
              height: 30,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor
              ),
            ),
          ),
        ),
        ShowUpTransition(
          delay: Duration(milliseconds: 300),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              margin: EdgeInsets.only(right: 100, left: 100),
              height: 20,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          delay: Duration(milliseconds: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ShowUpTransition(
          delay: Duration(milliseconds: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          delay: Duration(milliseconds: 600),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          delay: Duration(milliseconds: 700),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          delay: Duration(milliseconds: 800),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.475,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}