import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:songtube/ui/animations/showUp.dart';

class ShimmerSearchPage extends StatelessWidget {
  const ShimmerSearchPage();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return ShowUpTransition(
          forward: true,
          duration: Duration(milliseconds: 400),
          child: Padding(
            padding: EdgeInsets.only(
              top: 16,
              bottom: index == 11 ? 16 : 0
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16/9,
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                    highlightColor: Theme.of(context).cardColor,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).scaffoldBackgroundColor
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                        highlightColor: Theme.of(context).cardColor,
                        child: Container(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                              highlightColor: Theme.of(context).cardColor,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).scaffoldBackgroundColor
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Shimmer.fromColors(
                              baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                              highlightColor: Theme.of(context).cardColor,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).scaffoldBackgroundColor
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}