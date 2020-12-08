import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';

class WatchLaterRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider preferences = Provider.of<PreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Watch Later",
          style: TextStyle(
            color: Theme.of(context).textTheme
              .bodyText1.color
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.builder(
        itemCount: preferences.watchLaterVideos.length,
        itemBuilder: (context, index) {
          return ListTile(

          );
        },
      ),
    );
  }
}