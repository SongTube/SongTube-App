import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoPageDetails extends StatelessWidget {
  final String title;
  final String author;
  final String duration;
  final String date;
  final String channelLogo;
  VideoPageDetails({
    @required this.title,
    @required this.author,
    @required this.duration,
    @required this.date,
    @required this.channelLogo
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                    fadeInDuration: Duration(milliseconds: 400),
                    placeholder: MemoryImage(kTransparentImage),
                    image: channelLogo != null
                      ? NetworkImage(channelLogo)
                      : MemoryImage(kTransparentImage)
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Title
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 4),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // Video Author
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 8),
                      child: Text(
                        author,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontFamily: "Varela",
                          fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Video Duration and Weight
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Text(
                duration,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}