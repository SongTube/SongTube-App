import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/comments.dart';
import 'package:newpipeextractor_dart/models/comment.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';

class VideoComments extends StatelessWidget {
  final StreamInfoItem infoItem;
  final double topPadding;
  VideoComments({
    @required this.infoItem,
    @required this.topPadding
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
        topPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        ),
      ),
      child: Column(
        children: [
          // CommentsBar
          Container(
            height: 50,
            width: double.infinity,
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
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[600].withOpacity(0.1),
            indent: 12,
            endIndent: 12
          ),
          Expanded(
            child: FutureBuilder<List<YoutubeComment>>(
              future: CommentsExtractor.getComments(infoItem.url),
              builder: (context, AsyncSnapshot<List<YoutubeComment>> comments) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: comments.connectionState == ConnectionState.done
                  ? comments.data.isNotEmpty
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
                                  comments.data[index].commentText,
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
                    : Text(
                        "Comments are empty!",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color
                            .withOpacity(0.6),
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 22
                        ),
                      )
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