// Flutter
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:image_fade/image_fade.dart';
import 'package:newpipeextractor_dart/models/streams/audioOnlyStream.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/download/downloadItem.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/streamSegmentTrack.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/pages/musicBrainzResults.dart';
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/internal/popupMenu.dart';
import 'package:string_validator/string_validator.dart';

class AudioDownloadMenu extends StatefulWidget {
  final YoutubeVideo video;
  final TagsControllers tags;
  final Function(DownloadItem) onDownload;
  final Function onBack;
  AudioDownloadMenu({
    @required this.video,
    @required this.onDownload,
    @required this.onBack,
    @required this.tags,
  });
  @override
  _AudioDownloadMenuState createState() => _AudioDownloadMenuState();
}

class _AudioDownloadMenuState extends State<AudioDownloadMenu> with TickerProviderStateMixin {

  // Audio Settings
  AudioOnlyStream selectedAudio;

  // Tags Controller
  TagsControllers tags;

  // Audio Features
  bool showAudioFeatures = false;
  double volumeModifier = 0;
  int bassGain = 0;
  int trebleGain = 0;
  bool normalizeAudio = false;

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

  // Flag indicating if the auto tagger is running or not, to make
  // sure we don't run it again and then cause chaos and destruction
  bool autoTaggerRunning = false;

  @override
  void initState() {
    tags = widget.tags;
    selectedAudio = widget.video.audioWithBestAacQuality;
    if (widget.video.segments.isNotEmpty) {
      widget.video.segments.forEach((element) {
        TagsControllers tags = TagsControllers();
        tags.updateTextControllersFromStream(
          StreamInfoItem(
            widget.video.videoInfo.url,
            widget.video.videoInfo.id,
            element.title,
            widget.video.videoInfo.uploaderName,
            widget.video.videoInfo.uploaderUrl,
            widget.video.videoInfo.uploadDate,
            widget.video.videoInfo.uploadDate,
            widget.video.videoInfo.length,
            widget.video.videoInfo.viewCount
          )
        );
        segmentTracks.add(StreamSegmentTrack(element, tags, true));
      });
    }
    super.initState();
  }

