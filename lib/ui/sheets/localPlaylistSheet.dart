import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/sheets/createPlaylist.dart';

class LocalPlaylistSheet extends StatefulWidget {
  
  const LocalPlaylistSheet({
    @required this.song,
    Key key }) : super(key: key);
  final MediaItem song;

  @override
  State<LocalPlaylistSheet> createState() => _LocalPlaylistSheetState();
}

class _LocalPlaylistSheetState extends State<LocalPlaylistSheet> {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    final playlists = prefs.localPlaylists;
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
                      widget.song.title,
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
        if (playlists.isNotEmpty)
        ListView.builder(
          shrinkWrap: true,
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return CheckboxListTile(
              title: Row(
                children: [
                  Icon(Icons.playlist_play, color: Theme.of(context).accentColor),
                  SizedBox(width: 8),
                  Text(playlist.name,
                    style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  )),
                ],
              ),
              value: playlist.songs.any((element) => element.id == widget.song.id),
              onChanged: (_) {
                if (playlist.songs.any((element) => element.id == widget.song.id)) {
                  prefs.localPlaylistDeleteSong(playlist.id, widget.song);
                } else {
                  prefs.localPlaylistAddSong(playlist.id, widget.song);
                }
              }
            );
          },
        ),
        _emptyPlaylistWidget(),
      ],
      
    );
  }

  Widget _emptyPlaylistWidget() {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {
          final result = await showModalBottomSheet(
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
          if (result != null) {
            prefs.createLocalPlaylist(result, [widget.song]);
          }
        },
        child: Builder(
          builder: (context) {
            if (prefs.localPlaylists.isEmpty) {
              return Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.only(
                  top: 8, bottom: 8, left: 16, right: 16
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Row(
                  children: [
                    Text(
                      Languages.of(context).labelCreate + " " +
                      Languages.of(context).labelPlaylist,
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.add, color: Colors.white),
                  ],
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.only(
                  top: 8, bottom: 8, left: 16, right: 16
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Languages.of(context).labelCreate + " " +
                      Languages.of(context).labelPlaylist,
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.add, color: Colors.white, size: 16,),
                  ],
                ),
              );
            }
          }
        ),
      ),
    );
  }
}