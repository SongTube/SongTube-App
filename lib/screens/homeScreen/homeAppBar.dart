import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/components/searchBar.dart';

class HomePageAppBar extends StatefulWidget {
  final bool openSearch;
  HomePageAppBar(this.openSearch);

  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return SliverAppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      title: AnimatedSwitcher(
        reverseDuration: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 400),
        child: !widget.openSearch ? Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8, left: 16),
              height: 40,
              width: 40,
              child: Image.asset('assets/images/ic_launcher.png')
            ),
            Text(
              "SongTube",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "YTSans",
                color: Theme.of(context).textTheme.bodyText1.color
                  .withOpacity(0.8)
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(EvaIcons.searchOutline,
                color: Theme.of(context).iconTheme.color),
              onPressed: () {
                manager.showSearchBar = true;
                manager.searchBarFocusNode.requestFocus();
              },
            ),
            SizedBox(width: 8)
          ],
        ) : STSearchBar(
              controller: manager.urlController,
              focusNode: manager.searchBarFocusNode,
              onSearch: (searchQuery) {
                manager.searchBarFocusNode.unfocus();
                manager.showSearchBar = false;
                manager.youtubeSearchQuery= manager.urlController.text;
                manager.updateYoutubeSearchResults(updateResults: true);
                if (searchQuery.length > 1) {
                  Future.delayed(Duration(milliseconds: 400), () =>
                    config.addStringtoSearchHistory(searchQuery.trim()
                  ));
                }
              },
              onChanged: (_) {
                setState(() {});
              },
              onBack: () {
                manager.showSearchBar = false;
              },
              onClear: () {
                manager.urlController.clear();
                setState(() {});
              },
              leadingIcon: Icon(MdiIcons.youtube, size: 32, color: Colors.redAccent),
              searchHint: "Search Youtube..."
            )
      ),
    );
  }
}

