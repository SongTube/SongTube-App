import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    searchController = TextEditingController();
    searchController.text = widget.title;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MusicBrainz Search",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 45),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none
                    ),
                    onFieldSubmitted: (searchQuery) {
                      setState(() => searchController.text = searchQuery);
                    },
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(right: 20, left: 12),
                icon: Icon(EvaIcons.searchOutline),
                onPressed: () {
                  setState(() => searchController.text = searchController.text);
                }
              )
            ],
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16),
          FutureBuilder(
            future: MusicBrainzAPI.getRecordings(searchController.text),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var records = snapshot.data;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  addAutomaticKeepAlives: true,
                  cacheExtent: 9999999,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    var record = records[index];
                    return FutureBuilder(
                      future: _getArtworkLink(record, index),
                      builder: (context, image) {
                        return GestureDetector(
                          onTap: () async {
                            var result = await Navigator.of(context).push(
                              BlurPageRoute(
                                backdropColor: Colors.black.withOpacity(0.4),
                                blurStrength: prefs.enableBlurUI ? 20 : 0,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _artworkWidget(image, index, false),
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
                                                        text: "Title: ",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Product Sans',
                                                          fontSize: 16,
                                                          color: Theme.of(context).textTheme
                                                            .bodyText1.color
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: "${record['title']}",
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
                                                        text: "Author: ",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Product Sans',
                                                          fontSize: 16,
                                                          color: Theme.of(context).textTheme
                                                            .bodyText1.color
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: "${MusicBrainzAPI.getArtist(record)}",
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
                                                        text: "Album: ",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Product Sans',
                                                          fontSize: 16,
                                                          color: Theme.of(context).textTheme
                                                            .bodyText1.color
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: "${record['releases'][0]['title']}",
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
                                                        text: "Date: ",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Product Sans',
                                                          fontSize: 16,
                                                          color: Theme.of(context).textTheme
                                                            .bodyText1.color
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: "${MusicBrainzAPI.getDate(record)}",
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
                                                        text: "Genre: ",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Product Sans',
                                                          fontSize: 16,
                                                          color: Theme.of(context).textTheme
                                                            .bodyText1.color
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: MusicBrainzAPI.getGenre(record) == "Any"
                                                          ? "Not Specified"
                                                          : "${MusicBrainzAPI.getGenre(record)}",
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
                                                      Navigator.pop(context, record);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(8),
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
                                                          Icon(EvaIcons.checkmarkOutline,
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
                              ),
                            );
                            if (result == null) return;
                            Navigator.pop(context, result);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: _artworkWidget(image, index, true)
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 8, top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Title: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).textTheme
                                                .bodyText1.color
                                            )
                                          ),
                                          TextSpan(
                                            text: "${record['title']}",
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme
                                                .bodyText1.color
                                            )
                                          ),
                                        ]
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Author: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).textTheme
                                                .bodyText1.color
                                            )
                                          ),
                                          TextSpan(
                                            text: "${MusicBrainzAPI.getArtist(record)}",
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme
                                                .bodyText1.color
                                            )
                                          ),
                                        ]
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Album: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).textTheme
                                                .bodyText1.color
                                            )
                                          ),
                                          TextSpan(
                                            text: "${record['releases'][0]['title']}",
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme
                                                .bodyText1.color
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          )
        ],
      ),
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

  Future<String> _getArtworkLink(record, int index) async {
    await Future.delayed(Duration(seconds: index));
    String url = await MusicBrainzAPI
      .getThumbnail(record['releases'][0]['id']);
    return url;
  }

}