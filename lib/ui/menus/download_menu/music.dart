// Flutter
import 'dart:io';

import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/enums/download_type.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/ffmpeg/filters.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/internal/models/music_brainz_record.dart';
import 'package:songtube/internal/models/stream_segment_track.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/pages/music_brainz_search.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/services/music_brainz_service.dart';
import 'package:songtube/ui/animations/blue_page_route.dart';
import 'package:songtube/ui/animations/fade_in.dart';
import 'package:songtube/ui/components/flexible_popup_menu.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/text_field_tile.dart';
import 'package:songtube/ui/ui_utils.dart';
import 'package:validators/validators.dart';

class AudioDownloadMenu extends StatefulWidget {
  final YoutubeVideo video;
  final Function() onBack;
  const AudioDownloadMenu({
    required this.video,
    required this.onBack,
    Key? key,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AudioDownloadMenuState createState() => _AudioDownloadMenuState();
}

class _AudioDownloadMenuState extends State<AudioDownloadMenu> with TickerProviderStateMixin {

  // Audio Settings
  late AudioOnlyStream selectedAudio = widget.video.audioWithBestAacQuality ?? widget.video.audioWithHighestQuality!;

  // Tags Controller
  late AudioTags mainTags = AudioTags.withStreamInfoItem(widget.video.toStreamInfoItem());

  // Audio Features
  bool showAudioFeatures = false;
  AudioFilters filters = AudioFilters();

  // Current Tags
  bool showTags = false;

  // Converter options
  bool enableConversion = false;

  // Segment tracks
  List<StreamSegmentTrack> segmentTracks = [];

  // Download by segments, if this is enabled, the final downloaded
  // audio will be split the choosen segments
  bool segmentedDownload = false;
  bool showSegmentedDownload = false;
  bool createMusicPlaylistWithSegments = false;

  // Flag indicating if the auto tagger is running or not, to make
  // sure we don't run it again and then cause chaos and destruction
  bool autoTaggerRunning = false;

  @override
  void initState() {
    if (widget.video.segments?.isNotEmpty ?? false) {
      for (var segment in widget.video.segments!) {
        final title = segment.title;
        final previewUrl = segment.previewUrl;
        AudioTags audioTags = AudioTags.withStreamInfoItem(widget.video.toStreamInfoItem())
          ..titleController.text = title ?? widget.video.videoInfo.name ?? 'Unknown'
          ..artwork = previewUrl;
        segmentTracks.add(StreamSegmentTrack(audioTags: audioTags, segment: segment, enabled: true));
      }
    }
    super.initState();
  }

  // Process all information and run this music by the downloader
  void onDownload() {
    final downloadInfo = DownloadInfo(
      url: widget.video.videoInfo.url!,
      name: widget.video.videoInfo.name ?? 'Unknown',
      duration: widget.video.videoInfo.length!,
      downloadType: DownloadType.audio,
      audioStream: selectedAudio,
      segmentTracks: segmentedDownload ? segmentTracks : null,
      tags: mainTags,
      createMusicPlaylistFromSegments: createMusicPlaylistWithSegments,
      conversionTask: enableConversion ? AppSettings.defaultFfmpegTask : null
    )..filters = filters;
    final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
    downloadProvider.handleDownloadItem(info: downloadInfo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12).copyWith(top: kToolbarHeight),
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
            // Menu Title
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.onBack,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('Music', style: textStyle(context)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: GestureDetector(
                onTap: () async {
                  final MusicBrainzRecord? record = await UiUtils.pushRouteAsync(context, MusicBrainzSearch(title: mainTags.titleController.text, artist: mainTags.artistController.text));
                  if (record == null) return;
                  setState(() {
                    mainTags = AudioTags.withMusicBrainzRecord(record)..artwork = record.artwork;
                  });
                },
                child: Container(
                  height: 130,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1/1,
                        child: Stack(
                          fit: StackFit.passthrough,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12,
                                    color: Colors.black.withOpacity(0.3)
                                  )
                                ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ImageFade(
                                  fadeDuration: const Duration(milliseconds: 300),
                                  placeholder: Container(color: Theme.of(context).cardColor),
                                  image: isURL(mainTags.artwork)
                                    ? NetworkImage(mainTags.artwork) as ImageProvider
                                    : FileImage(File(mainTags.artwork)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4)
                                  ),
                                  child: const Icon(EvaIcons.brushOutline,
                                    color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mainTags.titleController.text,
                                style: subtitleTextStyle(context),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                mainTags.artistController.text,
                                style: smallTextStyle(context, opacity: 0.7),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: DropdownButton<String>(
                                      value: selectedAudio.formatName == "m4a" ? "AAC" : "OGG",
                                      iconSize: 18,
                                      borderRadius: BorderRadius.circular(20),
                                      iconEnabledColor: Theme.of(context).primaryColor,
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12
                                      ),
                                      underline: Container(),
                                      items: const [
                                        DropdownMenuItem(
                                          value: "AAC",
                                          child: Text("AAC"),
                                        ),
                                        DropdownMenuItem(
                                          value: "OGG",
                                          child: Text("OGG"),
                                        )
                                      ],
                                      onChanged: (String? value) {
                                        if (value == "AAC") {
                                          setState(() => selectedAudio = widget.video.audioWithBestAacQuality!);
                                        } else if (value == "OGG") {
                                          setState(() => selectedAudio = widget.video.audioWithBestOggQuality!);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    height: 30,
                                    child: DropdownButton<String>(
                                      value: "${selectedAudio.averageBitrate}",
                                      borderRadius: BorderRadius.circular(20),
                                      iconSize: 18,
                                      iconEnabledColor: Theme.of(context).primaryColor,
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12
                                      ),
                                      underline: Container(),
                                      items: selectedAudio.formatName == "m4a"
                                        ? List.generate(getSpecificAudioCodecList("m4a").length, (index) => 
                                            DropdownMenuItem(
                                              value: "${getSpecificAudioCodecList("m4a")[index].averageBitrate}",
                                              child: Text("${getSpecificAudioCodecList("m4a")[index].averageBitrate} Kbps/s"),
                                          )).reversed.toList()
                                        : List.generate(getSpecificAudioCodecList("ogg").length, (index) => 
                                            DropdownMenuItem(
                                              value: "${getSpecificAudioCodecList("ogg")[index].averageBitrate}",
                                              child: Text("${getSpecificAudioCodecList("ogg")[index].averageBitrate} Kbps/s"),
                                          )).reversed.toList(),
                                      onChanged: (String? value) {
                                        String codec = selectedAudio.formatName == "m4a" ? "m4a" : "ogg";
                                        int index = getSpecificAudioCodecList(codec).indexWhere((element) => element.averageBitrate.toString() == value);
                                        setState(() => selectedAudio = getSpecificAudioCodecList(codec)[index]);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () => setState(() => mainTags = AudioTags.withStreamInfoItem(widget.video.toStreamInfoItem())),
                                    borderRadius: BorderRadius.circular(50),
                                    child: Ink(
                                      color: Colors.transparent,
                                      child: Icon(EvaIcons.undoOutline,
                                        color: Theme.of(context).primaryColor,
                                        size: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
        
            // Menu body, contains all the pre-download user controls
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: _menuBody(),
            ),
            const SizedBox(height: 8),
        
            GestureDetector(
              onTap: () => onDownload(),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Download',
                      style: textStyle(context).copyWith(color: Colors.white)
                    ),
                    const SizedBox(width: 4),
                    const Icon(EvaIcons.downloadOutline,
                      size: 28,
                      color: Colors.white)
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget _menuBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tags editor textfields
        _tagsEditor(),
        const SizedBox(height: 4),
        // Audio features controls
        _audioFeatures(),
        const SizedBox(height: 4),
        // Enable/Disable segmented download
        if (widget.video.segments?.isNotEmpty ?? false) 
        _segmentsDownload(),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _tagsEditor() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => showTags = !showTags),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Ink(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(EvaIcons.editOutline,
                    color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Tags Editor',
                    style: subtitleTextStyle(context, bold: true)
                  ),
                  const Spacer(),
                  Icon(showTags ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).iconTheme.color),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          child: showTags ? FadeInTransition(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 250),
            child: Column(
              children: [
                const SizedBox(height: 12),
                // Title TextField
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.titleController,
                        inputType: TextInputType.text,
                        labelText: 'Title',
                        icon: EvaIcons.textOutline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Album & Artist TextField Row
                Row(
                  children: <Widget>[
                    // Album TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.albumController,
                        inputType: TextInputType.text,
                        labelText: 'Album',
                        icon: EvaIcons.bookOpenOutline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Artist TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.artistController,
                        inputType: TextInputType.text,
                        labelText: 'Artist',
                        icon: EvaIcons.personOutline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Gender & Date TextField Row
                Row(
                  children: <Widget>[
                    // Gender TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.genreController,
                        inputType: TextInputType.text,
                        labelText: 'Genre',
                        icon: EvaIcons.bookOutline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Date TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.dateController,
                        inputType: TextInputType.datetime,
                        labelText: 'Date',
                        icon: EvaIcons.calendarOutline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Disk & Track TextField Row
                Row(
                  children: <Widget>[
                    // Disk TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.discController,
                        inputType: TextInputType.number,
                        labelText: 'Disc',
                        icon: EvaIcons.playCircleOutline
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Track TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: mainTags.trackController,
                        inputType: TextInputType.number,
                        labelText: 'Track',
                        icon: EvaIcons.musicOutline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) : Container(),
        ),
      ],
    );
  }

  Widget _audioFeatures() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => showAudioFeatures = !showAudioFeatures),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Ink(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(EvaIcons.musicOutline,
                    color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    "Audio Features",
                    style: subtitleTextStyle(context, bold: true)
                  ),
                  const Spacer(),
                  Icon(showAudioFeatures ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).iconTheme.color),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          child: showAudioFeatures ? FadeInTransition(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 250),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Volume Gain
                  Text(
                    'Volume Boost',
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),
                  ),
                  _audioFeatureSlider(
                    min: 0, max: 100,
                    limitsSuffix: "%",
                    onChanged: (double value) {
                      setState(() => filters.volume = value/100);
                    },
                    value: filters.volume*100,
                    tooltip: "${(filters.volume*100).round()}%"
                  ),
                  //
                  // Bass Gain
                  Text(
                    'Bass Gain',
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),
                  ),
                  _audioFeatureSlider(
                    min: 0, max: 10,
                    limitsSuffix: "",
                    tooltip: 'Bass Gain',
                    onChanged: (double value) {
                      setState(() => filters.bassGain = value.round());
                    },
                    value: filters.bassGain.toDouble()
                  ),
                  //
                  // Treble Gain
                  Text(
                    'Treble Gain',
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),
                  ),
                  _audioFeatureSlider(
                    min: 0, max: 10,
                    limitsSuffix: "",
                    tooltip: 'Treble Gain',
                    onChanged: (double value) {
                      setState(() => filters.trebleGain = value.round());
                    },
                    value: filters.trebleGain.toDouble()
                  ),
                  // Audio Normalization
                  InkWell(
                    child: Ink(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        children: [
                          Icon(
                            filters.normalizeAudio
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                            color: filters.normalizeAudio
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).iconTheme.color
                          ),
                          const SizedBox(width: 8),
                          Text("Normalize Audio", style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).iconTheme.color,
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.w600
                          )),
                        ],
                      ),
                    ),
                    onTap: () => setState(() => filters.normalizeAudio = !filters.normalizeAudio),
                  ),
                  InkWell(
                    onTap: () => setState(() => enableConversion = !enableConversion),
                    child: Ink(
                      height: 48,
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            enableConversion
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                            color: enableConversion
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).iconTheme.color
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Enable Audio Conversion',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).iconTheme.color,
                              fontFamily: "Product Sans",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: enableConversion ? DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Icon(Icons.expand_more_rounded),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'AAC',
                                    child: Text('AAC', style: smallTextStyle(context, bold: true)),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'OGG',
                                    child: Text('OGG', style: smallTextStyle(context, bold: true)),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'MP3',
                                    child: Text('MP3', style: smallTextStyle(context, bold: true)),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  FFmpegTask task;
                                  if (value == 'AAC') {
                                    task = FFmpegTask.convertToAAC;
                                  } else if (value == 'OGG') {
                                    task = FFmpegTask.convertToOGG;
                                  } else {
                                    task = FFmpegTask.convertToMP3;
                                  }
                                  AppSettings.defaultFfmpegTask = task;
                                  setState(() {});
                                },
                                value: AppSettings.defaultFfmpegTask.toString().split('.').last.split('convertTo').last.toUpperCase(),
                                elevation: 1,
                                dropdownColor: Theme.of(context).cardColor,
                              ),
                            ) : Container()
                          ),
                          const SizedBox(width: 12)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ) : Container(),
        ),
      ],
    );
  }

  Widget _audioFeatureSlider({
    required double min, required double max, required Function(double) onChanged,
    required String limitsSuffix, required double value, required String tooltip
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 10,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: SliderTheme(
              data: const SliderThemeData(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)
              ),
              child: Slider(
                thumbColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).scaffoldBackgroundColor,
                value: value,
                min: min,
                max: max,
                onChanged: (position) {
                  onChanged(position);
                },
              ),
            ),
          ),
        ),
        Text(
          "+ ${value.round()}$limitsSuffix",
          style: tinyTextStyle(context, bold: true)
        )
      ],
    );
  }

  Widget _segmentsDownload() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => showSegmentedDownload = !showSegmentedDownload),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Ink(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    EvaIcons.listOutline,
                    color: Theme.of(context).primaryColor
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Segmented Download",
                    style: subtitleTextStyle(context, bold: true)
                  ),
                  const Spacer(),
                  Icon(showSegmentedDownload ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).iconTheme.color),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          child: showSegmentedDownload ? FadeInTransition(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 250),
            child: InkWell(
              child: Ink(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      segmentedDownload
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                      color: segmentedDownload
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).iconTheme.color
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enable segmented download", style: subtitleTextStyle(context, bold: true)),
                          const SizedBox(height: 8),
                          Text(
                            "This will download the whole audio file and then split it into the various "
                            "enabled segments (or audio tracks) from the list below",
                            style: smallTextStyle(context, opacity: 0.7)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
              onTap: () => setState(() => segmentedDownload = !segmentedDownload),
            ),
          ) : Container(),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          child: segmentedDownload && showSegmentedDownload ? FadeInTransition(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 250),
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  // Create music playlist with downloaded segments
                  InkWell(
                    child: Ink(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(
                            createMusicPlaylistWithSegments
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                            color: createMusicPlaylistWithSegments
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).iconTheme.color
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Create Music Playlist", style: subtitleTextStyle(context, bold: true)),
                                Text(
                                  "Create music playlist from all downloaded and saved audio segments",
                                  style: smallTextStyle(context, opacity: 0.7))
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                    onTap: () async {
                      setState(() {
                        createMusicPlaylistWithSegments = !createMusicPlaylistWithSegments;
                      });
                    }
                  ),
                  // Apply Tags Automatically
                  InkWell(
                    child: Ink(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(
                            EvaIcons.edit2Outline,
                            color: Theme.of(context).primaryColor
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Apply Tags", style: subtitleTextStyle(context, bold: true)),
                                Text(
                                  "Extract tags from MusicBrainz for all segments",
                                  style: smallTextStyle(context, opacity: 0.7))
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                    onTap: () async {
                      if (autoTaggerRunning) return;
                      setState(() => autoTaggerRunning = true);
                      for (int i = 0; i < segmentTracks.length; i++) {
                        if (!mounted) break;
                        String lastArtwork = segmentTracks[i].audioTags.artwork;
                        // ignore: prefer_typing_uninitialized_variables
                        var record;
                        try {
                        record = await MusicBrainzAPI
                          .getFirstRecord(segmentTracks[i].audioTags.titleController.text);
                        } catch (_) {}
                        if (!mounted) break;
                        if (record != null) {
                          segmentTracks[i].audioTags = await MusicBrainzAPI.getSongTags(MusicBrainzRecord.fromMap(record));
                          if (segmentTracks[i].audioTags.artwork == null) {
                            segmentTracks[i].audioTags.artwork = lastArtwork;
                          }
                          await Future.delayed(const Duration(seconds: 1));
                          setState(() {});
                        }
                      }
                      setState(() => autoTaggerRunning = false);
                    }
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: autoTaggerRunning
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
                          child: LinearProgressIndicator(value: null,
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor
                            ),
                            backgroundColor: Colors.transparent,
                            minHeight: 1,
                          ),
                        )
                      : Container()
                  ),
                  if (widget.video.segments != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.video.segments!.length,
                    itemBuilder: (context, index) {
                      return _segmentTile(index);
                    },
                  ),
                ],
              ),
            ),
          ) : Container(),
        ),
      ],
    );
  }

  Widget _segmentTile(int index) {
    StreamSegmentTrack segment = segmentTracks[index];
    return ListTile(
      onTap: () {
        setState(() => segmentTracks[index].enabled =
          !segmentTracks[index].enabled);
      },
      title: Text(
        segment.audioTags.titleController.text,
        style: smallTextStyle(context, bold: true),
        maxLines: 2,
      ),
      subtitle: Text(
        segment.audioTags.artistController.text,
        style: smallTextStyle(context, opacity: 0.7)
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: segmentTracks[index].enabled,
            onChanged: (value) {
              setState(() => segmentTracks[index].enabled = value!);
            },
          ),
          AspectRatio(
            aspectRatio: 1/1,
            child: Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black.withOpacity(0.3)
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageFade(
                      fadeDuration: const Duration(milliseconds: 300),
                      placeholder: Container(color: Theme.of(context).cardColor),
                      image: isURL(segment.audioTags.artwork)
                        ? NetworkImage(segment.audioTags.artwork) as ImageProvider
                        : FileImage(File(segment.audioTags.artwork)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4)
                      ),
                      child: const Icon(EvaIcons.brushOutline,
                        color: Colors.white,
                        size: 16),
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      trailing: FlexiblePopupMenu(
        items: [
          FlexiblePopupItem(
            title: Languages.of(context)!.labelPerformAutomaticTagging,
            value: 'autoTag',
          ),
          FlexiblePopupItem(
            title: Languages.of(context)!.labelSelectTagsfromMusicBrainz,
            value: 'manualTag',
          ),
        ],
        onItemTap: (String value) async {
          if (value == 'autoTag') {
            String lastArtwork = segmentTracks[index].audioTags.artwork;
            var record = await MusicBrainzAPI
              .getFirstRecord(segmentTracks[index].audioTags.titleController.text);
            var parsedRecord = MusicBrainzRecord.fromMap(record);
            segmentTracks[index].audioTags = await MusicBrainzAPI.getSongTags(parsedRecord);
            if (segmentTracks[index].audioTags.artwork == null) {
              segmentTracks[index].audioTags.artwork = lastArtwork;
            }
            Navigator.pop(context);
            setState(() {});
          } else if (value == 'manualTag') {
            
          } else {
            return;
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 24),
          color: Colors.transparent,
          child: Icon(Icons.more_vert_rounded,
            color: Theme.of(context).iconTheme.color),
        ),
      )
    );
  }

  List<AudioOnlyStream> getSpecificAudioCodecList(String codec) {
    List<AudioOnlyStream> list = [];
    for (var element in widget.video.audioOnlyStreams!) {
      if (codec == "ogg") {
        if (element.formatName == "WebM Opus") {
          list.add(element);
        }
      }
      if (codec == "m4a") {
        if (element.formatName == "m4a") {
          list.add(element);
        }
      }
    }
    return list;
  }

}