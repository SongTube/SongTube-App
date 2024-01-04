import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/internal/enums/download_type.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/menus/download_menu/music.dart';
import 'package:songtube/ui/menus/download_menu/video.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';

class DownloadContentMenu extends StatefulWidget {
  const DownloadContentMenu({
    required this.videoDetails,
    this.url,
    super.key}) : assert(
      videoDetails != null || url != null
    );
  final YoutubeVideo? videoDetails;
  final String? url;
  @override
  State<DownloadContentMenu> createState() => _DownloadContentMenuState();
}

class _DownloadContentMenuState extends State<DownloadContentMenu> {

  // Download Video
  YoutubeVideo? video;

  @override
  void initState() {
    video = widget.videoDetails;
    if (video == null) {
      getVideo();
    }
    super.initState();
  }

  void getVideo() async {
    video = await VideoExtractor.getStream(widget.url!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelDownload, style: textStyle(context, bold: false))),
                ],
              ),
              const SizedBox(height: 12),
              AnimatedSize(
                duration: kAnimationDuration,
                curve: kAnimationCurve,
                child: AnimatedSwitcher(
                  duration: kAnimationDuration,
                  switchInCurve: kAnimationCurve,
                  child: video != null ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _optionTile(context, title: Languages.of(context)!.labelMusic, subtitle: Languages.of(context)!.labelMusicDownloadDescription, icon: Ionicons.musical_notes_outline, onTap: () {
                        // Open Music Download Menu
                        Navigator.pop(context);
                        UiUtils.showModal(
                          context: context,
                          modal: AudioDownloadMenu(
                            video: video!,
                          ),
                        );
                      }),
                      _optionTile(context, title: Languages.of(context)!.labelVideo, subtitle: Languages.of(context)!.labelVideoDownloadDescription, icon: Ionicons.videocam_outline, onTap: () {
                        // Open Video Download Menu
                        Navigator.pop(context);
                        UiUtils.showModal(
                          context: context,
                          modal: VideoDownloadMenu(
                            video: video!,
                          )
                        );
                      }),
                      _optionTile(context, title: Languages.of(context)!.labelInstant, subtitle: Languages.of(context)!.labelInstantDescription, icon: Ionicons.flash_outline,
                        trailing: SizedBox(
                          height: 30,
                          child: Consumer<MediaProvider>(
                            builder: (context, provider, _) {
                              return DropdownButton<String>(
                                value: sharedPreferences.getString('instant_download_format') ?? 'AAC',
                                iconSize: 18,
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: provider.currentColors.vibrant,
                                elevation: 0,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                  fontFamily: 'Product Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12
                                ),
                                underline: Container(),
                                items: const [
                                  DropdownMenuItem(
                                    value: "AAC",
                                    child: Text("AAC"),
                                  ),
                                  DropdownMenuItem(
                                    value: "OGG",
                                    child: Text("OGG"),
                                  )
                                ],
                                onChanged: (String? value) async {
                                  if (value == "AAC") {
                                    await sharedPreferences.setString('instant_download_format', 'AAC');
                                    setState(() {});
                                  } else if (value == "OGG") {
                                    await sharedPreferences.setString('instant_download_format', 'OGG');
                                    setState(() {});
                                  }
                                },
                              );
                            }
                          ),
                        ),
                        onTap: () {
                          // Get default format
                          final format = sharedPreferences.getString('instant_download_format') ?? 'AAC';
                          // Build download
                          final downloadInfo = DownloadInfo(
                            url: video!.videoInfo.url!,
                            name: video!.videoInfo.name ?? 'Unknown',
                            duration: video!.videoInfo.length!,
                            downloadType: DownloadType.audio,
                            audioStream: format == 'AAC'
                              ? video!.audioWithBestAacQuality!
                              : video!.audioWithBestOggQuality!,
                            tags: AudioTags.withStreamInfoItem(video!.toStreamInfoItem()),
                          );
                          final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
                          downloadProvider.handleDownloadItem(info: downloadInfo);
                          Navigator.pop(context);
                        }
                      ),
                    ],
                  ) : _loading(),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget _loading() {
    MediaProvider mediaProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(
            width: 30, height: 30,
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(mediaProvider.currentColors.vibrant))),
          const SizedBox(width: 24),
          Text(Languages.of(context)!.labelPleaseWaitAMoment, style: subtitleTextStyle(context))
        ],
      ),
    );
  }

  Widget _optionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Function() onTap, Function()? onConfigure, Widget? trailing}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
        height: kToolbarHeight+4,
        child: Row(
          children: [
            AppAnimatedIcon(icon, color: icon == LineIcons.trash ? Colors.red : null),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: smallTextStyle(context)),
                  Text(subtitle, style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12), maxLines: 2)
                ],
              ),
            ),
            if (onConfigure != null)
            IconButton(
              onPressed: onConfigure,
              icon: Icon(Iconsax.setting, color: Theme.of(context).primaryColor)
            ),
            if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: trailing,
            )
          ],
        ),
      ),
    );
  }
}