// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DirectoryExplorer extends StatefulWidget {

  /// Initial directory for the Explorer to show
  /// value must be a [String]
  final String rootPath;

  /// Title is shown it at the Top of the Directory
  /// Explorer, vlaue must be a [String]
  final String title;

  /// [Widget] that will be shown at the left side of
  /// the item in the Directory Explorer list
  final Widget itemPrefix;

  /// [Widget] that will be shown at the right side of
  /// the item in the Directory Explorer list
  final Widget itemSuffix;

  /// Show or Hide those folders that starts with a dot,
  /// for example: ".NiceFolder"
  final bool showHidden;

  /// Background color of all the Directory Explorer body
  final Color backgroundColor;

  DirectoryExplorer({
    @required this.rootPath,
    @required this.title,
    @required this.itemPrefix,
    this.itemSuffix,
    this.showHidden: false,
    this.backgroundColor,
  });

  @override
  _DirectoryExplorerState createState() => _DirectoryExplorerState();
}

class _DirectoryExplorerState extends State<DirectoryExplorer> with TickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;
  Directory originalDirectory;
  Directory rootDirectory;
  List<FileSystemEntity> list = [];

  List<FileSystemEntity> getList() {
    List<FileSystemEntity> fullList = rootDirectory.listSync();
    List<FileSystemEntity> directoriesList = [];
    fullList.forEach((element) {
      if (widget.showHidden == true && element is Directory)
        directoriesList.add(element);
      if (widget.showHidden == false && element is Directory && basename(element.path).startsWith(".") == false)
        directoriesList.add(element);
    });
    return directoriesList;
  }

  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    originalDirectory = Directory(widget.rootPath);
    rootDirectory = Directory(widget.rootPath);
    list = getList();
    super.initState();
    Future.delayed((Duration(milliseconds: 10)), () {
      animationController.forward();
    });
    
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.backgroundColor
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: kToolbarHeight,
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              )
            )
          ),
          SizedBox(height: 1, child: Divider(indent: 16, endIndent: 16)),
          Expanded(
            child: FadeTransition(
              opacity: animation,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: widget.itemPrefix,
                    title: Text(
                      basename(list[index].path),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 14
                      ),
                      maxLines: 1,
                    ),
                    onTap: () {
                      rootDirectory = Directory(list[index].path);
                      animationController.reverse();
                      Future.delayed((Duration(milliseconds: 200)), () {
                        setState(() => list = getList());
                        animationController.forward();
                      });
                    },
                    trailing: widget.itemSuffix != null ? widget.itemPrefix : SizedBox(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 1, child: Divider(indent: 16, endIndent: 16)),
          Container(
            height: kToolbarHeight,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  // Left button
                  SizedBox(width: 8),
                  IgnorePointer(
                    ignoring: originalDirectory.path == rootDirectory.path ? true : false,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: originalDirectory.path == rootDirectory.path ? 0.0 : 1.0,
                      child: GestureDetector(
                        onTap: () {
                          rootDirectory = rootDirectory.parent;
                          animationController.reverse();
                          Future.delayed((Duration(milliseconds: 200)), () {
                            setState(() => list = getList());
                            animationController.forward();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).accentColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_back_ios, color: Colors.white),
                              SizedBox(width: 4),
                              Text("Back", style: TextStyle(color: Colors.white)),
                              SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, rootDirectory.path);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).accentColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.folder, color: Colors.white),
                          SizedBox(width: 4),
                          Text("Select Folder", style: TextStyle(color: Colors.white)),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Right button
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}