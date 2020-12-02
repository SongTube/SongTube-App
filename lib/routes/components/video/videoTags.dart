import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoTags extends StatelessWidget {
  final TagsControllers tagsControllers;
  final String artworkUrl;
  final Function onArtworkTap;
  VideoTags({
    this.tagsControllers,
    this.artworkUrl,
    this.onArtworkTap
  });
  @override
  Widget build(BuildContext context) {
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
            "Tags",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
        ],
      ),
      trailing: GestureDetector(
        onTap: onArtworkTap,
        child: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  Languages.of(context).labelEditArtwork,
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
                        image: isURL(artworkUrl)
                          ? NetworkImage(artworkUrl)
                          : FileImage(File(artworkUrl)),
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
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
                textController: tagsControllers.titleController,
                inputType: TextInputType.text,
                labelText: Languages.of(context).labelEditorTitle,
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
                textController: tagsControllers.albumController,
                inputType: TextInputType.text,
                labelText: Languages.of(context).labelEditorAlbum,
                icon: EvaIcons.bookOpenOutline,
              ),
            ),
            SizedBox(width: 12),
            // Artist TextField
            Expanded(
              child: TextFieldTile(
                textController: tagsControllers.artistController,
                inputType: TextInputType.text,
                labelText: Languages.of(context).labelEditorArtist,
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
                textController: tagsControllers.genreController,
                inputType: TextInputType.text,
                labelText: Languages.of(context).labelEditorGenre,
                icon: EvaIcons.bookOutline,
              ),
            ),
            SizedBox(width: 12),
            // Date TextField
            Expanded(
              child: TextFieldTile(
                textController: tagsControllers.dateController,
                inputType: TextInputType.datetime,
                labelText: Languages.of(context).labelEditorDate,
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
                textController: tagsControllers.discController,
                inputType: TextInputType.number,
                labelText: Languages.of(context).labelEditorDisc,
                icon: EvaIcons.playCircleOutline
              ),
            ),
            SizedBox(width: 12),
            // Track TextField
            Expanded(
              child: TextFieldTile(
                textController: tagsControllers.trackController,
                inputType: TextInputType.number,
                labelText: Languages.of(context).labelEditorTrack,
                icon: EvaIcons.musicOutline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}