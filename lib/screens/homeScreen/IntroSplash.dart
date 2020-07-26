import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';

class IntroSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width*0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                  duration: (Duration(milliseconds: 300)),
                  child: Icon(
                    EvaIcons.activityOutline,
                    size: 150,
                    color: Colors.redAccent
                  ),
                ),
                SizedBox(height: 4),
                AnimatedOpacity(
                  opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                  duration: (Duration(milliseconds: 400)),
                  child: Text(
                    "Nothing here yet",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat"
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
                SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    manager.screenIndex = 2;
                  },
                  child: AnimatedOpacity(
                    opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                    duration: (Duration(milliseconds: 600)),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(MdiIcons.youtube, color: Colors.white),
                          Text(
                            "Explore Youtube",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Varela"
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }
}