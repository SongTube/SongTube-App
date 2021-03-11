import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/provider/preferencesProvider.dart';

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
                  String name = await showDialog(
                    context: context,
                    builder: (context) {
                      return CreatePlaylistDialog();
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
        )
      ],
    );
  }
}

class CreatePlaylistDialog extends StatefulWidget {
  @override
  _CreatePlaylistDialogState createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Text(
        Languages.of(context).labelCreate +
        " " + Languages.of(context).labelPlaylist,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 14
              ),
              controller: controller,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(14.0),
                hintText: Languages.of(context).labelEditorTitle,
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.4),
                  fontSize: 14
                ),
                border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 0, 
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            Languages.of(context).labelCreate,
            style: TextStyle(
              color: controller.text.isNotEmpty && controller.text.length > 3
                ? Theme.of(context).accentColor
                : Theme.of(context).textTheme.bodyText1.color 
                    .withOpacity(0.4)
            ),
          ),
          onPressed: controller.text.isNotEmpty && controller.text.length > 3
            ? () => Navigator.pop(context, controller.text)
            : null
        ),
        TextButton(
          child: Text(
            Languages.of(context).labelCancel,
            style: TextStyle(
              color: Theme.of(context).accentColor
            ),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}