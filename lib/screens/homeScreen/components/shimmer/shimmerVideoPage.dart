// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:shimmer/shimmer.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class ShimmerVideoPage extends StatelessWidget {
  const ShimmerVideoPage();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        // Video Player
        ShowUpTransition(
          forward: true,
          delay: Duration(milliseconds: 100),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              height: 208,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor
              ),
            ),
          ),
        ),
        // Channel Logo, Video Title & Author
        ShowUpTransition(
          forward: true,
          delay: Duration(milliseconds: 200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                      highlightColor: Theme.of(context).cardColor,
                      child: Container(
                        margin: EdgeInsets.only(left: 8, bottom: 4, top: 8, right: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                      highlightColor: Theme.of(context).cardColor,
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 20,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 4),
        ),
        ShowUpTransition(
          forward: true,
          delay: Duration(milliseconds: 300),
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
          forward: true,
          delay: Duration(milliseconds: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                highlightColor: Theme.of(context).cardColor,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.96,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          forward: true,
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
                    borderRadius: BorderRadius.circular(10),
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
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          forward: true,
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
                    borderRadius: BorderRadius.circular(10),
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
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor.withOpacity(0.4)
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShowUpTransition(
          forward: true,
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
                    borderRadius: BorderRadius.circular(10),
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
                    borderRadius: BorderRadius.circular(10),
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