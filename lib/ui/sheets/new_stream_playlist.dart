import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/add_to_stream_playlist.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom+12),
      padding: const EdgeInsets.all(16).copyWith(left: 16, right: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                if (widget.fallbackStream != null)
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                      return AddToStreamPlaylist(stream: widget.fallbackStream!);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Ionicons.arrow_back_outline, color: Theme.of(context).primaryColor),
                  )
                ),
                Expanded(child: Text(Languages.of(context)!.labelCreateVideoPlaylist, style: textStyle(context))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(indent: 12, endIndent: 12, color: Theme.of(context).dividerColor),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: kToolbarHeight,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.title_outlined, color: Theme.of(context).primaryColor),
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
              TextButton(
                onPressed: () {
                  contentProvider.streamPlaylistCreate(controller.text, 'User', widget.fallbackStream == null ? [] : [widget.fallbackStream!]);
                  Navigator.pop(context);
                  if (widget.fallbackStream != null) {
                    showModalBottomSheet(context: context, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                      return AddToStreamPlaylist(stream: widget.fallbackStream!);
                    });
                  }
                },
                child: Text(Languages.of(context)!.labelSave, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))
              )
            ],
          )
        ],
      ),
    );
  }
}