import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/languages/languageRu.dart';
import 'package:songtube/main.dart';

// Language Files
import 'languages/languageEn.dart';
import 'languages/languageEs.dart';
import 'languages/languagePt-BR.dart';
import 'languages/languageIgbo-NG.dart';
import 'languages/languageId.dart';
import 'languages/languageTr.dart';
import 'languages/languageSo.dart';

/// Multi-Language Support for SongTube, for new Languages to be supported
/// a new [File] in this project [internal/languages] folder needs to be
/// created named: [language<Code>.dart], you can then copy the contents
/// of any other already supported Language and adapt/translate it to your
/// new one.
/// 
/// To finish your new Language implementation you would only need to add
/// a new [LanguageData] to the [_supportedLanguages] list bellow and a new
/// switch case to your Language File in [_loadLocale] also bellow this.
final supportedLanguages = <LanguageData>[
  // English (US)
  LanguageData("🇺🇸", "English", 'en'),
  // Spanish (VE)
  LanguageData("ve", "Español", "es"),
  // Portuguese (BR)
  LanguageData("🇧🇷", "Português", "pt"),
  // Igbo (NG)
  LanguageData("ng", "Igbo", "ig"),
  // Indonesia (ID)
  LanguageData("🇮🇩", "Indonesia", "id"),
  // Turkish (TR)
  LanguageData("tr", "Turkey", "tr"),
  // Russian (RU)
  LanguageData("ru", "Russian", "ru")
  // Somali (SO, ET, DJI, KEN)
  LanguageData("🇸🇴" "🇪🇹" "🇩🇯" "🇰🇪", "Soomaali", "so"),
];
Future<Languages> _loadLocale(Locale locale) async {
  switch (locale.languageCode) {
    // English (US)
    case 'en':
      return LanguageEn();
    // Spanish (VE)
    case 'es':
      return LanguageEs();
    // Portuguese (BR)
    case 'pt':
      return LanguagePtBr();
    // Igbo (NG)
    case 'ig':
      return LanguageIgbo();
    // Indonesia (ID)
    case 'id':
      return LanguageId();
    // Turkish (TR)
    case 'tr':
      return LanguageTr();
    // Russian (RU)
    case 'ru':
      return LanguageRu();
    // Somali (SO, ET, DJI, KEN)
    case 'so':
    return LanguageSo();
    // Default Language (English)
    default:
      return LanguageEn();
  }
}

// -------------------
// Language Data Class
// -------------------
class LanguageData {

  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

}

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    List<String> supportedLanguageCodes = [];
    supportedLanguages.forEach((element) =>
      supportedLanguageCodes.add(element.languageCode));
    return supportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<Languages> load(Locale locale) => _loadLocale(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
  
}

class FallbackLocalizationDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async => DefaultMaterialLocalizations();
  @override
  bool shouldReload(_) => false;
}

abstract class Languages {
  
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  // Introduction Screens
  String get labelAppWelcome;
  String get labelStart;
  String get labelSkip;
  String get labelNext;
  String get labelExternalAccessJustification;
  String get labelAppCustomization;
  String get labelSelectPreferred;
  String get labelConfigReady;
  String get labelIntroductionIsOver;
  String get labelEnjoy;
  String get labelGoHome;

  // Bottom Navigation Bar
  String get labelHome;
  String get labelDownloads;
  String get labelMedia;
  String get labelYouTube;
  String get labelMore;

  // Home Screen
  String get labelQuickSearch;
  String get labelTagsEditor;
  String get labelEditArtwork;
  String get labelDownloadAll;
  String get labelLoadingVideos;
  String get labelHomePage;
  String get labelTrending;
  String get labelFavorites;
  String get labelWatchLater;
  
  // Video Options Menu
  String get labelCopyLink;
  String get labelAddToFavorites;
  String get labelAddToWatchLater;

  // Downloads Screen
  String get labelQueued;
  String get labelDownloading;
  String get labelConverting;
  String get labelCancelled;
  String get labelCompleted;

