import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/ui/components/textfieldTile.dart';

class VideoPageTagsTextFields extends StatelessWidget {
  final TagsControllers tagsControllers;
  VideoPageTagsTextFields(this.tagsControllers);
  @override
  Widget build(BuildContext context) {
    return Column(
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
                labelText: "Title",
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
                labelText: "Album",
                icon: EvaIcons.bookOpenOutline,
              ),
            ),
            SizedBox(width: 12),
            // Artist TextField
            Expanded(
              child: TextFieldTile(
                textController: tagsControllers.artistController,
                inputType: TextInputType.text,
                labelText: "Artist",
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
                labelText: "Genre",
                icon: EvaIcons.bookOutline,
              ),
            ),
            SizedBox(width: 12),
            // Date TextField
            Expanded(
              child: TextFieldTile(
                textController: tagsControllers.dateController,
                inputType: TextInputType.datetime,
                labelText: "Date",
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
                labelText: "Disc",
                icon: EvaIcons.playCircleOutline
              ),
            ),
            SizedBox(width: 12),
            // Track TextField
            Expanded(
              child: TextFieldTile(
                textController: tagsControllers.trackController,
                inputType: TextInputType.number,
                labelText: "Track",
                icon: EvaIcons.musicOutline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}