import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/ui/internal/popupMenu.dart';
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoTags extends StatelessWidget {
  final TagsControllers? tags;
  final StreamInfoItem? infoItem;
  final Function? onAutoTag;
  final Function? onManualTag;
  final Function? onSearchDevice;
  VideoTags({
    this.tags,
    this.infoItem,
    this.onAutoTag,
    this.onManualTag,
    this.onSearchDevice
  });
  @override
  Widget build(BuildContext context) {
    if (tags != null && infoItem != null) {
      return ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            Icon( 
              EvaIcons.musicOutline,
              color: Theme.of(context).iconTheme.color
            ),
            SizedBox(width: 8),
            Text(
              Languages.of(context)!.labelTags,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Theme.of(context).textTheme.bodyText1!.color
              ),
            ),
          ],
        ),
        trailing: FlexiblePopupMenu(
          borderRadius: 15,
          items: [
            FlexiblePopupItem(
              title: Languages.of(context)!.labelPerformAutomaticTagging,
              value: "AutoTag",
            ),
            FlexiblePopupItem(
              title: Languages.of(context)!.labelSelectTagsfromMusicBrainz,
              value: "SearchMB",
            ),
            FlexiblePopupItem(
              title: Languages.of(context)!.labelSelectArtworkFromDevice,
              value: "FromDevice",
            )
          ],
          onItemTap: (value) async {
            switch (value) {
              case "AutoTag":
                onAutoTag!();
                break;
              case "SearchMB":
                onManualTag!();
                break;
              case "FromDevice":
                onSearchDevice!();
                break;
            }
          },
          child: Padding(
            padding: EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Text(
                    Languages.of(context)!.labelTagsEditor,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          placeholder: MemoryImage(kTransparentImage),
                          image: (isURL(tags!.artworkController!)
                            ? NetworkImage(
                                tags!.artworkController == infoItem!.thumbnails!.hqdefault
                                  ? infoItem!.thumbnails!.hqdefault
                                  : tags!.artworkController!
                              )
                            : FileImage(File(tags!.artworkController!))) as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)
                        ),
                        color: Theme.of(context).cardColor.withOpacity(0.4)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: Icon(EvaIcons.editOutline, size: 18, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        children: [
          // Title TextField
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFieldTile(
                  textController: tags!.titleController,
                  inputType: TextInputType.text,
                  labelText: Languages.of(context)!.labelEditorTitle,
                  icon: EvaIcons.textOutline,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Album & Artist TextField Row
          Row(
            children: <Widget>[
              // Album TextField
              Expanded(
                child: TextFieldTile(
                  textController: tags!.albumController,
                  inputType: TextInputType.text,
                  labelText: Languages.of(context)!.labelEditorAlbum,
                  icon: EvaIcons.bookOpenOutline,
                ),
              ),
              SizedBox(width: 12),
              // Artist TextField
              Expanded(
                child: TextFieldTile(
                  textController: tags!.artistController,
                  inputType: TextInputType.text,
                  labelText: Languages.of(context)!.labelEditorArtist,
                  icon: EvaIcons.personOutline,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Gender & Date TextField Row
          Row(
            children: <Widget>[
              // Gender TextField
              Expanded(
                child: TextFieldTile(
                  textController: tags!.genreController,
                  inputType: TextInputType.text,
                  labelText: Languages.of(context)!.labelEditorGenre,
                  icon: EvaIcons.bookOutline,
                ),
              ),
              SizedBox(width: 12),
              // Date TextField
              Expanded(
                child: TextFieldTile(
                  textController: tags!.dateController,
                  inputType: TextInputType.datetime,
                  labelText: Languages.of(context)!.labelEditorDate,
                  icon: EvaIcons.calendarOutline,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Disk & Track TextField Row
          Row(
            children: <Widget>[
              // Disk TextField
              Expanded(
                child: TextFieldTile(
                  textController: tags!.discController,
                  inputType: TextInputType.number,
                  labelText: Languages.of(context)!.labelEditorDisc,
                  icon: EvaIcons.playCircleOutline
                ),
              ),
              SizedBox(width: 12),
              // Track TextField
              Expanded(
                child: TextFieldTile(
                  textController: tags!.trackController,
                  inputType: TextInputType.number,
                  labelText: Languages.of(context)!.labelEditorTrack,
                  icon: EvaIcons.musicOutline,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}