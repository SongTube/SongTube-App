import 'package:songtube/internal/languages.dart';

class LanguageIgbo extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "nabata";
  @override
  String get labelStart => "Malite";
  @override
  String get labelSkip => "Mafere";
  @override
  String get labelNext => "Osote";
  @override
  String get labelExternalAccessJustification =>
    "Achọrọ ịnweta Nchekwa Mpụga gị iji chekwaa ihe niile" +
    "vidiyo gị na egwu";
  @override
  String get labelAppCustomization => "Nhazi";
  @override
  String get labelSelectPreferred => "Họrọ gị họọrọ";
  @override
  String get labelConfigReady => "Dozie njikere";
  @override
  String get labelIntroductionIsOver => "Okwu mmeghe agwula";
  @override
  String get labelEnjoy => "Kporie";
  @override 
  String get labelGoHome => "Laa n'ụlọ";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Ulo";
  @override
  String get labelDownloads => "Nbudata";
  @override
  String get labelMedia => "Mgbasa ozi";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Ọzọ";

  // Home Screen
  @override
  String get labelQuickSearch => "Ndenye Search...";
  @override
  String get labelTagsEditor => "Mkpado\nnOdechukwu";
  @override
  String get labelEditArtwork => "Nka";
  @override
  String get labelDownloadAll => "Budata Ha niile";
  @override 
  String get labelLoadingVideos => "Na-adọnye vidiyo...";

  // Downloads Screen
  @override
  String get labelQueued => "Kwadoro";
  @override
  String get labelDownloading => "Na-ebudata";
  @override
  String get labelConverting => "Na-atụgharị";
  @override
  String get labelCancelled => "Kagbuo";
  @override
  String get labelCompleted => "Emechara";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Budata Kwuru";
  @override
  String get labelDownloadAcesssDenied => "Ajụrụ nnweta";
  @override
  String get labelClearingExistingMetadata => "Ikpocha Metadata dị...";
  @override
  String get labelWrittingTagsAndArtwork => "Ederede Mkpado & Nka...";
  @override
  String get labelSavingFile => "Na-echekwa faịlụ...";
  @override
  String get labelAndroid11FixNeeded => "Njehie, Gam akporo 11 Idozi dị mkpa, lelee Ntọala";
  @override
  String get labelErrorSavingDownload => "Enweghi ike ịchekwa nbudata gị, lelee Ikike";
  @override
  String get labelDownloadingVideo => "Nbudata Vidio...";
  @override
  String get labelDownloadingAudio => "Nbudata Audio...";
  @override
  String get labelGettingAudioStream => "Inweta Audio iyi...";
  @override
  String get labelAudioNoDataRecieved => "Enweghi ike inweta Audio iyi";
  @override
  String get labelDownloadStarting => "Ibido nbudata...";
  @override
  String get labelDownloadCancelled => "Budata Kagbuo";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Usoro atugharị dara";
  @override
  String get labelPatchingAudio => "Ịmachi Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Kwado Ntughari Audio";
  @override
  String get labelGainControls => "Nweta Njikwa";
  @override
  String get labelVolume => "Mpịakọta";
  @override
  String get labelBassGain => "Inweta Bass";
  @override
  String get labelTrebleGain => "Inweta Treble";
  @override
  String get labelSelectVideo => "Họrọ Vidio";
  @override
  String get labelSelectAudio => "Họrọ Audio";

  // Media Screen
  @override
  String get labelMusic => "Egwu";
  @override
  String get labelVideos => "Vidio";
  @override
  String get labelNoMediaYet => "Enweghị Media Ma";
  @override
  String get labelNoMediaYetJustification => "Mgbasa ozi gị niile" +
    "a ga-egosi ebe a";
  @override
  String get labelSearchMedia => "Chọọ Mgbasa ozi...";
  @override
  String get labelDeleteSong => "Hichapụ Abụ";
  @override
  String get labelNoPermissionJustification => "Lelee Mgbasa ozi gị site na" + "\n" +
    "Inye ikike ikike nchekwa";
  @override
  String get labelGettingYourMedia => "Inweta Mgbasa ozi gị...";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Chọọ YouTube...";

  // More Screen
  @override
  String get labelSettings => "Ntọala";
  @override
  String get labelDonate => "Nye onyinye";
  @override
  String get labelLicenses => "Akwụkwọ ikike";
  @override
  String get labelChooseColor => "Họrọ Agba";
  @override
  String get labelTheme => "Okwu";
  @override
  String get labelUseSystemTheme => "Jiri usoro sistemụ";
  @override
  String get labelUseSystemThemeJustification =>
    "Kwado / Gbanyụọ akpaka Okwu";
  @override
  String get labelEnableDarkTheme => "Kwadoro Okwu Ochichiri";
  @override
  String get labelEnableDarkThemeJustification =>
    "Jiri Okwu Ochichiri jiri ndabara";
  @override
  String get labelEnableBlackTheme => "Kwadoro Okwu Oji";
  @override
  String get labelEnableBlackThemeJustification =>
    "Kwadoro Okwu Oji";
  @override
  String get labelAccentColor => "Agba ngwoolu";
  @override
  String get labelAccentColorJustification => "Hazie ụda olu agba";
  @override
  String get labelAudioFolder => "Audio nchekwa";
  @override
  String get labelAudioFolderJustification => "Họrọ nchekwa maka " +
    "Nbudata ihe";
  @override
  String get labelVideoFolder => "Nchekwa vidio";
  @override
  String get labelVideoFolderJustification => "Họrọ nchekwa maka " +
    "budata vidio ";
  @override
  String get labelAlbumFolder => "Nchekwa Album";
  @override
  String get labelAlbumFolderJustification => "Mepụta nchekwa maka Abụ egwu ọ bụla";
  @override
  String get labelDeleteCache => "Hichapụ Cache";
  @override
  String get labelDeleteCacheJustification => "Hichapụ SongTube Cache";
  @override
  String get labelAndroid11Fix => "Gam akporo 11 Idozi";
  @override
  String get labelAndroid11FixJustification => "Ndozi Budata okwu na " +
    "A gam akporo 10 & 11";
  @override
  String get labelBackup => "Ndabere";
  @override
  String get labelBackupJustification => "Weghachite ọba akwụkwọ mgbasa ozi gị";
  @override
  String get labelRestore => "Weghachi";
  @override
  String get labelRestoreJustification => "Weghachi ọba akwụkwọ mgbasa ozi gị";
  @override
  String get labelBackupLibraryEmpty => "Ulo akwukwo gi abughi ihe efu";
  @override
  String get labelBackupCompleted => "Ndabere Emechara";
  @override
  String get labelRestoreNotFound => "Weghachi Ahụghị";
  @override
  String get labelRestoreCompleted => "Weghachi dechara";
  @override
  String get labelCacheIsEmpty => "Cache bụ Ihe efu";
  @override
  String get labelYouAreAboutToClear => "Na-achọ ikpochapụ";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Aha";
  @override
  String get labelEditorArtist => "Omenkà";
  @override
  String get labelEditorGenre => "Dị";
  @override
  String get labelEditorDisc => "Disc";
  @override
  String get labelEditorTrack => "Sochie";
  @override
  String get labelEditorDate => "Datebọchị";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Achọpụtara gam akporo 10 ma ọ bụ 11";
  @override
  String get labelAndroid11DetectedJustification => "Iji hụ na ihe ziri ezi" +
    "ịrụ ọrụ nke ngwa a Nbudata, na gam akporo 10 na 11, ịnweta mmadụ niile " +
    "Enwere ike ịnweta ikikere faịlụ, nke a ga-abụ nke oge na-achọghị " +
    "na mmelite n'ọdịnihu. I nwekwara ike itinye ndozi a na Ntọala.";

  // Common Words (One word labels)
  @override
  String get labelExit => "Ụzọ ọpụpụ";
  @override
  String get labelSystem => "Sistemụ";
  @override
  String get labelChannel => "Ọwa";
  @override
  String get labelShare => "Kee";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Vidio";
  @override
  String get labelDownload => "Budata";
  @override
  String get labelBest => "Kacha mma";
  @override
  String get labelPlaylist => "Ndetuta egwu";
  @override
  String get labelVersion => "Versiondị";
  @override
  String get labelLanguage => "Asụsụ";
  @override
  String get labelGrant => "Nye";
  @override
  String get labelAllow => "Kwe ka";
  @override
  String get labelAccess => "Nweta";
  @override
  String get labelEmpty => "Efu";
  @override
  String get labelCalculating => "Na-eme atụmatụ";
  @override
  String get labelCleaning => "Nhicha";
  @override
  String get labelCancel => "Kagbuo";

}
