import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/ui/text_styles.dart';

class DownloadsCanceledPage extends StatelessWidget {
  const DownloadsCanceledPage({super.key});

  @override
  Widget build(BuildContext context) {
    DownloadProvider downloadProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: downloadProvider.canceled.isEmpty
        ? Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Ionicons.close, size: 64),
              const SizedBox(height: 8),
              Text(Languages.of(context)!.labelNoDownloadsCanceled, style: textStyle(context)),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Text(Languages.of(context)!.labelNoDownloadsCanceledDescription, style: subtitleTextStyle(context, opacity: 0.6), textAlign: TextAlign.center,),
              ),
            ],
          ))
        : _body(),
    );
  }

  Widget _body() {
    return const SizedBox();
  }
}