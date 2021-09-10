// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/internal/models/videoFile.dart';

// Packages
import 'package:transparent_image/transparent_image.dart';

class VideosOnFolderListView extends StatelessWidget {
  final List<VideoFile> list;
  final Function(VideoFile) onVideoTap;
  VideosOnFolderListView({
    @required this.list,
    @required this.onVideoTap,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          VideoFile video = list[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                onVideoTap(video);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: FutureBuilder<File>(
                          future: FFmpegExtractor.getVideoThumbnail(File(video.path)),
                          builder: (context, AsyncSnapshot<File> thumbnail) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  FadeInImage(
                                    fadeInDuration: Duration(milliseconds: 300),
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: thumbnail.hasData && thumbnail.data != null
                                      ? FileImage(thumbnail.data)
                                      : MemoryImage(kTransparentImage),
                                    fit: BoxFit.cover,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8, bottom: 8),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: FutureBuilder(
                                        future: FFmpegExtractor.getVideoDuration(File(video.path)),
                                        builder: (context, AsyncSnapshot<int> videoDuration) {
                                          return Text(
                                            videoDuration.hasData
                                              ? "${Duration(seconds: videoDuration.data).inMinutes}min"
                                              : Languages.of(context).labelCalculating,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Product Sans',
                                              fontWeight: FontWeight.w600
                                            ),
                                          );
                                        },
                                      )
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      video.name.replaceAll(".webm", '')
                        .replaceAll(".mp4", '')
                        .replaceAll(".avi", '')
                        .replaceAll(".3gpp", '')
                        .replaceAll(".flv", '')
                        .replaceAll(".mkv", ''),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 4),
                    child: Text(
                      "${video.lastModified.month}/${video.lastModified.day}/${video.lastModified.year}  •  " +
                      "${(int.parse(video.size)/1000000).toStringAsFixed(2)}MB",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}