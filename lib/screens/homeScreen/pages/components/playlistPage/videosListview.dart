import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlaylistVideosListView extends StatelessWidget {
  final List<Video> playlistVideos;
  final Function(int) onDismiss;
  final Function(int) onVideoTap;
  PlaylistVideosListView({
    @required this.playlistVideos,
    @required this.onDismiss,
    @required this.onVideoTap
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlistVideos.length,
      physics: BouncingScrollPhysics(),
      itemExtent: 80,
      itemBuilder: (context, index) {
        Video video = playlistVideos[index];
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: Key(video.id.value),
          onDismissed: (_) => onDismiss(index),
          background: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).accentColor
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Remove",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              video.title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 14
              ),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
            subtitle: Text(
              video.author,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                fontSize: 12
              ),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
            leading: Container(
              height: 80,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 200),
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(video.thumbnails.mediumResUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () => onVideoTap(index)
          ),
        );
      },
    );
  }
}