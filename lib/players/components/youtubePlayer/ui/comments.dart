import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/comment.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoComments extends StatefulWidget {
  final double topPadding;
  final Function onDispose;
  VideoComments({
    @required this.topPadding,
    @required this.onDispose
  });

  @override
  _VideoCommentsState createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {

  @override
  void initState() {
    widget.onDispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height -
        widget.topPadding,
      color: Colors.transparent,
      child: Column(
        children: [
          // CommentsBar
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              ),
            ),
            padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: Theme.of(context).iconTheme.color),
                  onPressed: () => Navigator.pop(context)
                ),
                SizedBox(width: 4),
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Product Sans'
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
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: ListView.separated(
                itemCount: pageProvider.currentComments.length,
                separatorBuilder: (context,_) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  YoutubeComment comment = pageProvider.currentComments[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 12 : 0,
                      bottom: 8
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(comment.uploaderAvatarUrl),
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              comment.author,
                              style: TextStyle(
                                color: Theme.of(context)
                                  .textTheme.bodyText1.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Product Sans'
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(
                          top: 16,
                          left: 16
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              comment.commentText,
                              style: TextStyle(
                                color: Theme.of(context)
                                  .textTheme.bodyText1.color,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  NumberFormat().format(comment.likeCount),
                                  style: TextStyle(
                                    color: Theme.of(context).iconTheme.color,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Icon(
                                    MdiIcons.thumbUp,
                                    size: 18,
                                    color: Theme.of(context).iconTheme.color
                                  ),
                                ),
                                SizedBox(width: 8),
                                if (comment.hearted)
                                Icon(
                                  MdiIcons.heart,
                                  size: 18,
                                  color: Colors.red
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}