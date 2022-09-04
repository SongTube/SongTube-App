![](https://i.imgur.com/Y80SpfK.jpg)

SongTube is a new beautiful and fast application made in flutter, it supports YouTube audio and video downloading at any quality, In-App YouTube Browser, audio conversion, Playlists and an Audio tags editor.

---

## Features

+ Video Download at any available Quality
+ Download HDR and 60fps Videos
+ Audio Download at best available Quality
+ Audio Tags & Artwork Editor
+ Audio Filters (Volume, Bass, Treble)
+ Audio Conversion (AAC, OGG and MP3) (optional)
+ Full Playlist Downloads (Only Audio)
+ Set custom path for Audio/Video download
+ Music Player built-in
+ Video Player built-in
+ Music Equalizer
+ Music Playlists
+ Youtube Videos Playlists
+ In-App Youtube Browser
+ Light/Dark/Black Themes
+ Accent Color Picker
+ UI Customizations

---

## Download SongTube

You can get this application from the Official SongTube Channel on **Telegram:** https://t.me/songtubechannel **You can also join SongTube Official Group from the Channel, any kind of issue report or recommendation is welcomed!**

Other SongTube download sites:

+ Drive: https://tinyurl.com/SongTubeDrive
+ GitHub: https://tinyurl.com/STGithub
+ AppGallery: https://tinyurl.com/STAppGallery

---

## Contribute

You can contribute on anything you want from new features fixes, etc... But most importantly if the app doesn't support
your native Language you can contribute by implementing it! It's really easy:

**1st Step:** Create a new Language File by creating it under this project's **internal/languages** folder, the file needs to be named: "language**Code**.dart" (**Code** is the LanguageCode of the Language you are implementing, for example: **En** or **Es**), you can then copy the contents of any other already supported Language and adapt/translate it to your new one (Remember to change the class name to "Language**Code**").

**2nd Step:** To finish your implementation, open this file: [languages.dart](https://github.com/SongTube/SongTube-App/blob/master/lib/internal/languages.dart)

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
- Indonesian (Thanks to [@breakdowns](https://github.com/breakdowns))
- Turkish (Thanks to Barış Kırmızı)
- Russian (Thanks yxur_bruh)
- Arabic (Thanks JOOD_TECH)
- Somali (Thanks [@nadiration](https://github.com/nadiration))
- German (Thanks [@Paduu29](https://github.com/Paduu29))
- Bengali (Thanks [@pieas-asif](https://github.com/pieas-asif))
- Ukrainian (Thanks [@redman-dev29](https://github.com/redman-dev29))
- Japanese (Thanks to [@HiSubway](https://github.com/HiSubway))
- Italian (Thanks to [@alpha4041](https://github.com/alpha4041))

---