import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:songtube/ui/text_styles.dart';

import '../../internal/models/update/update_detail.dart';
import '../../internal/models/update/update_manger.dart';

class AppUpdateDialog extends StatefulWidget {
  final UpdateDetails details;
  const AppUpdateDialog({required this.details, super.key});

  @override
  State<AppUpdateDialog> createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: AvatarGlow(
                  repeat: true,
                  endRadius: 45,
                  showTwoGlows: false,
                  glowColor: Theme.of(context).primaryColor,
                  repeatPauseDuration: const Duration(milliseconds: 50),
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SongTube",
                    style: bigTextStyle(context).copyWith(fontSize: 26)
                  ),
                  Row(
                    children: [
                      Text(
                        "App Update  ->  ",
                        style: subtitleTextStyle(context)
                      ),
                      Text(
                        widget.details.version.split('+').first,
                        style: subtitleTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor)
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "What's new?",
              style: subtitleTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor)
            ),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: MarkdownBody(data: widget.details.updateDetails)),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Later",
              style: subtitleTextStyle(context)
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 8),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  // AppUpdateManger.download(widget.details);
                  return const _AppUpdate();
                },
              );
            },
            style: TextButton.styleFrom(
                fixedSize: const Size(100, 50),
                backgroundColor:
                    Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                )),
            child: Text(
              "Update",
              style: subtitleTextStyle(context).copyWith(color: Colors.white)
            ),
          ),
        ),
      ],
    );
  }
}

class _AppUpdate extends StatelessWidget {
  const _AppUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Downloading",
        style: textStyle(context)
      ),
      content: StreamBuilder<double?>(
          stream: AppUpdateManger.downloadProgress.stream,
          builder: (context, snapshot) {
            final progress = snapshot.data ?? 0;
            final percent = (progress * 100).round();

            return Container(
              padding: const EdgeInsets.all(8.0),
              height: 50,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$percent%",
                        style: subtitleTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor)
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: Theme.of(context).cardColor.withOpacity(0.2),
                      value: progress,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
