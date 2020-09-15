// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;

class VideoDownloadMenu extends StatelessWidget {
  final List<youtube.VideoStreamInfo> videoList;
  final Function(List<dynamic>) onOptionSelect;
  VideoDownloadMenu({
    @required this.videoList,
    @required this.onOptionSelect
  });
  void _onOptionSelect(youtube.VideoStreamInfo video) {
    List<dynamic> list = [
      "Video",
      video, 
      "1.0", "0", "0"
    ];
    onOptionSelect(list);
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 22, right: MediaQuery.of(context).size.width*0.2),
          child: ListTile(
            leading: Icon(EvaIcons.videoOutline, color: Theme.of(context).accentColor),
            title: Text("Video", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color, fontWeight: FontWeight.w600)),
            subtitle: Text("Download video at selected quality bellow"),
            onTap: () {},
          ),
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(top: 16, bottom: 16, left: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Quality: ",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      videoList[index].videoResolution.toString() + " " +
                      videoList[index].framerate.toString() + "fps ",
                      style: TextStyle(fontFamily: "Varela"),
                    ),
                    videoList[index].videoQualityLabel.contains(new RegExp(r'HDR'))
                    ? Text(
                      "HDR ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                        fontFamily: "Varela"
                      ),
                    ) : Container(),
                    Text(
                      (((videoList[index].size.totalBytes)/1024)/1024).toStringAsFixed(2) +
                      "MB", style: TextStyle(fontSize: 12, fontFamily: "Varela"),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(EvaIcons.downloadOutline, color: Colors.white),
                        ),
                      ),
                      onTap: () => _onOptionSelect(videoList[index])
                    ),
                    SizedBox(width: 18)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}