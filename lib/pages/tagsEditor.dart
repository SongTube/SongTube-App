import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:audio_tagger/audio_tagger.dart';
import 'package:audio_tagger/audio_tags.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/internal/popupMenu.dart';
import 'package:songtube/pages/musicBrainzResults.dart';
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
  String originalArtwork;

  @override
  void initState() {
    tagsControllers = TagsControllers();
    loadTagsControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4/3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _artworkImage(),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    Languages.of(context).labelTagsEditor.replaceAll("\n", " "),
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () async {
                        File image = File((await FilePicker.platform
                          .pickFiles(type: FileType.image))
                          .paths[0]);
                        if (image == null) return;
                        tagsControllers.artworkController = image.path;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: Icon(EvaIcons.brushOutline,
                          color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: Offset(0, -60),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  )
                ),
                child: _textfields(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _floatingButtons(),
    );
  }

  Widget _artworkImage() {
    return AspectRatio(
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
        ],
      ),
    );
  }

  Widget _textfields() {
    return ListView(
      padding: EdgeInsets.all(16).copyWith(top: 20, bottom: 50),
      children: [
        // Title TextField
        TextFieldTile(
          textController: tagsControllers.titleController,
          inputType: TextInputType.text,
          labelText: Languages.of(context).labelEditorTitle,
          icon: EvaIcons.textOutline,
        ),
        SizedBox(height: 16),
        // Album & Artist TextField Row
        TextFieldTile(
          textController: tagsControllers.albumController,
          inputType: TextInputType.text,
          labelText: Languages.of(context).labelEditorAlbum,
          icon: EvaIcons.bookOpenOutline,
        ),
        SizedBox(height: 16),
        // Artist TextField
        TextFieldTile(
          textController: tagsControllers.artistController,
          inputType: TextInputType.text,
          labelText: Languages.of(context).labelEditorArtist,
          icon: EvaIcons.personOutline,
        ),
        SizedBox(height: 16),
        // Gender & Date TextField Row
        TextFieldTile(
          textController: tagsControllers.genreController,
          inputType: TextInputType.text,
          labelText: Languages.of(context).labelEditorGenre,
          icon: EvaIcons.bookOutline,
        ),
        SizedBox(height: 16),
        // Date TextField
        TextFieldTile(
          textController: tagsControllers.dateController,
          inputType: TextInputType.datetime,
          labelText: Languages.of(context).labelEditorDate,
          icon: EvaIcons.calendarOutline,
        ),
        SizedBox(height: 16),
        // Disk & Track TextField Row
        TextFieldTile(
          textController: tagsControllers.discController,
          inputType: TextInputType.number,
          labelText: Languages.of(context).labelEditorDisc,
          icon: EvaIcons.playCircleOutline
        ),
        SizedBox(height: 16),
        // Track TextField
        TextFieldTile(
          textController: tagsControllers.trackController,
          inputType: TextInputType.number,
          labelText: Languages.of(context).labelEditorTrack,
          icon: EvaIcons.musicOutline,
        ),
        Divider(color: Colors.transparent),
        ListTile(
          onTap: () {
            setState(() {
              tagsControllers.artworkController =
              originalArtwork;
            });
          },
          title: Text(
            "Restore Artwork",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w800
            ),
          ),
        ),
      ],
    );
  }

  Widget _floatingButtons() {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Search on MusicBrainz
        FloatingActionButton(
          heroTag: 'fabSearch',
          backgroundColor: Theme.of(context).cardColor,
          foregroundColor: Colors.white,
          child: Icon(Icons.search,
            color: Theme.of(context).accentColor),
          onPressed: () async {
            manualWriteTags();
          },
        ),
        SizedBox(width: 16),
        // Save Audio Information
        FloatingActionButton.extended(
          heroTag: 'fabSave',
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
          label: Row(
            children: [
              Icon(Icons.save_outlined,
                color: Colors.white),
              SizedBox(width: 8),
              Text('Save', style: TextStyle(
                fontWeight: FontWeight.w700
              ))
            ],
          ),
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
              );
              return;
            }
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void loadTagsControllers() async {
    AudioTags tags = await AudioTagger.extractAllTags(widget.song.id);
    tagsControllers.titleController.text = tags.title;
    tagsControllers.albumController.text = tags.album;
    tagsControllers.artistController.text = tags.artist;
    tagsControllers.genreController.text = tags.genre == null
      ? "Any" : tags.genre;
    tagsControllers.dateController.text = tags.year;
    tagsControllers.discController.text = tags.disc;
    tagsControllers.trackController.text = tags.track;
    setState(() {});
    tagsControllers.artworkController = widget.song.extras['artwork'];
    originalArtwork = this.tagsControllers.artworkController;
    setState(() {});
  }

  void manualWriteTags() async {
    MusicBrainzRecord record = await Navigator.push(context,
      BlurPageRoute(builder: (context) => 
        TagsResultsPage(
          title: tagsControllers.titleController.text,
          artist: tagsControllers.artistController.text),
        blurStrength: Provider.of<PreferencesProvider>
          (context, listen: false).enableBlurUI ? 20 : 0));
    if (record == null) return;
    showDialog(
      context: context,
      builder: (_) => LoadingDialog()
    );
    String lastArtwork = tagsControllers.artworkController;
    tagsControllers = await MusicBrainzAPI.getSongTags(record, artworkLink: record.artwork);
    if (tagsControllers.artworkController == null)
      tagsControllers.artworkController = lastArtwork;
    Navigator.pop(context);
    setState(() {});
  }

}