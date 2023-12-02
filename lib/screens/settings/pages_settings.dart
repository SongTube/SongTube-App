import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/tiles/setting_tile.dart';

import '../../providers/app_settings.dart';

class PagesSettings extends StatefulWidget {
  const PagesSettings({super.key});

  @override
  State<PagesSettings> createState() => _PagesSettingsState();
}

class _PagesSettingsState extends State<PagesSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: (kToolbarHeight * 1.6)+12),
      children: [
        // Default landing page
        SettingTileDropdown(
          title: Languages.of(context)!.labelHomeScreen,
          subtitle: Languages.of(context)!.labelHomeScreenDescription,
          leadingIcon: LineIcons.home,
          currentValue: landingPageName(AppSettings.defaultLandingPage),
          onChange: (name) {
            if (name == null) {
              return;
            }
            AppSettings.defaultLandingPage = landingPageNameToIndex(name);
            setState(() {});
          },
          items: List.generate(4, (index) {
            return DropdownMenuItem(
              value: landingPageName(index),
              child: Text(landingPageName(index)),
            );
          })
        ),
        const SizedBox(height: 12),
        // Default landing page for Music Screen
        SettingTileDropdown(
          title: Languages.of(context)!.labelDefaultMusicPage,
          subtitle: Languages.of(context)!.labelDefaultMusicPageDescription,
          leadingIcon: LineIcons.music,
          currentValue: landingMusicPageName(AppSettings.defaultLandingMusicPage),
          onChange: (name) {
            if (name == null) {
              return;
            }
            AppSettings.defaultLandingMusicPage = landingMusicPageNameToIndex(name);
            setState(() {});
          },
          items: List.generate(5, (index) {
            return DropdownMenuItem(
              value: landingMusicPageName(index),
              child: Text(landingMusicPageName(index)),
            );
          })
        ),
        const SizedBox(height: 12),
        // Default landing page home page default
        // SettingTileDropdown(
        //   title: 'Default Home Page',
        //   subtitle: 'Change the default page for the Home Page',
        //   leadingIcon: Iconsax.home,
        //   currentValue: landingMusicPageName(AppSettings.defaultLandingMusicPage),
        //   onChange: (name) {
        //     if (name == null) {
        //       return;
        //     }
        //     AppSettings.defaultLandingMusicPage = landingMusicPageNameToIndex(name);
        //     setState(() {});
        //   },
        //   items: List.generate(5, (index) {
        //     return DropdownMenuItem(
        //       value: landingMusicPageName(index),
        //       child: Text(landingMusicPageName(index)),
        //     );
        //   })
        // ),
      ],
    );
  }

  // Get landing page name from index
  String landingPageName(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Music';
      case 2:
        return 'Downloads';
      case 3:
        return 'Library';
      default:
        return 'Home';
    }
  }

  // Transform landing page name to index
  int landingPageNameToIndex(String name) {
    switch (name) {
      case 'Home':
        return 0;
      case 'Music':
        return 1;
      case 'Downloads':
        return 2;
      case 'Library':
        return 3;
      default:
        return 0;
    }
  }

  // Get landing page name from index for Music Screen
  String landingMusicPageName(int index) {
    switch (index) {
      case 0:
        return 'Recents';
      case 1:
        return 'Music';
      case 2:
        return 'Playlist';
      case 3:
        return 'Album';
      case 4:
        return 'Artist';
      default:
        return 'Recents';
    }
  }

  // Transform landing page name to index for Music Page
  int landingMusicPageNameToIndex(String name) {
    switch (name) {
      case 'Recents':
        return 0;
      case 'Music':
        return 1;
      case 'Playlist':
        return 2;
      case 'Album':
        return 3;
      case 'Artist':
        return 4;
      default:
        return 0;
    }
  }

}