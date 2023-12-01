import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/videoInfo.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/color_utils.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
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
            Row(
              children: [
                const SizedBox(width: 4),
                Semantics(
                  label: 'Go back',
                  child: IconButton(
                    onPressed: widget.onBack,
                    icon: const AppAnimatedIcon(EvaIcons.arrowBackOutline, size: 20)
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Consumer<MediaProvider>(
                    builder: (context, provider, _) {
                      return TabBar(
                        padding: const EdgeInsets.only(left: 8),
                        labelColor: provider.currentColors.vibrant,
                        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                        labelStyle: tabBarTextStyle(context, opacity: 1),
                        unselectedLabelStyle: tabBarTextStyle(context, bold: false),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: provider.currentColors.vibrant,
                        tabs: [
                          Tab(text: Languages.of(context)!.labelDescription),
                          const Tab(text: 'Chapters'),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).dividerColor.withOpacity(0.08), height: 1, indent: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: TabBarView(
                  children: [
                    _description(),
                    Padding(
                      padding: const EdgeInsets.all(12.0).copyWith(top: 0),
                      child: _segments(),
                    ),
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
      padding: const EdgeInsets.only(top: 12),
      
      itemBuilder: (context, index) {
        final segment = segments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () => widget.onSegmentTap(segment.startTimeSeconds),
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          segment.title ?? 'Unknown',
                          style: smallTextStyle(context),
                          maxLines: 2,
                        ),
                        Text(
                          "${Duration(seconds: segment.startTimeSeconds).inMinutes.toString().padLeft(2, '0')}:${Duration(seconds: segment.startTimeSeconds).inSeconds.remainder(60).toString().padLeft(2, '0')}",
                          style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
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
      margin: const EdgeInsets.only(top: 4, left: 0, right: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(8).copyWith(top: 2, left: 0, bottom: 0, right: 0),
      child: Column(
        children: [
          Row(
            children: [
              Semantics(
                label: 'Go back',
                child: IconButton(
                  onPressed: widget.onBack,
                  icon: const AppAnimatedIcon(Iconsax.arrow_left, size: 20)
                ),
              ),
              const SizedBox(width: 4),
              Text(Languages.of(context)!.labelDescription, style: subtitleTextStyle(context)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: _description()
          )
        ],
      ),
    );
  }

  Widget _description() {
    return ListView(
      padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text((widget.info.viewCount == -1 ? "" : "${NumberFormat.decimalPattern().format(widget.info.viewCount)} ${Languages.of(context)!.labelViews}  •  ${widget.info.uploadDate}"), style: subtitleTextStyle(context, opacity: 0.6)),
              ],
            ),
          ),
        ),
        if (widget.info.description?.isNotEmpty ?? false)
        Consumer<MediaProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.all(16),
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
                customStylesBuilder: (element) {
                  if (element.localName?.contains('a') ?? false) {
                    return {'color': '#${ColorUtils.toHex(provider.currentColors.vibrant!)}'};
                  }
                  return null;
                },
              ),
            );
          }
        ),
        if (widget.info.description?.isEmpty ?? true)
        Center(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('This video has no description', style: subtitleTextStyle(context, opacity: 0.6)),
        )),
        const SizedBox(height: kToolbarHeight*1.6)
      ],
    );
  }

}