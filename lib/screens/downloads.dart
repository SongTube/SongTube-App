// Flutter
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/screens/downloadScreen/tabs/cancelledTab.dart';

// Internal
import 'package:songtube/screens/downloadScreen/tabs/downloadsTab.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/downloadScreen/tabs/queueTab.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class DownloadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 12,
          shadowColor: Colors.black.withOpacity(0.15),
          backgroundColor: Theme.of(context).cardColor,
          title: ShowUpTransition(
            forward: true,
            duration: Duration(milliseconds: 400),
            slideSide: SlideFromSlide.TOP,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Icon(
                        EvaIcons.cloudDownloadOutline,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      Languages.of(context).labelDownloads,
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyText1.color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottom: TabBar(
            
            labelStyle: TextStyle(
              fontSize: 13,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3
            ),
            unselectedLabelStyle: TextStyle(
                fontSize: 13,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2
            ),
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).textTheme.bodyText1
              .color.withOpacity(0.4),
            indicator: MD2Indicator(
              indicatorSize: MD2IndicatorSize.tiny,
              indicatorHeight: 4,
              indicatorColor: Theme.of(context).accentColor,
            ),
            tabs: [
              Tab(child: Text(
                Languages.of(context).labelQueued
              )),
              Tab(child: Text(
                Languages.of(context).labelCompleted
              )),
              Tab(child: Text(
                Languages.of(context).labelCancelled
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DownloadsQueueTab(),
            DownloadsTab(),
            DownloadsCancelledTab()
          ],
        ),
      ),
    );
  }
}