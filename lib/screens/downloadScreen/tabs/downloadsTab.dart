// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Internal
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/provider/downloadsProvider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/screens/downloadScreen/components/downloadTile.dart';
import 'package:autolist/autolist.dart';

// UI
import 'package:songtube/screens/downloadScreen/components/downloadsEmpty.dart';

class DownloadsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: downloadsBody(context)
    );
  }

  Widget downloadsBody(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    if (downloadsProvider.completedList.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: AutoList<DownloadInfoSet>(
          physics: BouncingScrollPhysics(),
          items: downloadsProvider.completedList,
          duration: Duration(milliseconds: 400),
          itemBuilder: (context, infoset) {
            return Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: DownloadTile(
                dataProgress: infoset.dataProgress.stream,
                progressBar: infoset.progressBar.stream,
                currentAction: infoset.currentAction.stream,
                metadata: infoset.metadata,
                downloadType: infoset.downloadType,
                onDownloadCancel: null,
                cancelDownloadIcon: Container()
              )
            );
          },
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: const NoDownloads()
      );
    }
  }
}