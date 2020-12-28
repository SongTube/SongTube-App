import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/popupMenu.dart';
import 'package:songtube/ui/components/tagsResultsPage.dart';
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:songtube/ui/internal/snackbar.dart';

class TagsEditorPage extends StatefulWidget {
  final MediaItem song;
  TagsEditorPage({
    @required this.song
  });

  @override
  _TagsEditorPageState createState() => _TagsEditorPageState();
}

class _TagsEditorPageState extends State<TagsEditorPage> {

  TagsControllers tagsControllers;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    tagsControllers = TagsControllers();
    loadTagsControllers();
    super.initState();
  }

  void loadTagsControllers() async {
    tagsControllers.titleController.text = widget.song.title;
    tagsControllers.albumController.text = widget.song.album;
    tagsControllers.artistController.text = widget.song.artist;
    tagsControllers.genreController.text = widget.song.genre == null
      ? "Any" : widget.song.genre;
    tagsControllers.dateController.text = await FFmpegExtractor
      .getAudioDate(widget.song.id);
    tagsControllers.discController.text = await FFmpegExtractor
      .getAudioDisc(widget.song.id);
    tagsControllers.trackController.text = await FFmpegExtractor
      .getAudioTrack(widget.song.id);
    setState(() {});
    tagsControllers.artworkController = (await FFmpegExtractor
      .getAudioArtwork(
        audioFile: widget.song.id,
        audioId: ""
    )).path;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          Languages.of(context).labelTagsEditor.replaceAll("\n", " "),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color
        ),
        actions: [
          FlexiblePopupMenu(
            borderRadius: 15,
            items: [
              FlexiblePopupItem(
                title: Languages.of(context).labelPerformAutomaticTagging,
                value: "AutoTag"
              ),
              FlexiblePopupItem(
                title: Languages.of(context).labelSelectTagsfromMusicBrainz,
                value: "SearchMB"
              ),
            ],
            onItemTap: (value) async {
              switch (value) {
                case "AutoTag":
                  showDialog(
                    context: context,
                    builder: (_) => LoadingDialog()
                  );
                  String lastArtwork = tagsControllers.artworkController;
                  var record = await MusicBrainzAPI
                    .getFirstRecord(tagsControllers.titleController.text);
                  tagsControllers = await MusicBrainzAPI.getSongTags(record);
                  if (tagsControllers.artworkController == null)
                    tagsControllers.artworkController = lastArtwork;
                  Navigator.pop(context);
                  setState(() {});
                  break;
                case "SearchMB":
                  var record = await Navigator.push(context,
                    BlurPageRoute(builder: (context) => 
                      TagsResultsPage(
                        title: tagsControllers.titleController.text,
                        artist: tagsControllers.artistController.text
                      ), blurStrength: prefs.enableBlurUI ? 20 : 0));
                  if (record == null) return;
                  showDialog(
                    context: context,
                    builder: (_) => LoadingDialog()
                  );
                  String lastArtwork = tagsControllers.artworkController;
                  tagsControllers = await MusicBrainzAPI.getSongTags(record);
                  if (tagsControllers.artworkController == null)
                    tagsControllers.artworkController = lastArtwork;
                  Navigator.pop(context);
                  setState(() {});
                  break;
              }
            },
            child: Container(
              padding: EdgeInsets.all(16),
              child: Icon(EvaIcons.moreVerticalOutline,
                color: Theme.of(context).iconTheme.color),
            )
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Hero(
              tag: widget.song.title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                        File(widget.song.extras["artwork"]),
                        fit: BoxFit.cover,
                      ),
                      if (tagsControllers.artworkController != null)
                      FadeInImage(
                        image: isURL(tagsControllers.artworkController)
                          ? NetworkImage(tagsControllers.artworkController)
                          : FileImage(File(tagsControllers.artworkController)),
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () async {
                            File image = File((await FilePicker.platform
                              .pickFiles(type: FileType.image))
                              .paths[0]);
                            if (image == null) return;
                            tagsControllers.artworkController = image.path;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black.withOpacity(0.4)
                            ),
                            child: Icon(EvaIcons.brushOutline,
                              color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Colors.white,
        child: Icon(Icons.save_outlined,
          color: Colors.white),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (_) {
              return LoadingDialog();
            }
          );
          try {
            await mediaProvider.replaceTags(widget.song, tagsControllers);
          } catch (_) {
            Navigator.pop(context);
            AppSnack.showSnackBar(
              icon: Icons.warning,
              title: Languages.of(context).labelAudioFormatNotCompatible,
              duration: Duration(seconds: 2),
              context: context,
              scaffoldKey: scaffoldKey.currentState
            );
            return;
          }
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}