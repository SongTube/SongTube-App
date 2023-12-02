import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/settings/download_settings.dart';
import 'package:songtube/screens/settings/general_settings.dart';
import 'package:songtube/screens/settings/music_player_settings.dart';
import 'package:songtube/screens/settings/pages_settings.dart';
import 'package:songtube/screens/settings/video_player_settings.dart';
import 'package:songtube/ui/text_styles.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> with TickerProviderStateMixin {

  // TabBar Controller
  late TabController tabController = TabController(length: 5, vsync: this);

  final List<Widget> pages = const [
    GeneralSettings(),
    PagesSettings(),
    DownloadSettings(),
    VideoPlayerSettings(),
    MusicPlayerSettings()
  ];
  
  Widget _tabs() {
    return SizedBox(
      height: kToolbarHeight,
      child: TabBar(
        padding: const EdgeInsets.only(left: 8),
        controller: tabController,
        isScrollable: true,
        labelColor: Provider.of<MediaProvider>(context).currentColors.vibrant,
        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
        labelStyle: tabBarTextStyle(context, opacity: 1),
        unselectedLabelStyle: tabBarTextStyle(context, bold: false),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        tabs: [
          // General Settings
          Tab(child: Text(Languages.of(context)!.labelGeneral)),
          // Customization Settings
          Tab(child: Text(Languages.of(context)!.labelPages)),
          // Download Settings
          Tab(child: Text(Languages.of(context)!.labelDownloads)),
          // Video Player Settings
          Tab(child: Text(Languages.of(context)!.labelVideos)),
          // Music Player Settings
          Tab(child: Text(Languages.of(context)!.labelMusicPlayer)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                const SizedBox(width: 4),
                Semantics(
                  label: 'Go back',
                  child: IconButton(
                    icon: Icon(Iconsax.arrow_left, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    Languages.of(context)!.labelSettings,
                    style: textStyle(context)
                  ),
                ),
                _createLanguageDropDown(context)
              ],
            ),
          ),
          _tabs(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: pages
            ),
          ),
        ],
      ),
    );
  }

  _createLanguageDropDown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 8),
      child: Semantics(
        label: 'Change language',
        child: DropdownButton<LanguageData>(
          alignment: Alignment.centerRight,
          iconSize: 26,
          hint: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              Localizations.localeOf(context).languageCode.toUpperCase(),
              style: subtitleTextStyle(context).copyWith(fontWeight: FontWeight.w900)
            ),
          ),
          icon: const SizedBox(),
          onChanged: (LanguageData? language) {
            if (language == null) return;
            changeLanguage(context, language.languageCode);
          },
          underline: DropdownButtonHideUnderline(child: Container()),
          items: supportedLanguages
            .map<DropdownMenuItem<LanguageData>>(
              (e) =>
              DropdownMenuItem<LanguageData>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.name,
                      style: subtitleTextStyle(context)
                    )
                  ],
                ),
              ),
            )
            .toList(),
        ),
      ),
    );
  }

}