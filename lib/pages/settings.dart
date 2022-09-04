// Flutter
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/pages/settings/components/downloadSettings.dart';
import 'package:songtube/pages/settings/components/generalSettings.dart';
import 'package:songtube/pages/settings/components/themeSettings.dart';

class SettingsPage extends StatefulWidget {
  
  // Scaffold Key
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            Languages.of(context).labelSettings,
            style: TextStyle(
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              color: Theme.of(context).cardColor,
              child: TabBar(
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
                    Languages.of(context).labelTheme
                  )),
                  Tab(child: Text(
                    Languages.of(context).labelGeneral
                  )),
                  Tab(child: Text(
                    Languages.of(context).labelDownload
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  children: [
                    // Themes Settings
                    ThemeSettings(),
                    // General Settings
                    GeneralSettings(),
                    // Downloads Settings
                    DownloadSettings(),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).padding.bottom,
              color: Theme.of(context).cardColor
            )
          ],
        ),
      ),
    );
  }

}
