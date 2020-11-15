// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/screens/homeScreen/pages/playlistPage.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/shimmer/shimmerVideoPage.dart';
import 'package:songtube/screens/homeScreen/components/shimmer/shimmerPlaylistPage.dart';
import 'package:songtube/screens/homeScreen/pages/videoPage.dart';

// Packages
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/homeScreen/pages/homePage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // QuickSearch Controller
  TextEditingController quickSearchController;

  @override
  void initState() {
    super.initState();
    quickSearchController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset:
          manager.mediaStreamReady == false ? false : true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: currentHome(context)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget currentHome(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
    if (manager.mediaStreamReady && manager.currentLoad == CurrentLoad.SingleVideo) {
      // Return Single Video Page
      return VideoPage();
    } else if (manager.mediaStreamReady && manager.currentLoad == CurrentLoad.Playlist) {
      // Return Playlist Page
      return PlaylistPage();
    } else {
      if (manager.currentLoad == CurrentLoad.None) {
        // Return HomePage
        return Center(
          child: HomePage(
            controller: quickSearchController,
            onQuickSearch: (String searchQuery) {
              quickSearchController.clear();
              manager.pushYoutubePage(searchQuery);
              if (searchQuery.length > 1) {
                Future.delayed(Duration(milliseconds: 400), () =>
                  appData.addStringtoSearchHistory(searchQuery.trim()
                ));
              }
            },
          )
        );
      } else if (manager.currentLoad == CurrentLoad.SingleVideo) {
        // Return Shimmer Single Video Page
        return const ShimmerVideoPage();
      } else {
        // Return Shimmer Playlist Page
        return const ShimmerPlaylistPage();
      }
    }
  }
}