  // Download Status/Error Messages
  String get labelDownloadQueued;
  String get labelDownloadAcesssDenied;
  String get labelClearingExistingMetadata;
  String get labelWrittingTagsAndArtwork;
  String get labelSavingFile;
  String get labelAndroid11FixNeeded;
  String get labelErrorSavingDownload;
  String get labelDownloadingVideo;
  String get labelDownloadingAudio;
  String get labelGettingAudioStream;
  String get labelAudioNoDataRecieved;
  String get labelDownloadStarting;
  String get labelDownloadCancelled;
  String get labelAnIssueOcurredConvertingAudio;
  String get labelPatchingAudio;

  // Download Menu
  String get labelEnableAudioConversion;
  String get labelGainControls;
  String get labelVolume;
  String get labelBassGain;
  String get labelTrebleGain;
  String get labelSelectVideo;
  String get labelSelectAudio;

  // Media Screen
  String get labelMusic;
  String get labelVideos;
  String get labelNoMediaYet;
  String get labelNoMediaYetJustification;
  String get labelSearchMedia;
  String get labelDeleteSong;
  String get labelNoPermissionJustification;
  String get labelGettingYourMedia;
  String get labelEditTags;

  // Navigate Screen
  String get labelSearchYoutube;

  // More Screen
  String get labelSettings;
  String get labelDonate;
  String get labelLicenses;
  String get labelChooseColor;
  String get labelTheme;
  String get labelUseSystemTheme;
  String get labelUseSystemThemeJustification;
  String get labelEnableDarkTheme;
  String get labelEnableDarkThemeJustification;
  String get labelEnableBlackTheme;
  String get labelEnableBlackThemeJustification;
  String get labelAccentColor;
  String get labelAccentColorJustification;
  String get labelAudioFolder;
  String get labelAudioFolderJustification;
  String get labelVideoFolder;
  String get labelVideoFolderJustification;
  String get labelAlbumFolder;
  String get labelAlbumFolderJustification;
  String get labelDeleteCache;
  String get labelDeleteCacheJustification;
  String get labelAndroid11Fix;
  String get labelAndroid11FixJustification;
  String get labelBackup;
  String get labelBackupJustification;
  String get labelRestore;
  String get labelRestoreJustification;
  String get labelBackupLibraryEmpty;
  String get labelBackupCompleted;
  String get labelRestoreNotFound;
  String get labelRestoreCompleted;
  String get labelCacheIsEmpty;
  String get labelYouAreAboutToClear;

  // Tags Editor TextFields
  String get labelEditorTitle;
  String get labelEditorArtist;
  String get labelEditorGenre;
  String get labelEditorDisc;
  String get labelEditorTrack;
  String get labelEditorDate;
  String get labelEditorAlbum;

  // Android 10 or 11 Detected Dialog
  String get labelAndroid11Detected;
  String get labelAndroid11DetectedJustification;

  // Music Player
  String get labelPlayerSettings;
  String get labelExpandArtwork;
  String get labelArtworkRoundedCorners;
  String get labelPlayingFrom;
  String get labelBlurBackground;

  // Video Page
  String get labelTags;
  String get labelRelated;
  String get labelAutoPlay;

  // Tags Pages
  String get labelAudioFormatNotCompatible;
  String get labelNotSpecified;
  String get labelPerformAutomaticTagging;
  String get labelSelectTagsfromMusicBrainz;
  String get labelSelectArtworkFromDevice;

  // Telegram Join Channel Dialog
  String get labelJoinTelegramChannel;
  String get labelJoinTelegramJustification;
  String get labelRemindLater;

  // Common Words (One word labels)
  String get labelExit;
  String get labelSystem;
  String get labelChannel;
  String get labelShare;
  String get labelAudio;
  String get labelVideo;
  String get labelDownload;
  String get labelBest;
  String get labelPlaylist;
  String get labelVersion;
  String get labelLanguage;
  String get labelGrant;
  String get labelAllow;
  String get labelAccess;
  String get labelEmpty;
  String get labelCalculating;
  String get labelCleaning;
  String get labelCancel;
  String get labelGeneral;
  String get labelRemove;
  String get labelJoin;
  String get labelNo;
  String get labelLibrary;

}

// ----------------------------------------
// Methods To Get, Set an Save App Language
// ----------------------------------------

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  Main.setLocale(context, _locale);
}
