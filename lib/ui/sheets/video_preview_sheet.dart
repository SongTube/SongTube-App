import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:songtube/internal/models/video_preview.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';

import '../components/shimmer_container.dart';

class VideoPreviewSheet extends StatefulWidget {
  const VideoPreviewSheet({
    required this.url,
    super.key});
  final String url;

  @override
  State<VideoPreviewSheet> createState() => _VideoPreviewSheetState();
}

class _VideoPreviewSheetState extends State<VideoPreviewSheet> {

  // Preview
  VideoPreview? preview;

  @override
  void initState() {
    VideoPreview.fromUrl(widget.url).then((value) {
      setState(() {
        preview = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      title: Languages.of(context)!.labelLoading,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ImageFade(
                      fadeDuration: const Duration(milliseconds: 300),
                      placeholder:
                          const ShimmerContainer(height: null, width: null),
                      image: NetworkImage(preview?.thumbnailUrl ?? ''),
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, child, exception) {
                        return Container(color: Theme.of(context).scaffoldBackgroundColor);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 0),
                      child: Text(
                        preview?.name ?? '',
                        style: smallTextStyle(context).copyWith(fontWeight: FontWeight.normal),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        preview?.author ?? '',
                        style: tinyTextStyle(context, opacity: 0.8).copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                 ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(8).copyWith(bottom: 0),
              height: 20,
              width: 20,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor))),
          )
        ],
      )
    );
  }
}