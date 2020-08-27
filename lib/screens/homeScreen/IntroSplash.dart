import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/animations/showUp.dart';

class IntroSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Stack(
      children: <Widget>[
        ShowUpTransition(
          forward: true,
          duration: Duration(milliseconds: 600),
          slideSide: SlideFromSlide.TOP,
          child: Container(
            width: 180,
            margin: EdgeInsets.only(left: 16, top: 12),
            padding: EdgeInsets.only(bottom: 12, left: 12, top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.04),
                  offset: Offset(12,12),
                  spreadRadius: 0.01,
                  blurRadius: 8.0
                )
              ]
            ),
            child: FadeInTransition(
              delay: Duration(milliseconds: 300),
              duration: Duration(milliseconds: 300),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8, top: 2),
                    child: Icon(
                      MdiIcons.youtube,
                      size: 32,
                      color: Theme.of(context).accentColor
                    )
                  ),
                  Text(
                    "SongTube",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "YTSans"
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ShowUpTransition(
          forward: true,
          duration: Duration(milliseconds: 600),
          slideSide: SlideFromSlide.BOTTOM,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              margin: EdgeInsets.only(top: 32),
              padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
              height: 350,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    offset: Offset(0,0),
                    spreadRadius: 0.01,
                    blurRadius: 20.0
                  )
                ]
              ),
              child: FadeInTransition(
                delay: Duration(milliseconds: 300),
                duration: Duration(milliseconds: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                      duration: (Duration(milliseconds: 300)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            MdiIcons.youtube,
                            size: 170,
                            color: Colors.black12.withOpacity(0.04)
                          ),
                          Icon(
                            MdiIcons.youtube,
                            size: 150,
                            color: Theme.of(context).accentColor
                          )
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                      duration: (Duration(milliseconds: 400)),
                      child: Text(
                        "Nothing here yet",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Varela",
                        )
                      ),
                    ),
                    SizedBox(height: 4),
                    AnimatedOpacity(
                      opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                      duration: (Duration(milliseconds: 500)),
                      child: Text(
                        "Paste a link into the app or search for videos on Youtube!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Varela"
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        manager.screenIndex = 2;
                      },
                      child: AnimatedOpacity(
                        opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                        duration: (Duration(milliseconds: 600)),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Explore Youtube",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "Varela"
                                  )
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white.withOpacity(0.2)
                                ),
                                child: Icon(
                                  MdiIcons.arrowRight,
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25)
      ],
    );
  }
}