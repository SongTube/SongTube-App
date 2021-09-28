import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/sheets/createPlaylist.dart';

class AddStreamToPlaylistSheet extends StatefulWidget {
  final StreamInfoItem stream;
  AddStreamToPlaylistSheet({
    @required this.stream
  });

  @override
  _AddStreamToPlaylistSheetState createState() => _AddStreamToPlaylistSheetState();
}

class _AddStreamToPlaylistSheetState extends State<AddStreamToPlaylistSheet> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Wrap(
      children: [
        Container(
          height: kToolbarHeight*1.1,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded,
                  color: Theme.of(context).iconTheme.color),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context).labelAddToPlaylist,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 18,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      widget.stream.name,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 12,
                        fontFamily: 'Product Sans',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 32)
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.only(
            left: 32, right: 16
          ),
          title: Text(
            Languages.of(context).labelWatchLater,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color
                .withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w600
            ),
          ),
          value: prefs.watchLaterHasVideo(widget.stream),
          onChanged: (_) {
            if (!prefs.watchLaterHasVideo(widget.stream)) {
              List<StreamInfoItem> videos = prefs.watchLaterVideos;
              videos.add(widget.stream);
              prefs.watchLaterVideos = videos;
            } else {
              List<StreamInfoItem> videos = prefs.watchLaterVideos;
              videos.removeWhere((element) => element.id == widget.stream.id);
              prefs.watchLaterVideos = videos;
            }
          }
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.only(
            left: 32, right: 16
          ),
          title: Text(
            Languages.of(context).labelFavorites,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color
                .withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w600
            ),
          ),
          value: prefs.favoriteHasVideo(widget.stream),
          onChanged: (_) {
            if (!prefs.favoriteHasVideo(widget.stream)) {
              List<StreamInfoItem> videos = prefs.favoriteVideos;
              videos.add(widget.stream);
              prefs.favoriteVideos = videos;
            } else {
              List<StreamInfoItem> videos = prefs.favoriteVideos;
              videos.removeWhere((element) => element.id == widget.stream.id);
              prefs.favoriteVideos = videos;
            }
          }
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        Container(
          height: kToolbarHeight*1.1,
          child: Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  Languages.of(context).labelPlaylists,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String name = await showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      )
                    ),
                    context: context,
                    builder: (context) {
                      return CreatePlaylistSheet();
                    }
                  );
                  if (name != null)
                  prefs.streamPlaylistCreate(name, "local", [widget.stream]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Icon(Icons.add_rounded,
                        color: Theme.of(context).iconTheme.color,
                        size: 18),
                      SizedBox(width: 4),
                      Text(
                        Languages.of(context).labelCreate,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontSize: 14,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        if (prefs.streamPlaylists.isNotEmpty)
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: prefs.streamPlaylists.length,
            itemBuilder: (context, index) {
              StreamPlaylist playlist = prefs.streamPlaylists[index];
              return CheckboxListTile(
                contentPadding: EdgeInsets.only(
                  left: 32, right: 16
                ),
                title: Text(
                  playlist.name,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
                value: prefs.streamPlaylistHasStream(playlist.name, widget.stream),
                onChanged: (_) {
                  if (!prefs.streamPlaylistHasStream(playlist.name, widget.stream)) {
                    prefs.streamPlaylistsInsertStream(playlist.name, widget.stream);
                  } else {
                    prefs.streamPlaylistRemoveStream(playlist.name, widget.stream);
                  }
                }
              );
            },
          ),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: Theme.of(context).cardColor
        )
      ],
    );
  }
}