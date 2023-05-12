import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:songtube/services/content_service.dart';
import 'package:songtube/ui/components/shimmer_container.dart';
import 'package:songtube/ui/ui_utils.dart';
import 'package:transparent_image/transparent_image.dart';

class ChannelImage extends StatelessWidget {
  const ChannelImage({
    required this.channelUrl,
    required this.heroId,
    required this.channelName,
    this.expand = false,
    this.highQuality = false,
    this.onTap,
    this.size,
    super.key});
  final String? channelUrl;
  final String heroId;
  final String channelName;
  final bool expand;
  final double? size;
  final bool highQuality;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: highQuality ? UiUtils.getAvatarUrl(channelName, channelUrl ?? '') : ContentService.channelAvatarPictureFile(channelUrl ?? ''),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Hero(
            tag: "$channelUrl + $heroId",
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.08), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      offset: const Offset(0,0),
                      color: Theme.of(context).shadowColor.withOpacity(0.1)
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 300),
                    placeholder: MemoryImage(kTransparentImage),
                    image: FileImage(snapshot.data! is File ? snapshot.data! : File(snapshot.data!)),
                    fit: BoxFit.cover,
                    imageErrorBuilder:(context, error, stackTrace) {
                      return Image.memory(kTransparentImage);
                    },
                    height: size ?? (expand ? 80 : 50),
                    width: size ?? (expand ? 80 : 50),
                  ),
                ),
              ),
            ),
          );
        } else {
          return ShimmerContainer(
            height: size ?? (expand ? 80 : 50),
            width: size ?? (expand ? 80 : 50),
            borderRadius: BorderRadius.circular(100),
          );
        }
      },
    );
  }
}