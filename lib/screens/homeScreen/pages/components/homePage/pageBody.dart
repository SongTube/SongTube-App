import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/internal/languages.dart';

class HomePageBody extends StatelessWidget {
  final Function onQuickSearchTap;
  HomePageBody({this.onQuickSearchTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.75,
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
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
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: onQuickSearchTap,
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: TextField(
                          enabled: false,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color
                          ),
                          decoration: InputDecoration(
                            hintText: Languages.of(context).labelQuickSearch,
                            border: InputBorder.none,
                            icon: Icon(EvaIcons.searchOutline),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                    child: Icon(
                      MdiIcons.arrowRight,
                      color: Theme.of(context).iconTheme.color
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}