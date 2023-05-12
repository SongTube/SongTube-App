import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:songtube/internal/album_utils.dart';
import 'package:songtube/internal/models/media_item_models.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumGridTile extends StatelessWidget {
  const AlbumGridTile({
    required this.album,
    this.onTap,
    Key? key}) : super(key: key);
  final MediaItemAlbum album;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final songs = album.mediaItems;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FutureBuilder<File>(
                future: AlbumUtils.getAlbumImageFromSong(songs.first),
                builder: (context, snapshot) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          offset: const Offset(0,0),
                          color: Theme.of(context).shadowColor.withOpacity(0.1)
                        )
                      ],
                    ),
                    child: ImageFade(
                      placeholder: const SizedBox(),
                      image: snapshot.hasData
                        ? FileImage(snapshot.data!)
                        : MemoryImage(kTransparentImage) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(album.albumTitle, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold), maxLines: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(album.albumAuthor, style: tinyTextStyle(context, opacity: 0.6).copyWith(letterSpacing: 0.4, fontWeight: FontWeight.w500), maxLines: 1),
          )
        ],
      ),
    );
  }
}