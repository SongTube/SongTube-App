import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/languages/translations/languageAr.dart';
import 'package:songtube/languages/translations/languageCa.dart';
import 'package:songtube/languages/translations/languageCkb.dart';
import 'package:songtube/languages/translations/languageKu.dart';
import 'package:songtube/languages/translations/languagePl.dart';
import 'package:songtube/languages/translations/languageRu.dart';
import 'package:songtube/main.dart';

// Language Files
// import 'translations/languageCa.dart';
import 'translations/languageEn.dart';
import 'translations/languageAz.dart';
import 'translations/languageEs.dart';
import 'translations/languagePt-BR.dart';
import 'translations/languageRo.dart';
import 'translations/languageig-NG.dart';
import 'translations/languageId.dart';
import 'translations/languageVi.dart';
import 'translations/languageTr.dart';
import 'translations/languageSo.dart';
import 'translations/languageDe.dart';
import 'translations/languageBn.dart';
import 'translations/languageUa.dart';
import 'translations/languageIt.dart';
import 'translations/languageJa.dart';
import 'translations/languageFr.dart';
import 'translations/languageFa.dart';
import 'translations/languageZh-CN.dart';
import 'translations/languageCs.dart';
import 'translations/languageBg.dart';

/// Multi-Language Support for SongTube, for new Languages to be supported
/// a new [File] in this project [languages/translations] folder needs to be
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
  // Azerbaijani (AZ)
  LanguageData("az", "Azerbaijani", 'az'),
  // Spanish (VE)
  LanguageData("ve", "Español", "es"),
  // Portuguese (BR)
  LanguageData("🇧🇷", "Português", "pt"),
  // Igbo (NG)
  LanguageData("ng", "Igbo", "ig"),
  // Indonesia (ID)
  LanguageData("🇮🇩", "Indonesia", "id"),
  // Vietnamese (VI)
  LanguageData("🇻🇳", "Vietnamese", "vi"),
  // Turkish (TR)
  LanguageData("🇹🇷", "Turkish", "tr"),
  // Romanian (RO)
  LanguageData("🇷🇴", "Romanian", "ro"),
  // Russian (RU)
  LanguageData("ru", "Russian", "ru"),
  // Somali (SO, ET, DJI, KEN)
  LanguageData("🇸🇴" "🇪🇹" "🇩🇯" "🇰🇪", "Soomaali", "so"),
  // Arabic (AR)
  LanguageData("ar", "Arabic", "ar"),
  // German (DE)
  LanguageData("de", "Germin", "de"),
  // Bengali (BD)
  LanguageData("bd", "Bangla", "bn"),
  // Ukrainian (UA)
  LanguageData('ua', "Ukrainian", 'ua'),
  // Italian (IT)
  LanguageData("🇮🇹", "Italian", "it"),
  // Japanese (JA)
  LanguageData("🇯🇵", "Japanese", "ja"),
  // French (FR)
  LanguageData("🇫🇷", "French", "fr"),
  // Persian (IR)
  LanguageData("🇮🇷", "Persian", "fa"),
  // Chinese (CN)
  LanguageData("🇨🇳", "Simplified Chinese", "cn"),
  // Czech (CS)
  LanguageData("🇨🇿", "Čeština", "cs"),
  // Polish (PL)
  LanguageData("🇵🇱", "Polish", "pl"),
  // Sorani (CKB)
  LanguageData("ckb", "Kurdish(CKB)", "ku"),
  // Kurmanji (KU)
  LanguageData("ku", "Kurdish(KU)", "ku"),
  // Catalan (CA)
  LanguageData("ca", "Català", "ca"),
  // Bulgarian (BG)
  LanguageData("bg", "Bulgarian", "bg"),
];
Future<Languages> _loadLocale(Locale locale) async {
  switch (locale.languageCode) {
    // English (US)
    case 'en':
      return LanguageEn();
    // Azerbaijani (AZ)
    case 'az':
      return LanguageAz();
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
    // Indonesia (ID)
    case 'vi':
      return LanguageVi();
    // Turkish (TR)
    case 'tr':
      return LanguageTr();
    // Romanian (RO)
    case 'ro':
      return LanguageRo();
    // Russian (RU)
    case 'ru':
      return LanguageRu();
    // Somali (SO, ET, DJI, KEN)
    case 'so':
      return LanguageSo();
    // Arabic (AR)
    case 'ar':
      return LanguageAr();
    // German (DE)
    case 'de':
      return LanguageDe();
    // Bengali (BD)
    case 'bn':
      return LanguageBn();
    // Ukrainian
    case 'ua':
      return LanguageUa();
    // Italian (IT)
    case 'it':
      return LanguageIt();
    // Japanese (JA)
    case 'ja':
      return LanguageJa();
    // French (FR)
    case 'fr':
      return LanguageFr();
    // Persian (IR)
    case 'fa':
      return LanguageFa();
    // Kurdish (CKB) (CKB)
    case 'ckb':
      return LanguageCkb();
    // Kurdish (KU) (KU)
    case 'ku':
      return LanguageKu();
    // Chinses (CN)
    case 'cn':
      return LanguageZhCN();
    // Polish (PL)
    case 'pl':
      return LanguagePl();
    // Czech (CS)
    case 'cs':
      return LanguageCs();
    case 'ca':
      return LanguageCa();
    case 'bg':
      return LanguageBg();
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
    supportedLanguages
        .forEach((element) => supportedLanguageCodes.add(element.languageCode));
    return supportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<Languages> load(Locale locale) => _loadLocale(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

class FallbackLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();
  @override
  bool shouldReload(_) => false;
}

abstract class Languages {
  static Languages? of(BuildContext context) {
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
  String get labelAddToPlaylist;

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
  String get labelGlobalParameters;

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
  String get labelCreate;
  String get labelPlaylists;
  String get labelQuality;
  String get labelSubscribe;

  // Other Translations
  String get labelNoFavoriteVideos;
  String get labelNoFavoriteVideosDescription;
  String get labelNoSubscriptions;
  String get labelNoSubscriptionsDescription;
  String get labelNoPlaylists;
  String get labelNoPlaylistsDescription;
  String get labelSearch;
  String get labelSubscriptions;
  String get labelNoDownloadsCanceled;
  String get labelNoDownloadsCanceledDescription;
  String get labelNoDownloadsYet;
  String get labelNoDownloadsYetDescription;
  String get labelYourQueueIsEmpty;
  String get labelYourQueueIsEmptyDescription;
  String get labelQueue;
  String get labelSearchDownloads;
  String get labelWatchHistory;
  String get labelWatchHistoryDescription;
  String get labelBackupAndRestore;
  String get labelBackupAndRestoreDescription;
  String get labelSongtubeLink;
  String get labelSongtubeLinkDescription;
  String get labelSupportDevelopment;
  String get labelSocialLinks;
  String get labelSeeMore;
  String get labelMostPlayed;
  String get labelNoPlaylistsYet;
  String get labelNoPlaylistsYetDescription;
  String get labelNoSearchResults;
  String get labelSongResults;
  String get labelAlbumResults;
  String get labelArtistResults;
  String get labelSearchAnything;
  String get labelRecents;
  String get labelFetchingSongs;
  String get labelPleaseWaitAMoment;
  String get labelWeAreDone;
  String get labelEnjoyTheApp;
  String get labelSongtubeIsBackDescription;
  String get labelLetsGo;
  String get labelPleaseWait;
  String get labelPoweredBy;
  String get labelGetStarted;
  String get labelAllowUsToHave;
  String get labelStorageRead;
  String get labelStorageReadDescription;
  String get labelContinue;
  String get labelAllowStorageRead;
  String get labelSelectYourPreferred;
  String get labelLight;
  String get labelDark;
  String get labelSimultaneousDownloads;
  String get labelSimultaneousDownloadsDescription;
  String get labelItems;
  String get labelInstantDownloadFormat;
  String get labelInstantDownloadFormatDescription;
  String get labelCurrent;
  String get labelPauseWatchHistory;
  String get labelPauseWatchHistoryDescription;
  String get labelLockNavigationBar;
  String get labelLockNavigationBarDescription;
  String get labelPictureInPicture;
  String get labelPictureInPictureDescription;
  String get labelBackgroundPlaybackAlpha;
  String get labelBackgroundPlaybackAlphaDescription;
  String get labelBlurBackgroundDescription;
  String get labelBlurIntensity;
  String get labelBlurIntensityDescription;
  String get labelBackdropOpacity;
  String get labelBackdropOpacityDescription;
  String get labelArtworkShadowOpacity;
  String get labelArtworkShadowOpacityDescription;
  String get labelArtworkShadowRadius;
  String get labelArtworkShadowRadiusDescription;
  String get labelArtworkScaling;
  String get labelArtworkScalingDescription;
  String get labelBackgroundParallax;
  String get labelBackgroundParallaxDescription;
  String get labelRestoreThumbnails;
  String get labelRestoreThumbnailsDescription;
  String get labelRestoringArtworks;
  String get labelRestoringArtworksDone;
  String get labelHomeScreen;
  String get labelHomeScreenDescription;
  String get labelDefaultMusicPage;
  String get labelDefaultMusicPageDescription;
  String get labelAbout;
  String get labelConversionRequired;
  String get labelConversionRequiredDescription;
  String get labelPermissionRequired;
  String get labelPermissionRequiredDescription;
  String get labelApplying;
  String get labelConvertingDescription;
  String get labelWrittingTagsAndArtworkDescription;
  String get labelApply;
  String get labelSongs;
  String get labelPlayAll;
  String get labelPlaying;
  String get labelPages;
  String get labelMusicPlayer;
  String get labelClearWatchHistory;
  String get labelClearWatchHistoryDescription;
  String get labelDelete;
  String get labelAppUpdate;
  String get labelWhatsNew;
  String get labelLater;
  String get labelUpdate;
  String get labelUnsubscribe;
  String get labelAudioFeatures;
  String get labelVolumeBoost;
  String get labelNormalizeAudio;
  String get labelSegmentedDownload;
  String get labelEnableSegmentedDownload;
  String get labelEnableSegmentedDownloadDescription;
  String get labelCreateMusicPlaylist;
  String get labelCreateMusicPlaylistDescription;
  String get labelApplyTags;
  String get labelApplyTagsDescription;
  String get labelLoading;
  String get labelMusicDownloadDescription;
  String get labelVideoDownloadDescription;
  String get labelInstantDescription;
  String get labelInstant;
  String get labelCurrentQuality;
  String get labelFastStreamingOptions;
  String get labelStreamingOptions;
  String get labelComments;
  String get labelPinned;
  String get labelLikedByAuthor;
  String get labelDescription;
  String get labelViews;
  String get labelPlayingNextIn;
  String get labelPlayNow;
  String get labelLoadingPlaylist;
  String get labelPlaylistReachedTheEnd;
  String get labelLiked;
  String get labelLike;
  String get labelVideoRemovedFromFavorites;
  String get labelVideoAddedToFavorites;
  String get labelPopupMode;
  String get labelDownloaded;
  String get labelShowPlaylist;
  String get labelCreatePlaylist;
  String get labelAddVideoToPlaylist;
  String get labelBackupDescription;
  String get labelBackupCreated;
  String get labelBackupRestored;
  String get labelRestoreDescription;
  String get labelChannelSuggestions;
  String get labelFetchingChannels;
  String get labelShareVideo;
  String get labelShareDescription;
  String get labelRemoveFromPlaylists;
  String get labelThisActionCannotBeUndone;
  String get labelAddVideoToPlaylistDescription;
  String get labelAddToPlaylists;
  String get labelEditableOnceSaved;
  String get labelPlaylistRemoved;
  String get labelPlaylistSaved;
  String get labelRemoveFromFavorites;
  String get labelRemoveFromFavoritesDescription;
  String get labelSaveToFavorites;
  String get labelSaveToFavoritesDescription;
  String get labelSharePlaylist;
  String get labelRemoveThisVideoFromThisList;
  String get labelEqualizer;
  String get labelLoudnessEqualizationGain;
  String get labelSliders;
  String get labelSave;
  String get labelPlaylistName;
  String get labelCreateVideoPlaylist;
  String get labelSearchFilters;
  String get labelAddToPlaylistDescription;
  String get labelShareSong;
  String get labelShareSongDescription;
  String get labelEditTagsDescription;
  String get labelContains;
  String get labelPlaybackSpeed;
}

// ----------------------------------------
// Methods To Get, Set an Save App Language
// ----------------------------------------

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Locale setLocale(String languageCode) {
  sharedPreferences.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Locale getLocale() {
  String languageCode =
      sharedPreferences.getString(prefSelectedLanguageCode) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var locale = setLocale(selectedLanguageCode);
  SongTube.setLocale(context, locale);
}
