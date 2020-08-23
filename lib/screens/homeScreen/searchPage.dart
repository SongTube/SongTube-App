import 'package:flutter/material.dart';
import 'package:songtube/ui/searchResult/videoTile.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchPage extends StatelessWidget {
  final List results;
  final Function onSelect;
  SearchPage({
    @required this.results,
    @required this.onSelect,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: results[index] == results.first ? 10 : 0,
            bottom: results[index] == results.last ? 10 : 0
          ),
          child: VideoTile(
            client: YoutubeExplode(),
            video: results[index],
            onSelect: onSelect,
          ),
        );
      }
    );
  }
}