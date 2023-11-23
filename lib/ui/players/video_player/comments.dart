import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';
import 'package:image_fade/image_fade.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newpipeextractor_dart/models/comment.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/color_utils.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/animations/show_up.dart';
import 'package:songtube/ui/components/shimmer_container.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:html/parser.dart';

class VideoPlayerCommentsCollapsed extends StatefulWidget {
  const VideoPlayerCommentsCollapsed({
    required this.comments,
    required this.commentsAvailable,
    super.key});
  final List<YoutubeComment> comments;
  final bool commentsAvailable;
  @override
  State<VideoPlayerCommentsCollapsed> createState() => _VideoPlayerCommentsCollapsedState();
}

class _VideoPlayerCommentsCollapsedState extends State<VideoPlayerCommentsCollapsed> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(top: widget.commentsAvailable ? 16 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.commentsAvailable ? Theme.of(context).cardColor : Colors.transparent,
        ),
        padding: const EdgeInsets.all(8).copyWith(left: 16, right: 16, top: widget.commentsAvailable ? 8 : 0, bottom: widget.commentsAvailable ? 8 : 0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: widget.commentsAvailable ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Languages.of(context)!.labelComments,
                                style: subtitleTextStyle(context).copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.2)
                              ),
                              AnimatedText(
                                "  •  ${Languages.of(context)!.labelSeeMore}",
                                style: tinyTextStyle(context).copyWith(fontWeight: FontWeight.normal),
                                auto: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: widget.comments.isNotEmpty
                              ? _commentPreview()
                              : _commentShimmer(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ) : const SizedBox(),
          ),
        )
      ),
    );
  }

  Widget _commentPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 34,
          width: 34,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ImageFade(
              fadeDuration: const Duration(milliseconds: 300),
              placeholder: const ShimmerContainer(width: 34, height: 34),
              image: NetworkImage(widget.comments.first.uploaderAvatarUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: smallTextStyle(context),
              children: [
                // Author name
                TextSpan(
                  text: '${widget.comments.first.author}  ',
                  style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12),
                ),
                // Author message
                TextSpan(
                  text: parse(parse(widget.comments.first.commentText).body?.text).documentElement?.text ?? ' ',
                )
              ]
            )
          ),
        ),
      ],
    );
  }

  Widget _commentShimmer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ShimmerContainer(width: 34, height: 34, borderRadius: BorderRadius.circular(100)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerContainer(width: MediaQuery.of(context).size.width*0.5, height: 15, borderRadius: BorderRadius.circular(100)),
            const SizedBox(height: 5),
            ShimmerContainer(width: MediaQuery.of(context).size.width*0.3, height: 10, borderRadius: BorderRadius.circular(100)),
          ],
        ),
      ],
    );
  }

}

class VideoPlayerCommentsExpanded extends StatelessWidget {
  const VideoPlayerCommentsExpanded({
    required this.comments,
    required this.onBack,
    required this.onSeek,
    super.key});
  final List<YoutubeComment> comments;
  final Function() onBack;
  final Function(Duration) onSeek;
  @override
  Widget build(BuildContext context) {
    final pinnedComment = comments.firstWhereOrNull((element) => element.pinned ?? false);
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 0, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(8).copyWith(top: 2, left: 0, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              Semantics(
                label: 'Go back',
                child: IconButton(
                  onPressed: onBack,
                  icon: const AppAnimatedIcon(Iconsax.arrow_left, size: 20)
                ),
              ),
              const SizedBox(width: 4),
              Text(Languages.of(context)!.labelComments, style: subtitleTextStyle(context)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Theme.of(context).dividerColor.withOpacity(0.08), height: 1, indent: 8),
          Expanded(
            child: ShowUpTransition(
              slideSide: SlideFromSlide.bottom,
              delay: const Duration(milliseconds: 100),
              child: ListView(
                
                padding: const EdgeInsets.only(top: 12, left: 4, right: 8, bottom: 16),
                children: [
                  if (pinnedComment != null)
                  Container(
                    child: _commentTile(context, pinnedComment),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: kToolbarHeight),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      if (comment.pinned ?? false) {
                        return const SizedBox();
                      } 
                      return _commentTile(context, comment);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _commentTile(BuildContext context, YoutubeComment comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 34,
            width: 34,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ImageFade(
                fadeDuration: const Duration(milliseconds: 300),
                placeholder: ShimmerContainer(width: 34, height: 34, color: Theme.of(context).cardColor),
                image: NetworkImage(comment.uploaderAvatarUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment.author?.replaceRange(0, 1, '') ?? 'Unknown', style: smallTextStyle(context, opacity: 0.6)),
                    const SizedBox(width: 12),
                    if (comment.pinned ?? false)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedText(Languages.of(context)!.labelPinned, style: tinyTextStyle(context, bold: true), auto: true),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 2),
                Consumer<MediaProvider>(
                  builder: (context, provider, _) {
                    return HtmlWidget(
                      comment.commentText!,
                      textStyle: smallTextStyle(context).copyWith(),
                      onTapUrl: (url) {
                        if (url.contains('&t=')) {
                          final seconds = url.split('&t=').last;
                          onSeek(Duration(seconds: int.parse(seconds)));
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
                    );
                  }
                ),
                const SizedBox(height: 8),
                // Like count
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppAnimatedIcon(LineIcons.thumbsUp, size: 18),
                      const SizedBox(width: 6),
                      Text((comment.likeCount == -1 ? "" : "${NumberFormat.compact().format(comment.likeCount)} Likes"), style: tinyTextStyle(context, opacity: 0.6)),
                      if (comment.hearted ?? false)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 12),
                          const AppAnimatedIcon(Ionicons.heart, size: 18),
                          const SizedBox(width: 6),
                          Text(Languages.of(context)!.labelLikedByAuthor, style: tinyTextStyle(context, opacity: 0.8)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}