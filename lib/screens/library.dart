// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/pages/localVideos.dart';
import 'package:songtube/pages/playlists.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Internal
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/pages/about.dart';
import 'package:songtube/screens/libraryScreen/socialLinksRow.dart';
import 'package:songtube/pages/watchHistory.dart';
import 'package:songtube/screens/libraryScreen/watchHistoryRow.dart';
import 'package:songtube/pages/settings.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Icon(
                EvaIcons.folderOutline,
                color: Theme.of(context).accentColor,
              ),
            ),
            Text(
              Languages.of(context).labelLibrary,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Theme.of(context).textTheme.bodyText1.color
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(EvaIcons.settingsOutline,
                color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(context,
                  BlurPageRoute(
                    blurStrength: Provider.of<PreferencesProvider>
                      (context, listen: false).enableBlurUI ? 20 : 0,
                    builder: (_) => 
                    SettingsPage()));
              }
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                // Watch History Row (First 10 videos only)
                if (prefs.watchHistory.isNotEmpty)
                WatchHistoryRow(),
                if (prefs.watchHistory.isNotEmpty)
                SizedBox(height: 8),
                Divider(indent: 12, endIndent: 12),
                // Playlists
                ListTile(
                  leading: Icon(Icons.playlist_play_rounded),
                  title: Text(
                    Languages.of(context).labelPlaylists,
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                      BlurPageRoute(
                        blurStrength: Provider.of<PreferencesProvider>
                          (context, listen: false).enableBlurUI ? 20 : 0,
                        builder: (_) => 
                        PlaylistsPage()));
                  },
                ),
                // Watch History (All videos)
                ListTile(
                  leading: Icon(EvaIcons.clockOutline),
                  title: Text(
                    "Watch History",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                      BlurPageRoute(
                        blurStrength: Provider.of<PreferencesProvider>
                          (context, listen: false).enableBlurUI ? 20 : 0,
                        builder: (_) => 
                        WatchHistoryPage()));
                  },
                ),
                // Local Videos
                if (!mediaProvider.loadingVideos || mediaProvider.listVideos.isNotEmpty) 
                ListTile(
                  leading: Icon(EvaIcons.videoOutline),
                  title: Text(
                    "Local Videos",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                      BlurPageRoute(
                        blurStrength: Provider.of<PreferencesProvider>
                          (context, listen: false).enableBlurUI ? 20 : 0,
                        builder: (_) => 
                        LocalVideosPage()));
                  },
                ),
                // Playlist History
                /*ListTile(
                  leading: Icon(MdiIcons.playlistCheck),
                  title: Text(
                    "Playlist History",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  onTap: () {
                    // TODO: Push Playlist History Page
                  },
                ),
                // Channel History
                ListTile(
                  leading: Icon(EvaIcons.bookOpenOutline),
                  title: Text(
                    "Channel History",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  onTap: () {
                    // TODO: Push Channel History Page
                  },
                ),*/
                Divider(indent: 12, endIndent: 12),
                // All Social Links
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    "Social",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    )
                  ),
                ),
                SocialLinksRow(),
                SizedBox(height: 16),
                Divider(indent: 12, endIndent: 12),
                // Donate
                ListTile(
                  onTap: () {
                    launch("https://paypal.me/artixo");
                  },
                  leading: Icon(
                    EvaIcons.heart,
                    color: Colors.red,
                    size: 36,
                  ),
                  title: Text(
                    Languages.of(context).labelDonate,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    )
                  ),
                  subtitle: Text(
                    "Support Development!",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                ),
                // About us
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                      BlurPageRoute(
                        blurStrength: Provider.of<PreferencesProvider>
                          (context, listen: false).enableBlurUI ? 20 : 0,
                        builder: (_) => 
                        AboutPage()));
                  },
                  leading: Icon(
                    EvaIcons.questionMarkCircle,
                    color: Colors.orangeAccent,
                    size: 36,
                  ),
                  title: Text(
                    "About",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    )
                  ),
                  subtitle: Text(
                    "Licenses, Contact Info and more",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                ),
                if (AudioService?.currentMediaItem != null || pageProvider.infoItem != null)
                SizedBox(height: kBottomNavigationBarHeight*1.5)
              ],
            ),
          ),
        ],
      )
    );
  }
}