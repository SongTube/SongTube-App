import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/internal/enums/download_type.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/ui/menus/download_menu/music.dart';
import 'package:songtube/ui/menus/download_menu/video.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/text_styles.dart';

class DownloadContentMenu extends StatefulWidget {
  const DownloadContentMenu({
    required this.content,
    super.key});
  final ContentWrapper content;

  @override
  State<DownloadContentMenu> createState() => _DownloadContentMenuState();
}

class _DownloadContentMenuState extends State<DownloadContentMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 12, bottom: 16,),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: BottomSheetPhill()),
            // Menu Title
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
                  ),
                ),
                const SizedBox(width: 4),
                Text(Languages.of(context)!.labelDownload, style: textStyle(context)),
              ],
            ),
            const SizedBox(height: 8),
            _optionTile(context, title: Languages.of(context)!.labelMusic, subtitle: Languages.of(context)!.labelMusicDownloadDescription, icon: Ionicons.musical_notes_outline, onTap: () {
              // Open Music Download Menu
              Navigator.pop(context);
              showModalBottomSheet(context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                return AudioDownloadMenu(
                  video: widget.content.videoDetails!,
                  onBack: () {
                    Navigator.pop(context);
                    showModalBottomSheet(context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: ((context) => DownloadContentMenu(content: widget.content)));
                  }
                );
              });
            }),
            _optionTile(context, title: Languages.of(context)!.labelVideo, subtitle: Languages.of(context)!.labelVideoDownloadDescription, icon: Ionicons.videocam_outline, onTap: () {
              // Open Video Download Menu
              Navigator.pop(context);
              showModalBottomSheet(context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                return VideoDownloadMenu(
                  video: widget.content.videoDetails!,
                  onBack: () {
                    Navigator.pop(context);
                    showModalBottomSheet(context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: ((context) => DownloadContentMenu(content: widget.content)));
                  }
                );
              });
            }),
            _optionTile(context, title: Languages.of(context)!.labelInstant, subtitle: Languages.of(context)!.labelInstantDescription, icon: Ionicons.flash_outline,
              trailing: SizedBox(
                height: 30,
                child: DropdownButton<String>(
                  value: sharedPreferences.getString('instant_download_format') ?? 'AAC',
                  iconSize: 18,
                  borderRadius: BorderRadius.circular(20),
                  iconEnabledColor: Theme.of(context).primaryColor,
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
                ),
              ),
              onTap: () {
                // Get default format
                final format = sharedPreferences.getString('instant_download_format') ?? 'AAC';
                // Build download
                final downloadInfo = DownloadInfo(
                  url: widget.content.videoDetails!.videoInfo.url!,
                  name: widget.content.videoDetails!.videoInfo.name ?? 'Unknown',
                  duration: widget.content.videoDetails!.videoInfo.length!,
                  downloadType: DownloadType.audio,
                  audioStream: format == 'AAC'
                    ? widget.content.videoDetails!.audioWithBestAacQuality!
                    : widget.content.videoDetails!.audioWithBestOggQuality!,
                  tags: AudioTags.withStreamInfoItem(widget.content.videoDetails!.toStreamInfoItem()),
                );
                final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
                downloadProvider.handleDownloadItem(info: downloadInfo);
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _optionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Function() onTap, Function()? onConfigure, Widget? trailing}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12, top: 10, bottom: 6),
        height: kToolbarHeight+16,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Icon(icon, color: icon == LineIcons.trash ? Colors.red : Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: subtitleTextStyle(context, bold: true)),
                  Text(subtitle, style: smallTextStyle(context, opacity: 0.8), maxLines: 3)
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