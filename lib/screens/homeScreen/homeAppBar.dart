import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/searchBar.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomePageAppBar extends StatefulWidget {
  final bool openSearch;
  final Function(String) onSearch;
  final Function onChanged;
  HomePageAppBar({
    this.openSearch,
    this.onSearch,
    this.onChanged
  });

  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      title: AnimatedSwitcher(
        reverseDuration: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 400),
        child: STSearchBar(
          controller: manager.urlController,
          focusNode: manager.searchBarFocusNode,
          onSearch: (searchQuery) {
            widget.onSearch(searchQuery);
          },
          onChanged: (String query) {
            widget.onChanged(query);
            manager.setState();
          },
          onBack: () {
            manager.showSearchBar = false;
          },
          onClear: () {
            manager.urlController.clear();
            setState(() {});
          },
          leadingIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: !manager.showSearchBar
                ? Image.asset(
                    DateTime.now().month == 12
                      ? 'assets/images/logo_christmas.png'
                      : 'assets/images/ic_launcher.png',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  )
                : GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Future.delayed(Duration(milliseconds: 50),
                        () => manager.showSearchBar = false);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(Icons.arrow_back_outlined,
                        color: Theme.of(context).iconTheme.color),
                    ),
                  )
            ),
          ),
          searchHint: "SongTube",
          onTap: () {
            if (!manager.showSearchBar) {
              manager.showSearchBar = true;
            }
          },
        )
      ),
    );
  }
}

