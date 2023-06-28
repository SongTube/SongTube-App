import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/videoInfo.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/rounded_tab_indicator.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VideoPlayerDescription extends StatefulWidget {
  const VideoPlayerDescription({
    required this.info,
    required this.segments,
    required this.onBack,
    required this.onSeek,
    required this.onSegmentTap,
    super.key});
  final VideoInfo info;
  final List<StreamSegment> segments;
  final Function() onBack;
  final Function(Duration) onSeek;
  final Function(int) onSegmentTap;
  @override
  State<VideoPlayerDescription> createState() => _VideoPlayerDescriptionState();
}

class _VideoPlayerDescriptionState extends State<VideoPlayerDescription> {
  @override
  Widget build(BuildContext context) {
    if (widget.segments.isEmpty) {
      return _descriptionOnly();
    } else {
      return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 4),
                IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(Iconsax.arrow_left)
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TabBar(
                    padding: const EdgeInsets.only(left: 8),
                    labelColor: Theme.of(context).textTheme.bodyText1!.color,
                    unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                    labelStyle: smallTextStyle(context).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4),
                    unselectedLabelStyle: smallTextStyle(context).copyWith(fontWeight: FontWeight.normal, letterSpacing: 0.4),
                    physics: const BouncingScrollPhysics(),
                    indicator: RoundedTabIndicator(color: Theme.of(context).primaryColor, height: 3, radius: 100, bottomMargin: 0),
                    tabs: [
                      Tab(text: Languages.of(context)!.labelDescription),
                      const Tab(text: 'Chapters'),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 1.5, color: Theme.of(context).dividerColor.withOpacity(0.08), thickness: 1.5),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: const EdgeInsets.all(8).copyWith(top: 2),
                child: TabBarView(
                  children: [
                    _description(),
                    _segments(),
                  ],
                ),
              ),
            )
          ],
        )
      );
    }
  }

  Widget _segments() {
    final segments = widget.segments;
    return ListView.builder(
      itemCount: segments.length,
      padding: const EdgeInsets.only(top: 8),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final segment = segments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () => widget.onSegmentTap(segment.startTimeSeconds),
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(segment.previewUrl!),
                          fadeInDuration: const Duration(milliseconds: 300),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          segment.title ?? 'Unknown',
                          style: smallTextStyle(context, opacity: 1, bold: true),
                          maxLines: 2,
                        ),
                        Text(
                          "${Duration(seconds: segment.startTimeSeconds).inMinutes.toString().padLeft(2, '0')}:${Duration(seconds: segment.startTimeSeconds).inSeconds.remainder(60).toString().padLeft(2, '0')}",
                          style: smallTextStyle(context, opacity: 0.8)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _descriptionOnly() {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 12, left: 4, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(8).copyWith(top: 2, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 4),
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Iconsax.arrow_left)
              ),
              const SizedBox(width: 4),
              Text(Languages.of(context)!.labelDescription, style: subtitleTextStyle(context, bold: true).copyWith(fontSize: 16)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Theme.of(context).dividerColor.withOpacity(0.08), height: 1),
          Expanded(
            child: _description()
          )
        ],
      ),
    );
  }

  Widget _description() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 0),
      children: [
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(100)
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((widget.info.viewCount == -1 ? "" : "${NumberFormat.decimalPattern().format(widget.info.viewCount)} ${Languages.of(context)!.labelViews}  •  ${widget.info.uploadDate}"), style: smallTextStyle(context, opacity: 0.8)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          child: HtmlWidget(
            widget.info.description!,
            textStyle: smallTextStyle(context, opacity: 0.8),
            onTapUrl: (url) {
              if (url.contains('&t=')) {
                final seconds = url.split('&t=').last;
                widget.onSeek(Duration(seconds: int.parse(seconds)));
              } else {
                launchUrlString(url, mode: LaunchMode.externalApplication);
              }
              return true;
            },
          ),
        ),
      ],
    );
  }

}