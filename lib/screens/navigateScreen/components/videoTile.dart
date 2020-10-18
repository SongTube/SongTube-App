// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoTile extends StatelessWidget {
  final searchItem;
  VideoTile({
    @required this.searchItem
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return InkWell(
      onTap: () {
        if (searchItem is SearchVideo) {
          manager.getVideoDetails("https://www.youtube.com/watch?v=${searchItem.videoId}");
        } else {
          manager.getPlaylistDetails("https://www.youtube.com/playlist?list=${searchItem.playlistId}");
        }
      },
      child: Ink(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor
        ),
        child: Row(
          children: <Widget>[
            FutureBuilder<String>(
              future: searchItem is SearchVideo
                ? getVideoThumbnailLink()
                : getPlaylistThumbnailLink(searchItem),
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(left: 8),
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 200),
                      placeholder: MemoryImage(kTransparentImage),
                      image: snapshot.hasData
                        ? NetworkImage(snapshot.data)
                        : MemoryImage(kTransparentImage),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              }
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 16, top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      searchItem is SearchVideo
                        ? "${searchItem.videoTitle}"
                        : "${searchItem.playlistTitle}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4),
                    Text(
                      searchItem is SearchVideo
                        ? "${searchItem.videoAuthor} • " +
                          "${NumberFormat.compact().format(searchItem.videoViewCount)} views"
                        : "Playlist • ${searchItem.playlistVideoCount} videos",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, thickness: 2)
          ],
        ),
      ),
    );
  }

  // Return Video Thumbnail
  Future<String> getVideoThumbnailLink() async {
    String link = "http://img.youtube.com/vi/${searchItem.videoId}/mqdefault.jpg";
    return link; 
  }

  // Return Playlist Thumbnail
  Future<String> getPlaylistThumbnailLink(SearchPlaylist searchPlaylist) async {
    Playlist playlist = await YoutubeExplode().playlists.get(searchPlaylist.playlistId);
    return playlist.thumbnails.mediumResUrl;
  }

}