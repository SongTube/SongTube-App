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
  final Function onSearch;
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
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
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
          onSearch: (searchQuery) async {
            manager.urlController.clear();
            widget.onSearch();
            manager.searchBarFocusNode.unfocus();
            manager.showSearchBar = false;
            if (VideoId.parseVideoId(searchQuery) != null) {
              String id = VideoId.parseVideoId(searchQuery);
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              YoutubeExplode yt = YoutubeExplode();
              Video video = await yt.videos.get(id);
              manager.updateMediaInfoSet(video, null);
              Navigator.pop(context);
              Navigator.push(context,
                BlurPageRoute(
                  blurStrength: prefs.enableBlurUI ? 20 : 0,
                  slideOffset: Offset(0.0, 10.0),
                  builder: (_) => YoutubePlayerVideoPage()
              ));
              return;
            }
            if (PlaylistId.parsePlaylistId(searchQuery) != null) {
              String id = PlaylistId.parsePlaylistId(searchQuery);
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              YoutubeExplode yt = YoutubeExplode();
              Playlist playlist = await yt.playlists.get(id);
              manager.updateMediaInfoSet(playlist, null);
              Navigator.pop(context);
              Navigator.push(context,
                BlurPageRoute(
                  blurStrength: prefs.enableBlurUI ? 20 : 0,
                  slideOffset: Offset(0.0, 10.0),
                  builder: (_) => YoutubePlayerVideoPage(isPlaylist: true)
              ));
              return;
            }
            manager.youtubeSearchQuery = manager.urlController.text;
            manager.updateYoutubeSearchResults(updateResults: true);
            if (searchQuery.length > 1) {
              Future.delayed(Duration(milliseconds: 400), () =>
                config.addStringtoSearchHistory(searchQuery.trim()
              ));
            }
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

