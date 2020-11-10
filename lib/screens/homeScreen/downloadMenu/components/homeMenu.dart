import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

class DownloadMenuHome extends StatelessWidget {
  final Function onBack;
  final Function onAudioTap;
  final Function onVideoTap;
  DownloadMenuHome({
    @required this.onBack,
    @required this.onAudioTap,
    @required this.onVideoTap
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Menu Title
        Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                icon: Icon(EvaIcons.arrowBackOutline),
                onPressed: onBack
              ),
              SizedBox(width: 16),
              Text(Languages.of(context).labelDownload, style: TextStyle(
                fontSize: 20,
                fontFamily: "YTSans"
              )),
            ],
          ),
        ),
        // Download Options
        Container(
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              // Audio
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: onAudioTap,
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).iconTheme.color.withOpacity(0.1),
                        width: 1.5,
                      ),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black.withOpacity(0.04)
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.musicOutline, size: 35,
                         color: Theme.of(context).accentColor),
                        SizedBox(width: 16),
                        Text(
                          Languages.of(context).labelAudio,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                            fontFamily: "YTSans"
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Video
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: onVideoTap,
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).iconTheme.color.withOpacity(0.1),
                        width: 1.5,
                      ),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black.withOpacity(0.04)
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.videoOutline, size: 35,
                          color: Theme.of(context).accentColor),
                        SizedBox(width: 16),
                        Text(
                          Languages.of(context).labelVideo,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                            fontFamily: "YTSans"
                          )
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}