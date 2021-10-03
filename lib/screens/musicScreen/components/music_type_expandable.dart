import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:transparent_image/transparent_image.dart';

class MusicScreenTypeExpandable extends StatefulWidget {
  const MusicScreenTypeExpandable({
    this.id,
    @required this.title,
    @required this.songs,
    this.description,
    this.thumbnail,
    this.lowResThumbnail,
    this.onDeletePlaylist,
    Key key }) : super(key: key);
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String lowResThumbnail;
  final List<MediaItem> songs;
  final Function() onDeletePlaylist;

  @override
  _MusicScreenTypeExpandableState createState() => _MusicScreenTypeExpandableState();
}

class _MusicScreenTypeExpandableState extends State<MusicScreenTypeExpandable> {

  // Indicates if this tile is selected, on selected, expand itself to show all the songs
  bool selected = false;

  // Indicate if this Expandable Collection of songs is a playlist
  bool get isPlaylist => widget.id != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Type Tile
        GestureDetector(
          onTap: () => setState(() => selected = !selected),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(12),
            color: selected ? Theme.of(context).accentColor.withOpacity(0.08) : Colors.transparent,
            child: Row(
              children: [
                if (widget.lowResThumbnail != null || isPlaylist)
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4)
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ImageFade(
                      fadeDuration: Duration(milliseconds: 300),
                      placeholder: !isPlaylist
                        ? Image.file(File(widget.lowResThumbnail))
                        : Image.memory(kTransparentImage),
                      image: !isPlaylist
                        ? FileImage(File(widget.thumbnail == null
                          ? widget.lowResThumbnail : widget.thumbnail))
                        : widget.lowResThumbnail != null
                          ? FileImage(File(widget.lowResThumbnail))
                          : MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                          ),
                        ),
                      ),
                      if (widget.description != null)
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          widget.description,
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color
                              .withOpacity(0.7),
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: selected
                            ? Theme.of(context).accentColor
                            : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: selected
                                ? Theme.of(context).accentColor
                                    .withOpacity(0.4)
                                : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 4)
                            )
                          ]
                        ),
                        child: Text(
                          "${widget.songs.length} Songs",
                          style: TextStyle(
                            color: selected
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyText1.color,
                            fontSize: 10,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (isPlaylist)
                IconButton(
                  onPressed: widget.onDeletePlaylist,
                  icon: Icon(Icons.delete_outline)
                )
              ],
            ),
          ),
        ),
        // Content of this tile to show up on selected
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: selected ? FadeInTransition(
            delay: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250),
            child: SongsListView(
              songs: widget.songs,
              searchQuery: "",
              shrinkWrap: true,
              addBottomPadding: false,
              tintNowPlaying: false),
          ) : SizedBox()
        )
      ],
      
    );
  }
}