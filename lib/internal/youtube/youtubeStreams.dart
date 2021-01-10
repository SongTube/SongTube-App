import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum YoutubeStreamSubscription { Search, Trending, Music }

class YoutubeStreams {

  YoutubeExplode yt;

  YoutubeStreams() {
    yt = YoutubeExplode();
    searchStreamController = BehaviorSubject<List<dynamic>>();
    searchResults = [];
  }

  // Search Stream Subscription
  int searchCount;
  String searchQuery;
  List<dynamic> searchResults;
  bool searchStreamSubscriptionRunning = false;
  StreamSubscription searchStreamSubscription;
  BehaviorSubject<List<dynamic>> searchStreamController;

  // Stream Subscriptions runner, this will get 10 results and then pause the Stream
  Future<void> runSearchStreamSubscription({String query, bool forceUpdate = false}) async {
    if (query?.trim() == "" || searchStreamSubscriptionRunning && !forceUpdate) return;
    searchCount = 1;
    searchStreamSubscriptionRunning = true;
    if (searchQuery != this.searchQuery || searchStreamSubscription == null || forceUpdate) {
      if (query == null) searchQuery = RandomString.getRandomLetter();
      searchStreamController.add([]);
      if (searchStreamSubscription != null) {
        await searchStreamSubscription.cancel();
        searchStreamSubscription = null;
      }
      searchStreamSubscription = YoutubeExplode().search
        .getVideosFromPage(searchQuery)
        .listen((event) {
          searchResults.add(event);
          searchCount++;
          if (searchCount > 10) {
            searchStreamSubscription.pause();
            searchStreamController.add(searchResults);
            searchStreamSubscriptionRunning = false;
          }
        }, cancelOnError: true);
    } else {
      searchStreamSubscription.resume();
    }
  }

}