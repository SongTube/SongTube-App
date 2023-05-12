import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:audio_tagger/audio_tagger.dart' as tagger;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/music_brainz_record.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/main.dart';
import 'package:songtube/pages/music_brainz_search.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/services/music_brainz_service.dart';
import 'package:songtube/ui/animations/blue_page_route.dart';
import 'package:songtube/ui/components/custom_snackbar.dart';
import 'package:songtube/ui/components/text_icon_button.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/text_field_tile.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:validators/validators.dart';

class ID3Editor extends StatefulWidget {
  const ID3Editor({
    required this.song,
    Key? key
  }) : super(key: key);
  final MediaItem song;
  @override
  // ignore: library_private_types_in_public_api
  _ID3EditorState createState() => _ID3EditorState();
}

class _ID3EditorState extends State<ID3Editor> {

  // Default image getter
  Future<File> getAlbumImage() async {
    await ArtworkManager.writeArtwork(widget.song.id);
    return artworkFile(widget.song.id);
  }

  AudioTags tags = AudioTags();
  AudioTags originalTags = AudioTags();

  // Writting Tags Status
  bool processingTags = false;

  @override
  void initState() {
    loadTagsControllers();
    checkPermissions();
    super.initState();
  }

  // Check for all file access permissions
  void checkPermissions() async {
    final status = await Permission.manageExternalStorage.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      // Show Bottom Sheet
      showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
        return CommonSheet(
          title: 'Permissions required',
          body: Text('All file access permission is required for SongTube to edit any song on your device', style: subtitleTextStyle(context, opacity: 0.8)),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text('Cancel', style: smallTextStyle(context)),
              )
            ),
            // Delete button
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(100)
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  final result = await Permission.manageExternalStorage.request();
                  if (result.isDenied || result.isPermanentlyDenied) {
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text('Grant', style: smallTextStyle(context).copyWith(color: Colors.white)),
                )
              ),
            ),
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
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
            aspectRatio: (16/9),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _artworkImage()
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: MediaQuery.of(context).padding.top),
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Iconsax.arrow_left, color: Colors.white)
                          ), 
                          Text('Tags Editor', style: textStyle(context).copyWith(color: Colors.white)),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              manualWriteTags();
                            },
                            icon: const Icon(Iconsax.search_normal, color: Colors.white),
                          ), 
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _textfields(),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
            margin: const EdgeInsets.only(bottom: 34),
            child: _floatingButtons())
        ],
      ),
    );
  }

  Widget _artworkImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          if (tags.artwork != null)
          FadeInImage(
            fadeInDuration: const Duration(milliseconds: 300),
            image: isURL(tags.artwork)
              ? NetworkImage(tags.artwork)
              : FileImage(File(tags.artwork)) as ImageProvider,
            placeholder: MemoryImage(kTransparentImage),
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          )
        ],
      ),
    );
  }

  Widget _textfields() {
    final fillColor = Theme.of(context).cardColor;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16).copyWith(top: 12, bottom: 12),
      children: [
        // Title TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.titleController,
          inputType: TextInputType.text,
          labelText: 'Title',
          icon: Iconsax.text,
        ),
        const SizedBox(height: 16),
        // Album & Artist TextField Row
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.albumController,
          inputType: TextInputType.text,
          labelText: 'Album',
          icon: Iconsax.book,
        ),
        const SizedBox(height: 16),
        // Artist TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.artistController,
          inputType: TextInputType.text,
          labelText: 'Artist',
          icon: Iconsax.user,
        ),
        const SizedBox(height: 16),
        // Gender & Date TextField Row
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.genreController,
          inputType: TextInputType.text,
          labelText: 'Genre',
          icon: Iconsax.musicnote,
        ),
        const SizedBox(height: 16),
        // Date TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.dateController,
          inputType: TextInputType.datetime,
          labelText: 'Date',
          icon: Iconsax.calendar,
        ),
        const SizedBox(height: 16),
        // Disk & Track TextField Row
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.discController,
          inputType: TextInputType.number,
          labelText: 'Disc',
          icon: Iconsax.happyemoji4
        ),
        const SizedBox(height: 16),
        // Track TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.trackController,
          inputType: TextInputType.number,
          labelText: 'Track',
          icon: Iconsax.sound4,
        ),
        const Divider(color: Colors.transparent),
      ],
    );
  }

  Widget _floatingButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Search on MusicBrainz
          FloatingActionButton.extended(
            heroTag: 'fabSearch',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.white,
            label: Row(
              children: [
                Icon(Iconsax.undo,
                  color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Text(
                  'Restore Tags',
                  style: subtitleTextStyle(context, bold: true),
                )
              ],
            ),
            onPressed: () {
              setState(() {
                tags = originalTags;
              });
            },
          ),
          const SizedBox(width: 16),
          // Save Audio Information
          FloatingActionButton.extended(
            heroTag: 'fabSave',
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            label: Row(
              children: [
                const Icon(Iconsax.save_2,
                  color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  processingTags ? 'Applying...' : 'Apply',
                  style: subtitleTextStyle(context, bold: true)
                )
              ],
            ),
            onPressed: () async {
              setState(() {
                processingTags = true;
              });
              final status = await MediaUtils.writeMetadata(widget.song.id, tags);
              if (status != null) {
                CustomSnackbar.showSnackBar(
                  icon: Iconsax.warning_2,
                  title: 'Audio format not compatible',
                  duration: const Duration(seconds: 2),
                  context: context,
                );
              }
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void loadTagsControllers() async {
    final artwork = await getAlbumImage();
    final audioTags = await tagger.AudioTagger.extractAllTags(widget.song.id);
    tags.titleController.text = audioTags?.title ?? widget.song.title;
    tags.albumController.text = audioTags?.album ?? widget.song.album!;
    tags.artistController.text = audioTags?.artist ?? widget.song.artist ?? 'Unknown';
    tags.genreController.text = audioTags?.genre ?? widget.song.genre ?? 'Unknown';
    tags.dateController.text = audioTags?.year ?? '';
    tags.discController.text = audioTags?.disc ?? '';
    tags.trackController.text = audioTags?.track ?? '';
    setState(() {});
    tags.artwork = artwork.path;
    originalTags = tags;
    setState(() {});
  }

  void manualWriteTags() async {
    MusicBrainzRecord? record = await Navigator.push(context,
      BlurPageRoute(builder: (context) => 
        MusicBrainzSearch(
          title: tags.titleController.text,
          artist: tags.artistController.text),
        ));
    if (record == null) return;
    String lastArtwork = tags.artwork;
    tags = await MusicBrainzAPI.getSongTags(record);
    tags.artwork ??= lastArtwork;
    setState(() {});
  }

}