// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/downloadsPages/completedPage.dart';
import 'package:songtube/screens/downloadsPages/downloadingPage.dart';

class DownloadTab extends StatefulWidget {
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> with TickerProviderStateMixin {

  void listener(ManagerProvider provider) {
    provider.downloadInfoSetList.forEach((element) {
      element.currentAction.stream.listen((event) {
        if (event == "Completed") {
          provider.getDatabase();
          setState(() {});
        }
        if (event == "Access Denied") {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context, listen: true);
    listener(manager);
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Download and Completed Pages Content
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Ongoing Downloads Page
                IgnorePointer(
                  ignoring: manager.downloadsTabIndex == 0 ? false : true,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: manager.downloadsTabIndex == 0 ? 1.0 : 0.0,
                    child: DownloadingPage(),
                  ),
                ),
                // Completed Downloads Page
                IgnorePointer(
                  ignoring: manager.downloadsTabIndex == 1 ? false : true,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: manager.downloadsTabIndex == 1 ? 1.0 : 0.0,
                    child: CompletedPage(),
                  ),
                ),
                // Download and Completed Page Buttoms
                StreamBuilder<Object>(
                  stream: manager.showDownloadsTabs.stream,
                  builder: (context, snapshot) {
                    return AnimatedOpacity(
                      opacity: snapshot.data == true ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: IgnorePointer(
                        ignoring: snapshot.data == true ? true : false,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 16, right: 16),
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              // Ongoing Downloads page
                              GestureDetector(
                                onTap: () {setState(() => manager.downloadsTabIndex = 0);},
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  margin: EdgeInsets.only(top: 4),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: manager.downloadsTabIndex == 0
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).canvasColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(3.5, 3.5), //(x,y)
                                        blurRadius: 5.0,
                                        spreadRadius: 2.1 
                                      )
                                    ]
                                  ),
                                  child: Text(
                                    "Ongoing",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontWeight: FontWeight.w600,
                                      color: manager.downloadsTabIndex == 0
                                        ? Colors.white
                                        : Theme.of(context).iconTheme.color
                                    ),
                                  ),
                                ),
                              ),
                              // Padding
                              SizedBox(width: 16),
                              // Completed page
                              GestureDetector(
                                onTap: () {setState(() => manager.downloadsTabIndex = 1);},
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  margin: EdgeInsets.only(top: 4),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: manager.downloadsTabIndex == 1
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).canvasColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(3.5, 3.5), //(x,y)
                                        blurRadius: 5.0,
                                        spreadRadius: 2.1 
                                      )
                                    ]
                                  ),
                                  child: Text(
                                    "Completed",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontWeight: FontWeight.w600,
                                      color: manager.downloadsTabIndex == 1
                                        ? Colors.white
                                        : Theme.of(context).iconTheme.color
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}