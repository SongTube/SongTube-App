// Flutter
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/screens/downloadScreen/tabs/cancelledTab.dart';

// Internal
import 'package:songtube/screens/downloadScreen/tabs/downloadsTab.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/downloadScreen/tabs/queueTab.dart';
import 'package:songtube/ui/components/autoHideScaffold.dart';

class DownloadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context, listen: false);
    return DefaultTabController(
      initialIndex: downloadsProvider.downloadingList.isNotEmpty ? 0 : 1,
      length: 3,
      child: AutoHideScaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          title: Row(
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
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              color: Theme.of(context).cardColor,
              child: TabBar(
                labelStyle: TextStyle(
                  fontSize: 14,
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
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[600].withOpacity(0.1),
              indent: 12,
              endIndent: 12
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DownloadsQueueTab(),
                  DownloadsTab(),
                  DownloadsCancelledTab()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}