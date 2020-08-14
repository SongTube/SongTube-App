import 'package:flutter/material.dart';
import 'package:songtube/ui/searchResult/videoTile.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchPage extends StatefulWidget {
  final List results;
  final Function onSelect;
  SearchPage({
    @required this.results,
    @required this.onSelect,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {

  // Youtube Explode Client
  YoutubeExplode client;

  @override
  void initState() {
    super.initState();
    client = new YoutubeExplode();
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.results.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: widget.results[index] == widget.results.first ? 10 : 0,
            bottom: widget.results[index] == widget.results.last ? 10 : 0
          ),
          child: VideoTile(
            client: client,
            video: widget.results[index],
            onSelect: widget.onSelect,
          ),
        );
      }
    );
  }
}