// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/internal/languages.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class IntroReady extends StatelessWidget {
  final Function onEnd;
  IntroReady({
    this.onEnd
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            ShowUpTransition(
              duration: Duration(milliseconds: 600),
              forward: true,
              slideSide: SlideFromSlide.LEFT,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            EvaIcons.layersOutline,
                            size: 40,
                            color: Colors.red
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'YTSans',
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodyText1.color
                          ),
                          children: [
                            TextSpan(
                              text: Languages.of(context).labelConfigReady
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ShowUpTransition(
              slideSide: SlideFromSlide.BOTTOM,
              duration: Duration(milliseconds: 600),
              forward: true,
              child: Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/appReady.png'),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'YTSans',
                            color: Theme.of(context).textTheme.bodyText1.color
                          ),
                          children: [
                            TextSpan(
                              text: 
                                Languages.of(context).labelIntroductionIsOver
                                + "\n" +
                                Languages.of(context).labelEnjoy + " "
                            ),
                            TextSpan(
                              text: "SongTube!",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ShowUpTransition(
          delay: Duration(milliseconds: 600),
          duration: Duration(milliseconds: 600),
          forward: true,
          slideSide: SlideFromSlide.BOTTOM,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              label: Text(
                Languages.of(context).labelGoHome,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'YTSans',
                  fontSize: 16
                ),
              ),
              icon: Icon(EvaIcons.homeOutline, color: Colors.white),
              onPressed: onEnd,
            ),
          ),
        ),
      )
    );
  }
}