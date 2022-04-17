import 'package:songtube/internal/languages.dart';

class LanguageCs extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Vítejte v";
  @override
  String get labelStart => "Začít";
  @override
  String get labelSkip => "Přeskočit";
  @override
  String get labelNext => "Další";
  @override
  String get labelExternalAccessJustification =>
    "Potřebuje přístup k vašemu externímu úložišti pro ukládání všech " +
    "vašich videí a hudby";
  @override
  String get labelAppCustomization => "Přizpůsobení";
  @override
  String get labelSelectPreferred => "Vyberte své preferované";
  @override
  String get labelConfigReady => "Konfigurace připravena";
  @override
  String get labelIntroductionIsOver => "Úvod je u konce";
  @override
  String get labelEnjoy => "Užijte si";
  @override 
  String get labelGoHome => "Domovská stránka";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Domů";
  @override
  String get labelDownloads => "Stahování";
  @override
  String get labelMedia => "Média";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Další";

  // Home Screen
  @override
  String get labelQuickSearch => "Rychlé hledání...";
  @override
  String get labelTagsEditor => "Editor\nštítků";
  @override
  String get labelEditArtwork => "Upravit\nobal";
  @override
  String get labelDownloadAll => "Stáhnout vše";
  @override 
  String get labelLoadingVideos => "Načítání videí...";
  @override
  String get labelHomePage => "Domovská stránka";
  @override
  String get labelTrending => "Trendy";
  @override
  String get labelFavorites => "Oblíbené";
  @override
  String get labelWatchLater => "Přehrát později";

  // Video Options Menu
  @override
  String get labelCopyLink => "Zkopírovat odkaz";
  @override
  String get labelAddToFavorites => "Přidat do oblíbených";
  @override
  String get labelAddToWatchLater => "Přidat do Přehrát později";
  @override
  String get labelAddToPlaylist => "Přidat do playlistu";

  // Downloads Screen
  @override
  String get labelQueued => "Ve frontě";
  @override
  String get labelDownloading => "Stahování";
  @override
  String get labelConverting => "Konvertování";
  @override
  String get labelCancelled => "Zrušeno";
  @override
  String get labelCompleted => "Dokončeno";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Stahování přidáno do fronty";
  @override
  String get labelDownloadAcesssDenied => "Přístup zamítnut";
  @override
  String get labelClearingExistingMetadata => "Mazání existujících metadat...";
  @override
  String get labelWrittingTagsAndArtwork => "Zapisování štítků a obalu...";
  @override
  String get labelSavingFile => "Ukládání souboru...";
  @override
  String get labelAndroid11FixNeeded => "Chyba, je potřeba oprava pro Android 11, viz nastavení";
  @override
  String get labelErrorSavingDownload => "Nepodařilo se uložit vaše stahování, zkontrolujte oprávnění";
  @override
  String get labelDownloadingVideo => "Stahování videa...";
  @override
  String get labelDownloadingAudio => "Stahování zvuku...";
  @override
  String get labelGettingAudioStream => "Načítání audio streamu...";
  @override
  String get labelAudioNoDataRecieved => "Nepodařilo se načíst audio stream";
  @override
  String get labelDownloadStarting => "Spouštění stahování...";
  @override
  String get labelDownloadCancelled => "Stahování zrušeno";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Proces konvertování selhal";
  @override
  String get labelPatchingAudio => "Záplatování zvuku...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Povolit konvertování zvuku";
  @override
  String get labelGainControls => "Ovládání zesílení";
  @override
  String get labelVolume => "Hlasitost";
  @override
  String get labelBassGain => "Zesílení basů";
  @override
  String get labelTrebleGain => "Zesílení výšek";
  @override
  String get labelSelectVideo => "Vyberat video";
  @override
  String get labelSelectAudio => "Vybrat zvuk";
  @override
  String get labelGlobalParameters => "Globální nastavení";

  // Media Screen
  @override
  String get labelMusic => "Hudba";
  @override
  String get labelVideos => "Videa";
  @override
  String get labelNoMediaYet => "Zatím žádná média";
  @override
  String get labelNoMediaYetJustification => "Všechna vaše média " +
    "budou zobrazena zde";
  @override
  String get labelSearchMedia => "Hledat média...";
  @override
  String get labelDeleteSong => "Odstranit skladbu";
  @override
  String get labelNoPermissionJustification => "Zobrazte svá média" + "\n" +
    "udělením přístupu k úložišti";
  @override
  String get labelGettingYourMedia => "Načítání médií...";
  @override
  String get labelEditTags => "Upravit štítky";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Hledat na YouTube...";

  // More Screen
  @override
  String get labelSettings => "Nastavení";
  @override
  String get labelDonate => "Přispějte";
  @override
  String get labelLicenses => "Licence";
  @override
  String get labelChooseColor => "Vyberte barvu";
  @override
  String get labelTheme => "Téma";
  @override
  String get labelUseSystemTheme => "Použít systémové téma";
  @override
  String get labelUseSystemThemeJustification =>
    "Povolit/zakázat automatické téma";
  @override
  String get labelEnableDarkTheme => "Povolit tmavé téma";
  @override
  String get labelEnableDarkThemeJustification =>
    "Použít tmavé téma jako výchozí";
  @override
  String get labelEnableBlackTheme => "Povolit černé téma";
  @override
  String get labelEnableBlackThemeJustification =>
    "Povolit čistě černé téma";
  @override
  String get labelAccentColor => "Obarvení";
  @override
  String get labelAccentColorJustification => "Přizpůsobit barvu aplikace";
  @override
  String get labelAudioFolder => "Složka zvuku";
  @override
  String get labelAudioFolderJustification => "Vyberte složku pro " +
    "stahování zvuku";
  @override
  String get labelVideoFolder => "Složka videí";
  @override
  String get labelVideoFolderJustification => "Vyberte složku pro " +
    "stahování videí";
  @override
  String get labelAlbumFolder => "Složka alb";
  @override
  String get labelAlbumFolderJustification => "Vytvořit složku pro album každé skladby";
  @override
  String get labelDeleteCache => "Vymazat mezipaměť";
  @override
  String get labelDeleteCacheJustification => "Vymazat mezipaměť SongTube";
  @override
  String get labelAndroid11Fix => "Oprava pro Android 11";
  @override
  String get labelAndroid11FixJustification => "Opraví problémy se stahováním na " +
    "Androidu 10 a 11";
  @override
  String get labelBackup => "Záloha";
  @override
  String get labelBackupJustification => "Zálohujte svou knihovnu médií";
  @override
  String get labelRestore => "Obnovit";
  @override
  String get labelRestoreJustification => "Obnovte svou knihovnu médií";
  @override
  String get labelBackupLibraryEmpty => "Vaše knihovna je prázdná";
  @override
  String get labelBackupCompleted => "Záloha dokončena";
  @override
  String get labelRestoreNotFound => "Obnovení nenalezeno";
  @override
  String get labelRestoreCompleted => "Obnovení dokončeno";
  @override
  String get labelCacheIsEmpty => "Mezipaměť je prázdná";
  @override
  String get labelYouAreAboutToClear => "Chystáte se vymazat";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Název";
  @override
  String get labelEditorArtist => "Umělec";
  @override
  String get labelEditorGenre => "Žánr";
  @override
  String get labelEditorDisc => "Disk";
  @override
  String get labelEditorTrack => "Skladba";
  @override
  String get labelEditorDate => "Datum";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Detekován Android 10 nebo 11";
  @override
  String get labelAndroid11DetectedJustification => "Pro zajištění správné " +
    "funkčnosti stahování v této aplikaci může být na Androidu 10 a 11 vyžadován " +
    "přístup ke všem souborům. Toto bude v nadcházejících aktualizacích dočasné " +
    "a volitelné. Tuto opravu lze také použít v nastavení.";

  // Music Player
  @override
  String get labelPlayerSettings => "Nastavení přehrávače";
  @override
  String get labelExpandArtwork => "Rozšířit obal";
  @override
  String get labelArtworkRoundedCorners => "Zaoblené rohy obalu";
  @override
  String get labelPlayingFrom => "Přehrávání z";
  @override
  String get labelBlurBackground => "Rozmazat pozadí";

  // Video Page
  @override
  String get labelTags => "Štítky";
  @override
  String get labelRelated => "Souvistející";
  @override
  String get labelAutoPlay => "Automatické přehrávání";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formát zvuku není kompatibilní";
  @override
  String get labelNotSpecified => "Neurčeno";
  @override
  String get labelPerformAutomaticTagging => 
    "Provést automatické tagování";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Vybrat tagy z MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Vybrat obal ze zařízení";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Připojte se na náš Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Líbí se vám SongTube? Připojte se do našeho Telegram kanálu! Najdete tam " +
    "aktualizace, informace, vývoj, odkaz na skupinu a další sociální odkazy." +
    "\n\n" +
    "Pokud máte v hlavě problém nebo dobré doporučení, připojte se do naší " +
    "skupiny z kanálu a napište to tam! Nezapomeňte ale prosím, že " +
    "můžete mluvit pouze anglicky. Díky!";
  @override
  String get labelRemindLater => "Připomenout později";

  // Common Words (One word labels)
  @override
  String get labelExit => "Opustit";
  @override
  String get labelSystem => "Systém";
  @override
  String get labelChannel => "Kanál";
  @override
  String get labelShare => "Sdílet";
  @override
  String get labelAudio => "Zvuk";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Stáhnout";
  @override
  String get labelBest => "Nejlepší";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Verze";
  @override
  String get labelLanguage => "Jazyk";
  @override
  String get labelGrant => "Udělit";
  @override
  String get labelAllow => "Povolit";
  @override
  String get labelAccess => "Přístup";
  @override
  String get labelEmpty => "Prázdné";
  @override
  String get labelCalculating => "Vypočítávání";
  @override
  String get labelCleaning => "Mazání";
  @override
  String get labelCancel => "Zrušit";
  @override
  String get labelGeneral => "Obecné";
  @override
  String get labelRemove => "Odebrat";
  @override
  String get labelJoin => "Připojit se";
  @override
  String get labelNo => "Ne";
  @override
  String get labelLibrary => "Knihovna";
  @override
  String get labelCreate => "Vytvořit";
  @override
  String get labelPlaylists => "Playlisty";
  @override
  String get labelQuality => "Kvalita";
  @override
  String get labelSubscribe => "Odebírat";
}
