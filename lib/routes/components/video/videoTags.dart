import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/popupMenu.dart';
import 'package:songtube/ui/components/tagsResultsPage.dart';
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    Video videoDetails =  manager.mediaInfoSet.videoDetails;
    TagsControllers tagsControllers = manager.mediaInfoSet.mediaTags;
    String artworkUrl = tagsControllers.artworkController;
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
            Languages.of(context).labelTags,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
        ],
      ),
      trailing: FlexiblePopupMenu(
        borderRadius: 15,
        items: [
          FlexiblePopupItem(
            title: Languages.of(context).labelSelectTagsfromMusicBrainz,
            value: "AutoTag",
          ),
          FlexiblePopupItem(
            title: Languages.of(context).labelSelectTagsfromMusicBrainz,
            value: "SearchMB",
          ),
          FlexiblePopupItem(
            title: Languages.of(context).labelSelectArtworkFromDevice,
            value: "FromDevice",
          )
        ],
        onItemTap: (value) async {
          switch (value) {
            case "AutoTag":
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              String lastArtwork = manager.mediaInfoSet.mediaTags.artworkController;
              var record = await MusicBrainzAPI
                .getFirstRecord(manager.mediaInfoSet.mediaTags.titleController.text);
              manager.mediaInfoSet.mediaTags = await MusicBrainzAPI.getSongTags(record);
              if (manager.mediaInfoSet.mediaTags.artworkController == null)
                manager.mediaInfoSet.mediaTags.artworkController = lastArtwork;
              Navigator.pop(context);
              manager.setState();
              break;
            case "SearchMB":
              var record = await Navigator.push(context,
                BlurPageRoute(builder: (context) => 
                  TagsResultsPage(
                    title: manager.mediaInfoSet.mediaTags.titleController.text,
                    artist: manager.mediaInfoSet.mediaTags.artistController.text
                  )));
              if (record == null) return;
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              String lastArtwork = manager.mediaInfoSet.mediaTags.artworkController;
              manager.mediaInfoSet.mediaTags = await MusicBrainzAPI.getSongTags(record);
              if (manager.mediaInfoSet.mediaTags.artworkController == null)
                manager.mediaInfoSet.mediaTags.artworkController = lastArtwork;
              Navigator.pop(context);
              break;
            case "FromDevice":
              File image = File((await FilePicker.platform
                .pickFiles(type: FileType.image))
                .paths[0]);
              if (image == null) return;
              manager.mediaInfoSet.mediaTags
                .artworkController = image.path;
              manager.setState();
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
                  Languages.of(context).labelTagsEditor,
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
                          ? NetworkImage(
                              artworkUrl == videoDetails.thumbnails.maxResUrl
                                ? videoDetails.thumbnails.mediumResUrl
                                : artworkUrl
                            )
                          : FileImage(File(artworkUrl)),
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