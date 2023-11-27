import 'package:iconsax/iconsax.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/add_to_stream_playlist.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/ui/ui_utils.dart';

class NewStreamPlaylist extends StatefulWidget {
  const NewStreamPlaylist({
    this.fallbackStream,
    Key? key}) : super(key: key);
  final StreamInfoItem? fallbackStream;
  @override
  State<NewStreamPlaylist> createState() => _NewStreamPlaylistState();
}

class _NewStreamPlaylistState extends State<NewStreamPlaylist> {

  // Content Provider
  ContentProvider get contentProvider => Provider.of(context, listen: false);

  // New Playlist name text controller
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0, right: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (widget.fallbackStream != null)
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      UiUtils.showModal(
                        context: internalNavigatorKey.currentContext!,
                        modal: AddToStreamPlaylist(stream: widget.fallbackStream!),
                      );
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelCreateVideoPlaylist, style: textStyle(context, bold: false))),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: kToolbarHeight,
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          const AppAnimatedIcon(Icons.title_outlined),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              controller: controller,
                              decoration: InputDecoration.collapsed(hintText: Languages.of(context)!.labelPlaylistName, hintStyle: smallTextStyle(context, opacity: 0.6)),
                              style: smallTextStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {
                      contentProvider.streamPlaylistCreate(controller.text, 'User', widget.fallbackStream == null ? [] : [widget.fallbackStream!]);
                      Navigator.pop(context);
                      if (widget.fallbackStream != null) {
                        UiUtils.showModal(
                          context: internalNavigatorKey.currentContext!,
                          modal: AddToStreamPlaylist(stream: widget.fallbackStream!),
                        );
                      }
                    },
                    child: AnimatedText(Languages.of(context)!.labelCreate, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold), auto: true)
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}