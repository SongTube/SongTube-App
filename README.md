![](https://imgur.com/vcsnxWV.jpg)

SongTube is a new beautiful and fast application made in Flutter, it supports an almost full original experience, with many features music oriented features, including a full music player.


## App Features

+ Fully featured music player
+ Fully featured video player
+ Audio tags & artwork editor
+ Video & Audio download up to full quality
+ Audio download features (Volume, Bass & Treble gain)
+ Audio download conversion (AAC, OGG and MP3)
+ View, create or save playlists
+ Subscribe to any channel
+ Picture-in-Picture support
+ Background Playback (Implementation is in Alpha stage)
+ Save videos to favorites
+ Watch history (Can be paused in settings)
+ Video search filters
+ Open any video from an external app via share
+ Custom download path for audio & video separately
+ Music equalizer
+ Music playlists
+ System, Light & Dark Themes
+ UI Customizations
+ Backup & restore local data


## Download SongTube

You can get this application from the official SongTube Channel on Telegram: https://t.me/songtubechannel (You can also join SongTube official group from the channel, any kind of issue report or recommendation is welcomed!)

Other SongTube download sites:

+ Drive: https://tinyurl.com/SongTubeDrive
+ GitHub: https://tinyurl.com/STGithub


## SongTube Link

This is a Chromium extension for your desktop browser that allows you to send videos to Songtube, to watch or instantly start downloading as Music (Format is determined by the app settings instant download format). This extension requires a desktop app to automatically detect your device or you can manually input your device IP Address to connect.

For more information, downloads and how to use, please refer to [SongTube Link](https://github.com/SongTube/songtube_link_extension) repo.

## Contribute

You can contribute on anything you want from new features fixes, etc... But, if the app doesn't support
your native language, you can contribute by implementing it! It's really easy:

**1st Step:** Create a new language file by creating it under this project's **languages/translations** folder, the file needs to be named: "language**Code**.dart" (**Code** is the LanguageCode of the Language you are implementing, for example: **En** or **Es**), you can then copy the contents of any other already supported Language and adapt/translate it to your new one (Remember to change the class name to "Language**Code**").

**2nd Step:** To finish your implementation, open this file: [languages.dart](https://github.com/SongTube/SongTube-App/blob/master/lib/languages/languages.dart)

Inside that file you will find at the first code lines:

```dart
final _supportedLanguages = <LanguageData>[
  // English (US)
  LanguageData("🇺🇸", "English", 'en'),
  // Spanish (VE)
  LanguageData("ve", "Español", "es"),
];
Future<Languages> _loadLocale(Locale locale) async {
  switch (locale.languageCode) {
    // English (US)
    case 'en':
      return LanguageEn();
    // Spanish (VE)
    case 'es':
      return LanguageEs();
    // Default Language (English)
    default:
      return LanguageEn();
  }
}
```

Where for your new Language you have to add a new LanguageData(flag, name, languageCode) into the **_supportedLanguages** list, then, a new switch case in **_loadLocale()** function with your languageCode and return your new language File, open a Pull Request and after checking I will merge it!.

*If you don't feel like doing this last step, you can still send me your new Language File via PullRequest and I will do it.*

**Current list of Languages Supported:**

- English
- Español
- Português (Thanks to [@RickyM7](https://github.com/RickyM7))
- Igbo (Thanks to [@enweazudaniel](https://github.com/enweazudaniel))


---
