import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/components/autohideScaffold.dart';
import 'package:songtube/ui/components/searchBar.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return AutoHideScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Image.asset(
                  'assets/images/youtube-music.png',
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                )
              ),
              Text(
                Languages.of(context).labelYouTube + " " +
                Languages.of(context).labelMusic,
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              Spacer(),
            ],
          )
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: CommonSearchBar(
              hintText: Languages.of(context).labelSearchYoutube.toLowerCase(),
              textController: manager.searchMusicController,
              onClear: () => setState(() {
                manager.searchMusicController.clear();
              }),
              focusNode: manager.musicSearchBarFocusNode,
              onChanged: (_) {},
              onSubmit: (String query) {
                manager.searchYoutubeMusic(query: query, forceReload: true);
              },
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
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: manager.showMusicSearchBar
                ? Container(
                    color: Theme.of(context).cardColor,
                    child: StreamsLargeThumbnailView(
                      infoItems: manager?.youtubeMusicSearch?.dynamicSearchResultsList ?? [],
                      onReachingListEnd: () {
                        manager.searchYoutubeMusic(
                          query: manager.youtubeMusicSearch.query
                        );
                      },
                    ),
                  )
                : Container(
                    color: Theme.of(context).cardColor,
                    child: StreamsLargeThumbnailView(
                      infoItems: manager?.homeMusicVideoList ?? [],
                      onReachingListEnd: () {},
                    ),
                  )
            ),
          ),
        ],
      ),
    );
  }
}