import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/youtube/youtubeExtractor.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoComments extends StatelessWidget {
  final Video video;
  final double topPadding;
  VideoComments({
    @required this.video,
    @required this.topPadding
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
        topPadding,
      child: Column(
        children: [
          // CommentsBar
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(3,0),
                  blurRadius: 12
                )
              ]
            ),
            padding: EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(EvaIcons.arrowBackOutline,
                    color: Theme.of(context).iconTheme.color),
                  onPressed: () => Navigator.pop(context)
                ),
                SizedBox(width: 8),
                Text(
                  "Comments",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Comment>>(
              future: YoutubeExtractor()
                .getVideoComments(video),
              builder: (context, AsyncSnapshot<List<Comment>> comments) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: comments.connectionState == ConnectionState.done
                  ? comments.data != null
                    ? ListView.separated(
                        
                        itemCount: comments.data.length,
                        separatorBuilder: (context,_) {
                          return Divider();
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 16 : 0
                            ),
                            child: ListTile(
                              title: Text(
                                comments.data[index].author,
                                style: TextStyle(
                                  color: Theme.of(context)
                                    .textTheme.bodyText1.color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(
                                  top: 8,
                                  left: 16
                                ),
                                child: Text(
                                  comments.data[index].text,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                      .textTheme.bodyText1.color,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Text("There is no Comments to show")
                  : Center(child: CircularProgressIndicator())
                );
              }
            ),
          )
        ],
      ),
    );
  }
}