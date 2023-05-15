import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: AvatarGlow(
                  repeat: true,
                  endRadius: 45,
                  showTwoGlows: false,
                  glowColor: Theme.of(context).colorScheme.secondary,
                  repeatPauseDuration: const Duration(milliseconds: 50),
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "SongTube",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontFamily: 'YTSans',
                    fontSize: 24),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "New version available",
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withOpacity(0.8),
                    fontSize: 16),
              ),
              const Spacer(),
              Text(
                widget.details.version,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "What's new:",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 16),
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
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.8),
                  fontFamily: 'YTSans',
                  fontSize: 16),
            )),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                AppUpdateManger.download(widget.details);
                return const _AppUpdate();
              },
            );
          },
          style: TextButton.styleFrom(
              fixedSize: const Size(100, 50),
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          child: const Text(
            "Update",
            style: TextStyle(
                color: Colors.white, fontFamily: 'YTSans', fontSize: 16),
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
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: "YTSans",
            fontSize: 20),
      ),
      content: StreamBuilder<double?>(
          stream: AppUpdateManger.downloadProgress.stream,
          builder: (context, snapshot) {
            final progress = snapshot.data ?? 0;
            final percent = (progress * 100).round();

            return Container(
              padding: const EdgeInsets.all(8.0),
              height: 45,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$percent%",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'YTSans',
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: Theme.of(context).cardColor,
                      value: progress,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
