import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';

class TagsResultsPage extends StatefulWidget {
  final String title;
  final String artist;
  TagsResultsPage({
    @required this.title,
    @required this.artist
  });

  @override
  _TagsResultsPageState createState() => _TagsResultsPageState();
}

class _TagsResultsPageState extends State<TagsResultsPage> {

  TextEditingController searchController;

  List<MusicBrainzRecord> searchResults = [];

  @override
  void initState() {
    searchController = TextEditingController()..text = widget.title;
    searchForRecords();
    super.initState();
  }

  void searchForRecords() async {
    final result = await MusicBrainzAPI.getRecordings(searchController.text);
    searchResults.clear();
    result.forEach((element) {
      searchResults.add(MusicBrainzRecord.fromMap(element));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MusicBrainz",
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 45),
          child: Container(
            margin: EdgeInsets.only(top: 4, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(100) 
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      controller: searchController,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none
                      ),
                      onFieldSubmitted: (searchQuery) {
                        setState(() => searchController.text = searchQuery);
                        searchForRecords();
                      },
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(right: 20, left: 12),
                  icon: Icon(EvaIcons.searchOutline),
                  onPressed: () {
                    searchForRecords();
                  }
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        addAutomaticKeepAlives: true,
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
                backdropColor: Colors.black.withOpacity(0.4),
                blurStrength: Provider.of<PreferencesProvider>
                  (context, listen: false).enableBlurUI ? 20 : 0,
                builder: (BuildContext context) {
                  return _DataItem(record: record, image: image, index: index);
                }
              ),
            );
            if (result == null) return;
            Navigator.pop(context, result);
          },
          child: SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _artworkWidget(image, index, true),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8, top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          record.title,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          )
                        ),
                        SizedBox(height: 4),
                        // Album
                        Text(
                          record.album,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          )
                        ),
                        SizedBox(height: 4),
                        // Artist
                        Text(
                          "By ${record.artist}",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          )
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

  Widget _artworkWidget(AsyncSnapshot image, int index, bool fullRound) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: image.hasData
          ? Hero(
              tag: "artwork$index",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: fullRound ? Radius.circular(10) : Radius.zero,
                    bottomRight: fullRound ? Radius.circular(10) : Radius.zero,
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
                  image: DecorationImage(
                    image: AssetImage('assets/images/artworkPlaceholder_big.png')
                  )
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).accentColor
                  ),
                ),
              )
      ),
    );
  }

  Future<String> _getArtworkLink(MusicBrainzRecord record, int index) async {
    await Future.delayed(Duration(seconds: index));
    if (record.id == null) return null;
    Map<String, String> map = await MusicBrainzAPI
      .getThumbnails(record.id);
    if (map == null) return null;
    String url;
    if (map.containsKey("1200x1200")) {
      url = map["1200x1200"];
    } else {
      url = map["500x500"];
    }
    return url;
  }

}

class _DataItem extends StatefulWidget {
  const _DataItem({this.record, this.image, this.index,
    Key key}) : super(key: key);
  final MusicBrainzRecord record;
  final AsyncSnapshot<dynamic> image;
  final int index;
  @override
  __DataItemState createState() => __DataItemState();
}

class __DataItemState extends State<_DataItem> {

  // Current ArtWork
  String artwork;
  
  Widget _artworkWidget(AsyncSnapshot image, int index, bool fullRound) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: image.hasData
          ? GestureDetector(
              onTap: () async {
                try {
                  File image = File((await FilePicker.platform
                    .pickFiles(type: FileType.image))
                    .paths[0]);
                  if (image == null) return;
                  artwork = image.path;
                  setState(() {});
                } catch (e) {}
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: fullRound ? Radius.circular(10) : Radius.zero,
                        bottomRight: fullRound ? Radius.circular(10) : Radius.zero,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: artwork == null
                          ? NetworkImage(image.data)
                          : FileImage(File(artwork))
                      )
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
                          child: Icon(EvaIcons.brushOutline,
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
                  image: DecorationImage(
                    image: AssetImage('assets/images/artworkPlaceholder_big.png')
                  )
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).accentColor
                  ),
                ),
              )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _artworkWidget(widget.image, widget.index, false),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                color: Theme.of(context).scaffoldBackgroundColor
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Languages.of(context).labelEditorTitle + ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                        TextSpan(
                          text: widget.record.title,
                          style: TextStyle(
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Languages.of(context).labelEditorArtist + ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                        TextSpan(
                          text: widget.record.artist,
                          style: TextStyle(
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Languages.of(context).labelEditorAlbum + ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                        TextSpan(
                          text: widget.record.album,
                          style: TextStyle(
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          ),
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Languages.of(context).labelEditorDate + ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                        TextSpan(
                          text: widget.record.date,
                          style: TextStyle(
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          ),
                        ),
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Languages.of(context).labelEditorGenre + ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          )
                        ),
                        TextSpan(
                          text: widget.record.genre,
                          style: TextStyle(
                            color: Theme.of(context).textTheme
                              .bodyText1.color
                          ),
                        ),
                      ]
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, widget.record..artwork = artwork);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Spacer(),
                            Text(
                              "Apply",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Product Sans',
                                fontSize: 16,
                                color: Theme.of(context).textTheme
                                  .bodyText1.color
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(EvaIcons.checkmark,
                              color: Theme.of(context).accentColor),
                          ],
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