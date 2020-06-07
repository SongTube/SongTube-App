// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/downloads_manager.dart';
import 'package:songtube/screens/downloadsPages/completed_page.dart';
import 'package:songtube/screens/downloadsPages/downloading_page.dart';

// Packages
import 'package:provider/provider.dart';

class DownloadTab extends StatefulWidget {
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {

  void listener(ManagerProvider provider) {
    provider.downloadInfoSetList.forEach((element) {
      element.currentAction.stream.listen((event) {
        if (event == "Done") {
          provider.getDatabase();
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
          // Download and Completed Page Buttoms
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      ? Theme.of(context).cardColor
                      : Theme.of(context).canvasColor
                  ),
                  child: Text("Ongoing", textAlign: TextAlign.center),
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
                      ? Theme.of(context).cardColor
                      : Theme.of(context).canvasColor
                  ),
                  child: Text("Completed", textAlign: TextAlign.center),
                ),
              )
            ],
          ),
          // Padding
          SizedBox(height: 4),
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
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: manager.downloadsTabIndex == 0
          ? FloatingActionButton(
            child: Icon(Icons.clear_all),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            onPressed: () {
              if (manager.downloadInfoSetList.any((element) => element.downloader.downloadFinished == false)) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Warning", style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color
                      )),
                      content: Text("There are still downloads in progress, are you sure you wanna clear the downloads list?", style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color
                      )),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK", style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color
                          )),
                          onPressed: () {
                            manager.downloadInfoSetList.forEach((element) {
                              if (element.downloader.downloadFinished == false)
                                element.downloader.downloadFinished = true;
                            });
                            manager.downloadInfoSetList = [];
                            Navigator.pop(context);
                          }
                        ),
                        FlatButton(
                          child: Text("Cancel", style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color
                          )),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ), 
                    );
                  },
                );
              } else {
                manager.downloadInfoSetList = [];
              }
            }
          )
        : Container()
      ),
    );
  }
}