  void _onDownload() {
    List<dynamic> list = [
      "Audio",
      selectedAudio,
      (1+volumeModifier).toString(),
      bassGain.toString(),
      trebleGain.toString(),
      normalizeAudio,
      segmentedDownload
        ? segmentTracks : <StreamSegmentTrack>[]
    ];
    DownloadItem item = DownloadItem.fetchData(
      widget.video,
      list, 
      tags,
      Provider.of<ConfigurationProvider>(context, listen: false)
    );
    widget.onDownload(item);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Menu Title
          Container(
            margin: EdgeInsets.only(
              top: 16,
              left: 8,
              right: 8
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: widget.onBack
                ),
                SizedBox(width: 4),
                Text(Languages.of(context).labelAudio, style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Product Sans",
                  fontWeight: FontWeight.w600
                )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              MusicBrainzRecord record = await Navigator.push(context,
                BlurPageRoute(builder: (context) => 
                  TagsResultsPage(
                    title: tags.titleController.text,
                    artist: tags.artistController.text
                  ),
                  blurStrength: Provider.of<PreferencesProvider>
                    (context, listen: false).enableBlurUI ? 20 : 0));
              if (record == null) return;
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              String lastArtwork = tags.artworkController;
              tags = await MusicBrainzAPI.getSongTags(record, artworkLink: record.artwork);
              if (tags.artworkController == null)
                tags.artworkController = lastArtwork;
              Navigator.pop(context);
              setState(() {});
            },
            child: Container(
              height: 130,
              padding: EdgeInsets.all(12),
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
                              fadeDuration: Duration(milliseconds: 300),
                              placeholder: Container(color: Theme.of(context).cardColor),
                              image: isURL(tags.artworkController)
                                ? NetworkImage(tags.artworkController)
                                : FileImage(File(tags.artworkController)),
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
                              child: Icon(EvaIcons.brushOutline,
                                color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, left: 12, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tags.titleController.text,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.w600
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            tags.artistController.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.bodyText1.color
                                .withOpacity(0.6)
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                child: DropdownButton<String>(
                                  value: selectedAudio.formatName == "m4a" ? "AAC" : "OGG",
                                  iconSize: 20,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                  ),
                                  underline: Container(),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("AAC"),
                                      value: "AAC",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("OGG"),
                                      value: "OGG",
                                    )
                                  ],
                                  onChanged: (String value) {
                                    if (value == "AAC") {
                                      setState(() => selectedAudio = widget.video.audioWithBestAacQuality);
                                    } else if (value == "OGG") {
                                      setState(() => selectedAudio = widget.video.audioWithBestOggQuality);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                height: 30,
                                child: DropdownButton<String>(
                                  value: "${selectedAudio.averageBitrate}",
                                  iconSize: 20,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                  ),
                                  underline: Container(),
                                  items: selectedAudio.formatName == "m4a"
                                    ? List.generate(getSpecificAudioCodecList("m4a").length, (index) => 
                                        DropdownMenuItem(
                                          child: Text("${getSpecificAudioCodecList("m4a")[index].averageBitrate} Kbps/s"),
                                          value: "${getSpecificAudioCodecList("m4a")[index].averageBitrate}",
                                      )).reversed.toList()
                                    : List.generate(getSpecificAudioCodecList("ogg").length, (index) => 
                                        DropdownMenuItem(
                                          child: Text("${getSpecificAudioCodecList("ogg")[index].averageBitrate} Kbps/s"),
                                          value: "${getSpecificAudioCodecList("ogg")[index].averageBitrate}",
                                      )).reversed.toList(),
                                  onChanged: (String value) {
                                    String codec = selectedAudio.formatName == "m4a" ? "m4a" : "ogg";
                                    int index = getSpecificAudioCodecList(codec).indexWhere((element) => element.averageBitrate.toString() == value);
                                    setState(() => selectedAudio = getSpecificAudioCodecList(codec)[index]);
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              InkWell(
                                onTap: () => setState(() => tags.updateTextControllers(widget.video)),
                                borderRadius: BorderRadius.circular(50),
                                child: Ink(
                                  color: Colors.transparent,
                                  child: Icon(EvaIcons.undoOutline,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 16),
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
          const SizedBox(height: 8),

          // Menu body, contains all the pre-download user controls
          _menuBody(),

          GestureDetector(
            onTap: () => _onDownload(),
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          Languages.of(context).labelDownload,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(EvaIcons.downloadOutline,
                          size: 28,
                          color: Theme.of(context).accentColor)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
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
        // Enable/Disable audio conversion
        _converterOptions(),
        const SizedBox(height: 4),
        // Enable/Disable segmented download
        if (widget.video.segments.isNotEmpty)
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
            padding: EdgeInsets.all(12.0),
            child: Ink(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(EvaIcons.editOutline,
                    color: Theme.of(context).accentColor),
                  SizedBox(width: 8),
                  Text(
                    Languages.of(context).labelTagsEditor.replaceAll("\n", " "),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  Spacer(),
                  Icon(showTags ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).iconTheme.color),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: showTags ? FadeInTransition(
            delay: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250),
            child: Column(
              children: [
                SizedBox(height: 12),
                // Title TextField
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFieldTile(
                        textController: tags.titleController,
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
                        textController: tags.albumController,
                        inputType: TextInputType.text,
                        labelText: Languages.of(context).labelEditorAlbum,
                        icon: EvaIcons.bookOpenOutline,
                      ),
                    ),
                    SizedBox(width: 12),
                    // Artist TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: tags.artistController,
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
                        textController: tags.genreController,
                        inputType: TextInputType.text,
                        labelText: Languages.of(context).labelEditorGenre,
                        icon: EvaIcons.bookOutline,
                      ),
                    ),
                    SizedBox(width: 12),
                    // Date TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: tags.dateController,
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
                        textController: tags.discController,
                        inputType: TextInputType.number,
                        labelText: Languages.of(context).labelEditorDisc,
                        icon: EvaIcons.playCircleOutline
                      ),
                    ),
                    SizedBox(width: 12),
                    // Track TextField
                    Expanded(
                      child: TextFieldTile(
                        textController: tags.trackController,
                        inputType: TextInputType.number,
                        labelText: Languages.of(context).labelEditorTrack,
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
            padding: EdgeInsets.all(12),
            child: Ink(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(EvaIcons.musicOutline,
                    color: Theme.of(context).accentColor),
                  SizedBox(width: 8),
                  Text(
                    "Audio Features",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  Spacer(),
                  Icon(showAudioFeatures ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).iconTheme.color),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: showAudioFeatures ? FadeInTransition(
            delay: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250),
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  // Volume Gain
                  Text(
                    Languages.of(context).labelVolume,
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
                      setState(() => volumeModifier = value/100);
                    },
                    value: volumeModifier*100,
                    tooltip: "${(volumeModifier*100).round()}%"
                  ),
                  //
                  // Bass Gain
                  Text(
                    Languages.of(context).labelBassGain,
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
                    onChanged: (double value) {
                      setState(() => bassGain = value.round());
                    },
                    value: bassGain.toDouble()
                  ),
                  //
                  // Treble Gain
                  Text(
                    Languages.of(context).labelTrebleGain,
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
                    onChanged: (double value) {
                      setState(() => trebleGain = value.round());
                    },
                    value: trebleGain.toDouble()
                  ),
                  // Audio Normalization
                  InkWell(
                    child: Ink(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        children: [
                          Icon(
                            normalizeAudio
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                            color: normalizeAudio
                              ? Theme.of(context).accentColor
                              : Theme.of(context).iconTheme.color
                          ),
                          SizedBox(width: 8),
                          Text("Normalize Audio", style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).iconTheme.color,
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.w600
                          )),
                        ],
                      ),
                    ),
                    onTap: () => setState(() => normalizeAudio = !normalizeAudio),
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
    double min, double max, Function(double) onChanged,
    String limitsSuffix, double value, String tooltip
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 10,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: FlutterSlider(
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
                ),
                activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).accentColor
                ),
              ),
              tooltip: FlutterSliderTooltip(
                format: tooltip != null
                  ? (_) {
                      return tooltip;
                    }
                  : null,
              ),
              handler: FlutterSliderHandler(
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).accentColor,
                  ),
                )
              ),
              values: [value],
              min: min, max: max,
              onDragging: (_, position, __) {
                onChanged(position);
              },
            ),
          ),
        ),
        Text(
          "$max$limitsSuffix",
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).iconTheme.color,
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }

  Widget _converterOptions() {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return InkWell(
      onTap: () => setState(() => enableConversion = !enableConversion),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Ink(
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                enableConversion
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
                color: enableConversion
                  ? Theme.of(context).accentColor
                  : Theme.of(context).iconTheme.color
              ),
              SizedBox(width: 8),
              Text(
                Languages.of(context).labelEnableAudioConversion,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              Spacer(),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: enableConversion ? DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.expand_more_rounded),
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('AAC', style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Product Sans'
                        )),
                        value: 'AAC',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('OGG', style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Product Sans'
                        )),
                        value: 'OGG Vorbis',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('MP3', style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Product Sans'
                        )),
                        value: 'MP3',
                      ),
                    ],
                    onChanged: (String value) {
                      config.ffmpegActionTypeFormat = value;
                    },
                    value: config.ffmpegActionTypeFormat,
                    elevation: 1,
                    dropdownColor: Theme.of(context).cardColor,
                  ),
                ) : Container()
              ),
              SizedBox(width: 12)
            ],
          ),
        ),
      ),
    );
  }

  Widget _segmentsDownload() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => showSegmentedDownload = !showSegmentedDownload),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Ink(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    EvaIcons.listOutline,
                    color: Theme.of(context).accentColor
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Segmented Download",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  Spacer(),
                  Icon(showSegmentedDownload ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).iconTheme.color),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          vsync: this,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: showSegmentedDownload ? FadeInTransition(
            delay: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250),
            child: InkWell(
              child: Ink(
                padding: EdgeInsets.only(top: 8, bottom: 16),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      segmentedDownload
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                      color: segmentedDownload
                        ? Theme.of(context).accentColor
                        : Theme.of(context).iconTheme.color
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enable segmented download", style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.w600
                          )),
                          const SizedBox(height: 8),
                          Text(
                            "This will download the whole audio file and then split it into the various "
                            "enabled segments (or audio tracks) from the list below",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).iconTheme.color,
                              fontFamily: "Product Sans",
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                  ],
                ),
              ),
              onTap: () => setState(() => segmentedDownload = !segmentedDownload),
            ),
          ) : Container(),
        ),
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: segmentedDownload && showSegmentedDownload ? FadeInTransition(
            delay: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250),
            child: Padding(
              padding: EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  InkWell(
                    child: Ink(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            EvaIcons.edit2Outline,
                            color: Theme.of(context).accentColor
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Apply Tags", style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).textTheme.bodyText1.color,
                                  fontFamily: "Product Sans",
                                  fontWeight: FontWeight.w600
                                )),
                                Text(
                                  "Extract tags from MusicBrainz for all segments",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).iconTheme.color,
                                    fontFamily: "Product Sans",
                                    fontWeight: FontWeight.w600
                                  )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 24),
                        ],
                      ),
                    ),
                    onTap: () async {
                      if (autoTaggerRunning) return;
                      setState(() => autoTaggerRunning = true);
                      for (int i = 0; i < segmentTracks.length; i++) {
                        if (!mounted) break;
                        String lastArtwork = segmentTracks[i].tags.artworkController;
                        var record;
                        try {
                        record = await MusicBrainzAPI
                          .getFirstRecord(segmentTracks[i].tags.titleController.text);
                        } catch (_) {}
                        if (!mounted) break;
                        if (record != null) {
                          segmentTracks[i].tags = await MusicBrainzAPI.getSongTags(MusicBrainzRecord.fromMap(record));
                          if (segmentTracks[i].tags.artworkController == null)
                            segmentTracks[i].tags.artworkController = lastArtwork;
                          await Future.delayed(Duration(seconds: 1));
                          setState(() {});
                        }
                      }
                      setState(() => autoTaggerRunning = false);
                    }
                  ),
                  AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 300),
                    child: autoTaggerRunning
                      ? Padding(
                        padding: EdgeInsets.only(bottom: 12, left: 24, right: 24),
                          child: LinearProgressIndicator(value: null,
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).accentColor
                            ),
                            backgroundColor: Colors.transparent,
                            minHeight: 1,
                          ),
                        )
                      : Container()
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.video.segments.length,
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
        setState(() => segmentTracks[index].selected =
          !segmentTracks[index].selected);
      },
      title: Text(
        segment.tags.titleController.text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
          fontFamily: 'Product Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        maxLines: 2,
      ),
      subtitle: Text(
        segment.tags.artistController.text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color
            .withOpacity(0.6),
          fontFamily: 'Product Sans',
          fontSize: 12,
          fontWeight: FontWeight.w600
        ),
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: segmentTracks[index].selected,
            onChanged: (value) {
              setState(() => segmentTracks[index].selected = value);
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
                      fadeDuration: Duration(milliseconds: 300),
                      placeholder: Container(color: Theme.of(context).cardColor),
                      image: isURL(segment.tags.artworkController)
                        ? NetworkImage(segment.tags.artworkController)
                        : FileImage(File(segment.tags.artworkController)),
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
                      child: Icon(EvaIcons.brushOutline,
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
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      trailing: FlexiblePopupMenu(
        child: Container(
          margin: EdgeInsets.only(right: 24),
          color: Colors.transparent,
          child: Icon(Icons.more_vert_rounded,
            color: Theme.of(context).iconTheme.color),
        ),
        items: [
          FlexiblePopupItem(
            title: Languages.of(context).labelPerformAutomaticTagging,
            value: 'autoTag',
          ),
          FlexiblePopupItem(
            title: Languages.of(context).labelSelectTagsfromMusicBrainz,
            value: 'manualTag',
          ),
        ],
        onItemTap: (String value) async {
          if (value == 'autoTag') {
            showDialog(
              context: context,
              builder: (_) => LoadingDialog()
            );
            String lastArtwork = segmentTracks[index].tags.artworkController;
            var record = await MusicBrainzAPI
              .getFirstRecord(segmentTracks[index].tags.titleController.text);
            var parsedRecord = MusicBrainzRecord.fromMap(record);
            segmentTracks[index].tags = await MusicBrainzAPI.getSongTags(parsedRecord, artworkLink: parsedRecord.artwork);
            if (segmentTracks[index].tags.artworkController == null)
              segmentTracks[index].tags.artworkController = lastArtwork;
            Navigator.pop(context);
            setState(() {});
          } else if (value == 'manualTag') {
            MusicBrainzRecord record = await Navigator.push(context,
              BlurPageRoute(builder: (context) => 
                TagsResultsPage(
                  title: segmentTracks[index].tags.titleController.text,
                  artist: segmentTracks[index].tags.artistController.text
                ),
                blurStrength: Provider.of<PreferencesProvider>
                  (context, listen: false).enableBlurUI ? 20 : 0));
            if (record == null) return;
            showDialog(
              context: context,
              builder: (_) => LoadingDialog()
            );
            String lastArtwork = segmentTracks[index].tags.artworkController;
            segmentTracks[index].tags = await MusicBrainzAPI.getSongTags(record, artworkLink: record.artwork);
            if (segmentTracks[index].tags.artworkController == null)
              segmentTracks[index].tags.artworkController = lastArtwork;
            Navigator.pop(context);
            setState(() {});
          } else {
            return;
          }
        },
      )
    );
  }

  List<AudioOnlyStream> getSpecificAudioCodecList(String codec) {
    List<AudioOnlyStream> list = [];
    widget.video.audioOnlyStreams.forEach((element) {
      if (codec == "ogg") {
        if (element.formatName == "WebM Opus")
          list.add(element);
      }
      if (codec == "m4a") {
        if (element.formatName == "m4a")
          list.add(element);
      }
    });
    return list;
  }

}