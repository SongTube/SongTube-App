import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:audio_tagger/audio_tagger.dart' as tagger;
import 'package:device_info_plus/device_info_plus.dart';
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
import 'package:songtube/internal/ffmpeg/converter.dart';
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
import 'package:songtube/ui/components/slideable_panel.dart';
import 'package:songtube/ui/components/text_icon_button.dart';
import 'package:songtube/ui/sheet_phill.dart';
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

  // Do not show again conversion checkbox
  bool get hideConversionPopup => sharedPreferences.getBool('hideConversionPopup') ?? false;
  set hideConversionPopup(bool value) {
    sharedPreferences.setBool('hideConversionPopup', value);
  }

  // Default image getter
  Future<File> getAlbumImage() async {
    await ArtworkManager.writeArtwork(widget.song.id);
    return artworkFile(widget.song.id);
  }

  AudioTags tags = AudioTags();
  AudioTags originalTags = AudioTags();

  // MusicBrainz Search
  late SlidablePanelController panelController;
  late TextEditingController searchController = TextEditingController()..text = widget.song.title;
  List<MusicBrainzRecord> searchResults = [];
  void searchForRecords() async {
    final result = await MusicBrainzAPI.getRecordings(searchController.text);
    searchResults.clear();
    for (var element in result) {
      searchResults.add(MusicBrainzRecord.fromMap(element));
    }
    setState(() {});
  }
  Future<String?> _getArtworkLink(MusicBrainzRecord record, int index) async {
    await Future.delayed(Duration(seconds: index));
    Map<String, String>? map = await MusicBrainzAPI
      .getThumbnails(record.id);
    if (map == null) return null;
    String url;
    if (map.containsKey("1200x1200")) {
      url = map["1200x1200"]!;
    } else {
      url = map["500x500"]!;
    }
    return url;
  }

  // Writting Tags Status
  bool processingTags = false;

  @override
  void initState() {
    checkPermissions().then((_) {
      isSongCompatible().then((_) {
        loadTagsControllers();
      });
    });
    // Search MusicBrainz
    searchForRecords();
    super.initState();
  }

  // Requires Conversion
  bool requiresConversion = false;

  // Check for the song to be compatible
  Future<void> isSongCompatible() async {
    final result = await FFmpegConverter.getMediaFormat(widget.song.id);
    if (result != 'm4a') {
      // Promt the user if he agrees that his songs needs to be converted to apply tags
      final result = await showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
        return CommonSheet(
          title: 'Conversion required',
          body: Text('This song format is incompatible with the ID3 Tags editor. The app will automatically convert this song to AAC (m4a) to sort out this issue.', style: subtitleTextStyle(context, opacity: 0.8)),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
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
                  Navigator.pop(context, true);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text('Continue', style: smallTextStyle(context).copyWith(color: Colors.white)),
                )
              ),
            ),
          ],
        );
      });
      if (result ?? false) {
        setState(() {
          requiresConversion = true;
        });
      } else {
        
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  // Check for all file access permissions
  Future<void> checkPermissions() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    if ((deviceInfo.version.sdkInt ?? 29) >= 30) {
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
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    final double minFloatingPanelSize = MediaQuery.of(context).size.height*0.3;
    return Material(
      color: Theme.of(context).cardColor,
      child: Stack(
        children: [
          // Tags Editor Body
          Column(
            children: [
              Expanded(
                child: _body()
              ),
              SizedBox(height: minFloatingPanelSize),
            ],
          ),
          // MusicBrainz Results
          SlidablePanel(
            onControllerCreate: (controller) {
              panelController = controller;
            },
            enableBackdrop: false,
            collapsedColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            backdropColor: Theme.of(context).scaffoldBackgroundColor,
            backdropOpacity: 1,
            color: Theme.of(context).scaffoldBackgroundColor,
            maxHeight: MediaQuery.of(context).size.height-kToolbarHeight,
            minHeight: minFloatingPanelSize,
            child: _musicBrainz()
          ),
        ],
      ),
    );
  }

  // Tags Editor Body
  Widget _body() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            onPressed: () async {
                              final image = await FilePicker.platform.pickFiles(
                                type: FileType.image,
                              );
                              if (image != null && image.files.isNotEmpty) {
                                tags.artwork = image.files.first.path!;
                                setState(() {});
                              }
                            },
                            icon: const Icon(Iconsax.image, color: Colors.white),
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
        ],
      ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        margin: const EdgeInsets.only(bottom: 12),
        child: _floatingButtons()),
    );
  }

  // Music Brainz Results
  Widget _musicBrainz() {
    return Column(
      children: [
        const SizedBox(height: 12),
        const BottomSheetPhill(),
        const SizedBox(height: 12),
        // Search Bar
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: TextFormField(
                  controller: searchController,
                  style: subtitleTextStyle(context),
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none
                  ),
                  onTap: () {
                    panelController.open();
                  },
                  onFieldSubmitted: (searchQuery) {
                    setState(() => searchController.text = searchQuery);
                    searchForRecords();
                  },
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 24, left: 12),
              icon: const Icon(EvaIcons.searchOutline, size: 22),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                searchForRecords();
              }
            )
          ],
        ),
        const SizedBox(height: 12),
        Divider(height: 1, color: Theme.of(context).dividerColor,),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            addAutomaticKeepAlives: true,
            physics: const BouncingScrollPhysics(),
            cacheExtent: 9999999,
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              var record = searchResults[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _resultTile(record, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _resultTile(MusicBrainzRecord record, int index) {
    return FutureBuilder(
      future: _getArtworkLink(record, index),
      builder: (context, image) {
        return GestureDetector(
          onTap: () async {
            tags = AudioTags.withMusicBrainzRecord(record)..artwork = image.data;
            panelController.close();
            setState(() {});
          },
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _musicBrainzArtwork(image, index, true),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          record.title,
                          maxLines: 1,
                          style: subtitleTextStyle(context, bold: true)
                        ),
                        // Album
                        Text(
                          record.album,
                          maxLines: 1,
                          style: smallTextStyle(context, opacity: 0.8)
                        ),
                        // Artist
                        Text(
                          "By ${record.artist}",
                          maxLines: 1,
                          style: smallTextStyle(context, opacity: 0.8)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _musicBrainzArtwork(AsyncSnapshot image, int index, bool fullRound) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: image.hasData
          ? Hero(
              tag: "artwork$index",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: fullRound ? const Radius.circular(10) : Radius.zero,
                    bottomRight: fullRound ? const Radius.circular(10) : Radius.zero,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image.data)
                  )
                ),
              ),
            )
          : image.connectionState == ConnectionState.done && !image.hasData
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/artworkPlaceholder_big.png')
                  )
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).primaryColor
                  ),
                ),
              )
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
          ImageFade(
            fadeDuration: const Duration(milliseconds: 300),
            image: isURL(tags.artwork)
              ? NetworkImage(tags.artwork)
              : FileImage(File(tags.artwork)) as ImageProvider,
            placeholder: Image.memory(kTransparentImage),
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
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Search on MusicBrainz
          FloatingActionButton(
            heroTag: 'fabSearch',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.white,
            child: const Icon(Iconsax.undo),
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
              // Convert song if needed
              if (requiresConversion) {
                File song = File(widget.song.id);
                showModalBottomSheet(context: internalNavigatorKey.currentContext!, isDismissible: false, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                  return CommonSheet(
                    title: 'Converting Song...',
                    body: Text('Re-encoding this song into AAC (m4a) format', style: subtitleTextStyle(context, opacity: 0.8)),
                  );
                });
                final result = await FFmpegConverter.convertAudio(audioFile: song.path, task: FFmpegTask.convertToAAC, checkFormat: false);
                if (await result.exists()) {
                  final cleanedFiled = await FFmpegConverter.clearFileMetadata(result.path);
                  await cleanedFiled.copy(song.path);
                  await cleanedFiled.delete();
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
              showModalBottomSheet(context: internalNavigatorKey.currentContext!, isDismissible: false, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                return CommonSheet(
                  title: 'Writting Tags...',
                  body: Text('Applying new tags to this song', style: subtitleTextStyle(context, opacity: 0.8)),
                );
              });
              await MediaUtils.writeMetadata(widget.song.id, tags);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
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

}