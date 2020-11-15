import 'package:circular_check_box/circular_check_box.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';

class MusicPlayerSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Row(
        children: [
          Icon(
            EvaIcons.brushOutline,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(width: 8),
          Text(
            "Player Settings",
            style: TextStyle(
              fontFamily: 'YTSans',
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Blurred Background
          ListTile(
            title: Text(
              "Blur Background",
              style: TextStyle(
                fontFamily: 'YTSans',
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
              ),
            ),
            onTap: () {
              appData.useBlurBackground = !appData.useBlurBackground;
            },
            trailing: CircularCheckBox(
              value: appData.useBlurBackground,
              onChanged: (_) { appData.useBlurBackground = !appData.useBlurBackground; },
            ),
          ),
          // Expanded Artwork
          ListTile(
            title: Text(
              "Expand Artwork",
              style: TextStyle(
                fontFamily: 'YTSans',
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
              ),
            ),
            onTap: () {
              appData.useExpandedArtwork = !appData.useExpandedArtwork;
            },
            trailing: CircularCheckBox(
              value: appData.useExpandedArtwork,
              onChanged: (_) { appData.useExpandedArtwork = !appData.useExpandedArtwork; },
            ),
          )
        ],
      ),
    );
  }
}