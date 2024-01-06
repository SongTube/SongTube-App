import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/sheets/snack_bar.dart';
import 'package:songtube/ui/text_styles.dart';

class DownloadingSnackbar extends StatelessWidget {
  const DownloadingSnackbar({
    required this.name,
    super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of(context);
    return CustomSnackBar(
      leading: const AppAnimatedIcon(Icons.cloud_download_rounded),
      title: name,
      subtitle: Languages.of(context)!.labelDownloadStarting,
      trailing: GestureDetector(
        onTap: () {
          uiProvider.fwController.close().then((value) {
            uiProvider.bottomNavigationBarIndex = 2;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.transparent,
          child: AnimatedText(
            'Show',
            style: smallTextStyle(context),
            auto: true,
          ),
        ),
      ),
    );
  }
}