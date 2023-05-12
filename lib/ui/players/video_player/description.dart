import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newpipeextractor_dart/models/videoInfo.dart';
import 'package:songtube/ui/animations/show_up.dart';
import 'package:songtube/ui/components/linkify_text.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VideoPlayerDescription extends StatelessWidget {
  const VideoPlayerDescription({
    required this.info,
    required this.onBack,
    required this.onSeek,
    super.key});
  final VideoInfo info;
  final Function() onBack;
  final Function(Duration) onSeek;
  @override
  Widget build(BuildContext context) {
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
                onPressed: onBack,
                icon: const Icon(Iconsax.arrow_left)
              ),
              const SizedBox(width: 4),
              Text('Description', style: subtitleTextStyle(context, bold: true).copyWith(fontSize: 16)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Theme.of(context).dividerColor.withOpacity(0.08), height: 1),
          Expanded(
            child: ListView(
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
                        Text((info.viewCount == -1 ? "" : "${NumberFormat.decimalPattern().format(info.viewCount)} views  •  ${info.uploadDate}"), style: smallTextStyle(context, opacity: 0.8)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: HtmlWidget(
                    info.description!,
                    textStyle: smallTextStyle(context, opacity: 0.8),
                    onTapUrl: (url) {
                      if (url.contains('&t=')) {
                        final seconds = url.split('&t=').last;
                        onSeek(Duration(seconds: int.parse(seconds)));
                      } else {
                        launchUrlString(url);
                      }
                      return true;
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}