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
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/music_brainz_record.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/services/music_brainz_service.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/common_sheet_widget.dart';
import 'package:songtube/ui/components/slideable_panel.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/text_field_tile.dart';
import 'package:songtube/ui/ui_utils.dart';
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
  SlidablePanelController? panelController;
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
    String? url = sharedPreferences.getString('${record.id}artwork');
    if (url != null) {
      return url;
    }
    await Future.delayed(Duration(seconds: index));
    Map<String, String>? map = await MusicBrainzAPI
      .getThumbnails(record.id);
    if (map == null) return null;
    if (map.containsKey("1200x1200")) {
      url = map["1200x1200"]!;
    } else {
      url = map["500x500"]!;
    }
    await sharedPreferences.setString('${record.id}artwork', url);
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
      final result = await UiUtils.showModal(
        context: internalNavigatorKey.currentContext!,
        modal: CommonSheet(
          useCustomScroll: false,
          builder: (context, scrollController) {
            return CommonSheetWidget(
              title: Languages.of(context)!.labelConversionRequired,
              body: Text(Languages.of(context)!.labelConversionRequiredDescription, style: subtitleTextStyle(context, opacity: 0.8)),
              actions: [
                // Cancel Button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(Languages.of(context)!.labelCancel, style: smallTextStyle(context)),
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
                      child: Text(Languages.of(context)!.labelContinue, style: smallTextStyle(context).copyWith(color: Colors.white)),
                    )
                  ),
                ),
              ],
            );
          },
        )
      );
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
        UiUtils.showModal(
          context: internalNavigatorKey.currentContext!,
          modal: CommonSheet(
            useCustomScroll: false,
            builder: (context, scrollController) {
              return CommonSheetWidget(
                title: Languages.of(context)!.labelPermissionRequired,
                body: Text(Languages.of(context)!.labelPermissionRequiredDescription, style: subtitleTextStyle(context, opacity: 0.8)),
                actions: [
                  // Cancel Button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(Languages.of(context)!.labelCancel, style: smallTextStyle(context)),
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
                        child: Text(Languages.of(context)!.labelGrant, style: smallTextStyle(context).copyWith(color: Colors.white)),
                      )
                    ),
                  ),
                ],
              );
            },
          )
        );
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
    const minFloatingPanelSize = kToolbarHeight*1.7;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          // Tags Editor Body
          Column(
            children: [
              Expanded(
                child: _body()
              ),
              const SizedBox(height: minFloatingPanelSize),
            ],
          ),
          // MusicBrainz Results
          Align(
            alignment: Alignment.bottomCenter,
            child: SlidablePanel(
              onControllerCreate: (controller) {
                panelController = controller;
              },
              enableBackdrop: false,
              collapsedColor: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(0),
              backdropOpacity: 1,
              color: Theme.of(context).cardColor,
              maxHeight: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
              minHeight: minFloatingPanelSize,
              padding: 0,
              child: panelController == null ? const SizedBox() : _musicBrainz(),
            ),
          ),
        ],
      ),
    );
  }

  // Tags Editor Body
  Widget _body() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                          Text(Languages.of(context)!.labelTagsEditor, style: textStyle(context).copyWith(color: Colors.white)),
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
                color: Theme.of(context).scaffoldBackgroundColor,
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
        const SizedBox(height: 9),
        // Search Bar
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: TextFormField(
                  controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const AppAnimatedIcon(EvaIcons.textOutline,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      labelText: Languages.of(context)!.labelSelectTagsfromMusicBrainz,
                      labelStyle: smallTextStyle(context, opacity: 0.7)
                    ),
                    style: smallTextStyle(context),
                  onTap: () {
                    panelController!.open();
                  },
                  onFieldSubmitted: (searchQuery) {
                    setState(() => searchController.text = searchQuery);
                    searchForRecords();
                  },
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 16, left: 12),
              icon: const AppAnimatedIcon(EvaIcons.arrowIosForward, size: 20),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                searchForRecords();
              }
            )
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: AnimatedBuilder(
            animation: panelController!.animationController,
            builder: (context, _) {
              return Opacity(
                opacity: Tween<double>(begin: 0, end: 1).animate(panelController!.animationController).value,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12).copyWith(top: 0),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    var record = searchResults[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: _resultTile(record, index),
                    );
                  },
                ),
              );
            }
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
            panelController!.close();
            setState(() {});
          },
          child: SizedBox(
            height: kToolbarHeight*1.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _musicBrainzArtwork(image, index, true),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          record.title,
                          maxLines: 1,
                          style: smallTextStyle(context)
                        ),
                        // Album
                        Text(
                          record.album,
                          maxLines: 1,
                          style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
                        ),
                        // Artist
                        Text(
                          "By ${record.artist}",
                          maxLines: 1,
                          style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
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
        switchInCurve: kAnimationCurve,
        child: image.hasData
          ? Hero(
              tag: "artwork$index",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: fullRound ? const Radius.circular(15) : Radius.zero,
                    bottomRight: fullRound ? const Radius.circular(15) : Radius.zero,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image.data)
                  )
                ),
              ),
            )
          : image.connectionState == ConnectionState.done && !image.hasData
            ? Opacity(
              opacity: 0.6,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/artworkPlaceholder_big.png')
                    )
                  ),
                ),
            )
            : Consumer<MediaProvider>(
              builder: (context, provider, _) {
                return Container(
                  height: kToolbarHeight*1.6,
                  width: kToolbarHeight*1.6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            provider.currentColors.vibrant
                          ),
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }
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
            color: Theme.of(context).cardColor.withOpacity(0.7)
          )
        ],
      ),
    );
  }

  Widget _textfields() {
    final fillColor = Theme.of(context).scaffoldBackgroundColor;
    return ListView(
      
      padding: const EdgeInsets.all(12).copyWith(top: 12, bottom: 12),
      children: [
        // Title TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.titleController,
          inputType: TextInputType.text,
          labelText: Languages.of(context)!.labelEditorTitle,
          icon: EvaIcons.textOutline,
          bottomLine: true,
        ),
        const SizedBox(height: 16),
        // Album & Artist TextField Row
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.albumController,
          inputType: TextInputType.text,
          labelText: Languages.of(context)!.labelEditorAlbum,
          icon: EvaIcons.bookOutline,
          bottomLine: true,
        ),
        const SizedBox(height: 16),
        // Artist TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.artistController,
          inputType: TextInputType.text,
          labelText: Languages.of(context)!.labelEditorArtist,
          icon: EvaIcons.personOutline,
          bottomLine: true,
        ),
        const SizedBox(height: 16),
        // Gender & Date TextField Row
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.genreController,
          inputType: TextInputType.text,
          labelText: Languages.of(context)!.labelEditorGenre,
          icon: EvaIcons.musicOutline,
          bottomLine: true,
        ),
        const SizedBox(height: 16),
        // Date TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.dateController,
          inputType: TextInputType.datetime,
          labelText: Languages.of(context)!.labelEditorDate,
          icon: EvaIcons.calendarOutline,
          bottomLine: true,
        ),
        const SizedBox(height: 16),
        // Disk & Track TextField Row
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.discController,
          inputType: TextInputType.number,
          labelText: Languages.of(context)!.labelEditorDisc,
          icon: EvaIcons.radioButtonOffOutline,
          bottomLine: true,
        ),
        const SizedBox(height: 16),
        // Track TextField
        TextFieldTile(
          fillColor: fillColor,
          textController: tags.trackController,
          inputType: TextInputType.number,
          labelText: Languages.of(context)!.labelEditorTrack,
          icon: EvaIcons.hashOutline,
          bottomLine: true,
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
          // Restore song to default values
          FloatingActionButton(
            heroTag: 'fabSearch',
            backgroundColor: Theme.of(context).cardColor,
            child: const AppAnimatedIcon(EvaIcons.undoOutline, size: 22),
            onPressed: () {
              setState(() {
                tags = originalTags;
              });
            },
          ),
          const SizedBox(width: 12),
          // Save Audio Information
          FloatingActionButton.extended(
            heroTag: 'fabSave',
            backgroundColor: Theme.of(context).cardColor,
            label: Row(
              children: [
                const AppAnimatedIcon(EvaIcons.edit2Outline),
                const SizedBox(width: 12),
                Text(
                  processingTags ? '${Languages.of(context)!.labelApplying}...' : Languages.of(context)!.labelApply,
                  style: subtitleTextStyle(context, bold: true).copyWith()
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
                UiUtils.showModal(
                  context: internalNavigatorKey.currentContext!,
                  modal: CommonSheet(
                    useCustomScroll: false,
                    builder: (context, scrollController) {
                      return CommonSheetWidget(
                        title: Languages.of(context)!.labelConverting,
                        body: Text(Languages.of(context)!.labelConvertingDescription, style: subtitleTextStyle(context, opacity: 0.8)),
                      );
                    },
                  )
                );
                final result = await FFmpegConverter.convertAudio(audioFile: song.path, task: FFmpegTask.convertToAAC, checkFormat: false);
                if (await result.exists()) {
                  final cleanedFiled = await FFmpegConverter.clearFileMetadata(result.path);
                  await cleanedFiled.copy(song.path);
                  await cleanedFiled.delete();
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
              UiUtils.showModal(
                context: internalNavigatorKey.currentContext!,
                modal: CommonSheet(
                  useCustomScroll: false,
                  builder: (context, scrollController) {
                    return CommonSheetWidget(
                      title: Languages.of(context)!.labelWrittingTagsAndArtwork,
                      body: Text(Languages.of(context)!.labelWrittingTagsAndArtworkDescription, style: subtitleTextStyle(context, opacity: 0.8)),
                    );
                  },
                )
              );
              await MediaUtils.writeMetadata(widget.song.id, tags);
              tagger.AudioTagger.updateMediaStore(widget.song.id);
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