import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/music_brainz_record.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/services/music_brainz_service.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/animations/blue_page_route.dart';
import 'package:songtube/ui/text_styles.dart';

class MusicBrainzSearch extends StatefulWidget {
  final String title;
  final String artist;
  const MusicBrainzSearch({
    required this.title,
    required this.artist,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TagsResultsPageState createState() => _TagsResultsPageState();
}

class _TagsResultsPageState extends State<MusicBrainzSearch> {

  // MusicBrainz Search Controller
  late TextEditingController searchController = TextEditingController()..text = widget.title;

  // Current Search Results
  List<MusicBrainzRecord> searchResults = [];

  @override
  void initState() {
    searchForRecords();
    super.initState();
  }

  void searchForRecords() async {
    final result = await MusicBrainzAPI.getRecordings(searchController.text);
    searchResults.clear();
    for (var element in result) {
      searchResults.add(MusicBrainzRecord.fromMap(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusicBrainz Search', style: textStyle(context).copyWith(color: Colors.white)),
        titleSpacing: 0,
        leading: IconButton(
          icon: const AppAnimatedIcon(Iconsax.arrow_left, size: 22),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: Container(
            margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(100) 
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const AppAnimatedIcon(EvaIcons.textOutline,
                          size: 20,
                        ),
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
                    onFieldSubmitted: (searchQuery) {
                      setState(() => searchController.text = searchQuery);
                      searchForRecords();
                    },
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.only(right: 16, left: 12),
                  icon: const AppAnimatedIcon(EvaIcons.arrowIosForward, size: 20),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    searchForRecords();
                  }
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var record = searchResults[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _resultTile(record, index),
          );
        },
      ),
    );
  }

  Widget _resultTile(MusicBrainzRecord record, int index) {
    return FutureBuilder(
      future: _getArtworkLink(record, index),
      builder: (context, image) {
        return GestureDetector(
          onTap: () async {
            var result = await Navigator.of(context).push(
              BlurPageRoute(
                blurStrength: 10,
                useCardExit: true,
                backdropColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                builder: (BuildContext context) {
                  return _DataItem(record: record, image: image, index: index);
                }
              ),
            );
            if (result == null) return;
            // ignore: use_build_context_synchronously
            Navigator.pop(context, result);
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

}

class _DataItem extends StatefulWidget {
  const _DataItem({
    required this.record,
    required this.image,
    required this.index,
    Key? key}) : super(key: key);
  final MusicBrainzRecord record;
  final AsyncSnapshot<dynamic> image;
  final int index;
  @override
  __DataItemState createState() => __DataItemState();
}

class __DataItemState extends State<_DataItem> {

  // Current ArtWork
  String? artwork;
  
  Widget _artworkWidget(AsyncSnapshot image, int index, bool fullRound) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: image.hasData
          ? GestureDetector(
              onTap: () async {
                try {
                  final data = await FilePicker.platform.pickFiles(type: FileType.image);
                  File? image = data?.paths[0] != null
                    ? File(data!.paths[0]!) : null;
                  if (image == null) return;
                  artwork = image.path;
                  setState(() {});
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
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
                          image: artwork == null
                            ? NetworkImage(image.data) as ImageProvider
                            : FileImage(File(artwork!))
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 16),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4)
                          ),
                          child: const Icon(EvaIcons.editOutline,
                            color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
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

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _artworkWidget(widget.image, widget.index, false),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                ),
                color: Theme.of(context).cardColor
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Title: ',
                          style: subtitleTextStyle(context)
                        ),
                        TextSpan(
                          text: widget.record.title,
                          style: subtitleTextStyle(context, opacity: 0.6)
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Artist: ",
                          style: subtitleTextStyle(context)
                        ),
                        TextSpan(
                          text: widget.record.artist,
                          style: subtitleTextStyle(context, opacity: 0.6)
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Album: ",
                          style: subtitleTextStyle(context)
                        ),
                        TextSpan(
                          text: widget.record.album,
                          style: subtitleTextStyle(context, opacity: 0.6)
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Date: ",
                          style: subtitleTextStyle(context)
                        ),
                        TextSpan(
                          text: widget.record.date,
                          style: subtitleTextStyle(context, opacity: 0.6)
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Genre: ",
                          style: subtitleTextStyle(context)
                        ),
                        TextSpan(
                          text: widget.record.genre,
                          style: subtitleTextStyle(context, opacity: 0.6)
                        ),
                      ]
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: widget.image.connectionState == ConnectionState.done ? () {
                          Navigator.pop(context, widget.record..artwork = artwork ?? widget.image.data);
                        } : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: mediaProvider.currentColors.vibrant?.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(12),
                          child: AnimatedText(
                            widget.image.connectionState == ConnectionState.done
                              ? "Apply"
                              : "Loading",
                            style: subtitleTextStyle(context),
                            auto: true,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
}